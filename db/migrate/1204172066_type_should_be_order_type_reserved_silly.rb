class TypeShouldBeOrderTypeReservedSilly < ActiveRecord::Migration
  def self.up
    rename_column :orders, :type, :order_type
  end

  def self.down
  end
end
