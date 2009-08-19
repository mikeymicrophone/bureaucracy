class CreateBelongings < ActiveRecord::Migration
  def self.up
    create_table :belongings do |t|
      t.text :name
      t.text :description
      t.float :weight
      t.string :height, :width, :length
      t.datetime :purchased_at
      t.float :price
      t.belongs_to :user
    end
  end

  def self.down
    drop_table :belongings
  end
end
