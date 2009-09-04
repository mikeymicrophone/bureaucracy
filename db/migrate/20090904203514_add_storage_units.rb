class AddStorageUnits < ActiveRecord::Migration
  def self.up
    create_table :storage_units do |t|
      t.string :name
      t.integer :parent_id
      t.string :width
      t.string :height
      t.string :depth
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :storage_units
  end
end
