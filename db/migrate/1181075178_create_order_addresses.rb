class CreateOrderAddresses < ActiveRecord::Migration
  def self.up
    create_table :order_addresses do |t|
      t.column "order_id",            :integer      
      t.column "address_1",           :string,   :limit => 50
      t.column "address_2",           :string,   :limit => 50
      t.column "city",                :string,   :limit => 50
      t.column "state",               :string,   :limit => 2
      t.column "postal_code",         :string,   :limit => 10
      t.column "is_shipping",         :boolean
    end
  end

  def self.down
    drop_table :order_addresses
  end
end
