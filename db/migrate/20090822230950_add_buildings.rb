class AddBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.string :name
      t.string :address
      t.integer :street_id
      t.integer :floors
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :buildings
  end
end
