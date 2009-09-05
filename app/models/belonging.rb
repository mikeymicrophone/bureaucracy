class Belonging < ActiveRecord::Base
  belongs_to :user
  has_many :storages
  has_many :placements
  has_one :storage_unit
  
  def building
    room.andand.building
  end
  
  def room
    placements.current.last.andand.room || storage_unit.andand.belonging.andand.room
  end
end
