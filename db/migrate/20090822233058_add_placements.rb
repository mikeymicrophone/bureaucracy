class AddPlacements < ActiveRecord::Migration
  def self.up
    create_table :placements do |t|
      t.integer :room_id
      t.integer :belonging_id
      t.integer :user_id
      t.boolean :current, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :placements
  end
end
