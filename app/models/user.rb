class User < ActiveRecord::Base
  acts_as_authentic
  has_many :belongings
  has_many :rooms
  has_many :storage_units
  has_many :storages
  has_many :lists
  
  after_create :create_default_lists
  
  def storage_buildings
    belongings.map(&:building).compact.uniq
  end
  
  def storage_storage_units
    belongings.map(&:storage_units).flatten.uniq
  end
  
  def storage_rooms
    belongings.map(&:room).uniq
  end
  
  def create_default_lists
    lists.create(:name => 'Things I want to use more')
    lists.create(:name => 'Things I want to use this weekend')
  end
end
