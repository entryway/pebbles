class AddTransactionAuthorizationCodes < ActiveRecord::Migration
  def self.up
    add_column :orders, :payment_authorization_code, :string
    add_column :orders, :payment_transaction_code, :string
  end
  

  def self.down
    remove_column  :orders,  :payment_authorization_code
    remove_column  :orders,  :payment_transaction_code
  end

end
