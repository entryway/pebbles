class AddStateAndAmountToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :state,  :string, :default => :pending
    add_column :orders, :amount, :integer
    remove_column :orders, :error_message
    remove_column :orders, :payment_reference_number
    remove_column :orders, :status
    remove_column :orders, :payment_authorization_code
  end

  def self.down
  end
end
