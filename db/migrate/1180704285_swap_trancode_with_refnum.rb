class SwapTrancodeWithRefnum < ActiveRecord::Migration
  def self.up
    add_column :orders, :payment_reference_number, :string
    remove_column :orders, :payment_transaction_code
  end

  def self.down
    remove_column :orders, :payment_reference_number
    add_column :orders, :payment_transaction_code, :string
  end

end
