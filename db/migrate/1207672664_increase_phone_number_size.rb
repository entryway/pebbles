class IncreasePhoneNumberSize < ActiveRecord::Migration
  def self.up
    change_column :orders, :phone_number, :string, :limit => 50
  end

  def self.down
  end
end
