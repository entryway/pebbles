class ChangeColumnNameInProducts < ActiveRecord::Migration
  def self.up
    change_column :products, :name, :string, :limit => 255
  end

  def self.down
  end
end
