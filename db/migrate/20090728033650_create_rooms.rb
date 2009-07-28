class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :name
      t.integer :user_id
      t.float :height
      t.float :width
      t.float :length
      t.integer :floor
      t.integer :doors
      t.integer :windows
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
