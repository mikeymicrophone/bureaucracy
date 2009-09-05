class StorageUnitBelongsToBelonging < ActiveRecord::Migration
  def self.up
    add_column :storage_units, :belonging_id, :integer
  end

  def self.down
    remove_column :storage_units, :belonging_id
  end
end
