module OrderStateMachine
  
  def self.included(base)
    base.class_eval do 
      aasm_column :state
      aasm_initial_state :pending

      aasm_state :pending 
      aasm_state :authorized
      aasm_state :paid, :enter => :decrease_inventory 
      aasm_state :payment_declined 
      aasm_state :refunded
      aasm_state :disputed
      aasm_state :shipping_delayed
      aasm_state :fulfilled
      aasm_state :shipped
      aasm_state :issue

      # state events 
      aasm_event :payment_authorized do
        transitions :from => :pending,
                    :to => :authorized

        transitions :from => :payment_declined,
                    :to => :authorized
      end

      aasm_event :payment_captured do
        transitions :from => :authorized,
                    :to   => :paid
      end

      aasm_event :transaction_declined do
        transitions :from => :pending,
                    :to   => :payment_declined

        transitions :from => :payment_declined,
                    :to   => :payment_declined
                    
        transitions :from => :authorized,
                    :to   => :payment_declined
        
      end

      aasm_event :issue_raised do
        transitions :from => :pending,
                    :to => :issue

        transitions :from => :paid,
                    :to => :issue

        transitions :from => :authorized, 
                    :to => :issue
      end

      aasm_event :shipping_fulfilled do
        transitions :from => :paid,
                    :to => :fulfilled

        transitions :from => :pending,
                    :to => :fulfilled

        transitions :from => :fulfilled,
                    :to => :fulfilled

        transitions :from => :shipping_delayed,
                    :to => :fulfilled
      end

      aasm_event :shipping_delayed do
        transitions :from => :pending,
                    :to => :shipping_delayed

        transitions :from => :paid,
                    :to => :shipping_delayed
      end
    end
  end
  
  def decrease_inventory
    Inventory.new.decrease_order_inventory(self)
  end
  
end
