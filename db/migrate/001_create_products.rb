class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :title,        :string
      t.column :subtitle,     :string
      t.column :description,  :text
    end
  end

  def self.down
    drop_table :products
  end
end
