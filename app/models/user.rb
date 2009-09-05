class User < ActiveRecord::Base
  acts_as_authentic
  has_many :belongings
  has_many :rooms
  has_many :storage_units
  has_many :storages
  
  def storage_buildings
    belongings.map(&:building).compact
  end
end
