class AddStorages < ActiveRecord::Migration
  def self.up
    create_table :storages do |t|
      t.integer :storage_unit_id
      t.integer :belonging_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :storages
  end
end
