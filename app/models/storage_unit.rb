class StorageUnit < ActiveRecord::Base
  belongs_to :user
  belongs_to :belonging
  has_many :storages
  has_many :belongings, :through => :storages
  
  before_create :create_belonging
  
  def create_belonging
    self.belonging = Belonging.find_or_create_by_name_and_user_id(:name => name, :user_id => user_id)
  end
  
  def placements
    belonging.placements
  end
  
  def room
    belonging.room
  end
end
