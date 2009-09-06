class Belonging < ActiveRecord::Base
  belongs_to :user
  has_many :storages
  has_many :placements
  has_many :storage_units, :through => :storages
  has_one :storage_unit
  
  def building
    room.andand.building
  end
  
  def room
    placements.current.last.andand.room || storage_units.last.andand.room
  end
  
  def place_in room
    placements.create :room => room
  end
end
