class ConvertMigrationSchemaToRails21 < ActiveRecord::Migration
  def self.up
    # values = select_values('select id from migrations_info')
    #    values.each {|value| execute("insert into schema_migrations VALUES('#{value}')")}
    #    drop_table :migrations_info
  end

  def self.downf
  end
end
