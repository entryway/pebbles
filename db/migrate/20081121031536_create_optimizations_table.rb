class CreateOptimizationsTable < ActiveRecord::Migration
  def self.up
    create_table :optimizations do |t|
      t.string :title
      t.text :keywords
      t.description :description
    end
  end

  def self.down
    drop_table :optimizations
  end
end
