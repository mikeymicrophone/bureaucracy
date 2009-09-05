class Room < ActiveRecord::Base
  belongs_to :user
  belongs_to :building
  has_many :placements
  has_many :placed_belongings, :through => :placements, :source => :belonging
  
  def belongings
    placed_belongings + stored_belongings
  end
  
  def storage_units
    StorageUnit.find(:all, :conditions => {:belonging_id => (placed_belongings.map(&:id))})
  end
  
  def stored_belongings
    storage_units.map(&:belongings).flatten
  end
end
