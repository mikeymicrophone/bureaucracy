class StorageUnit < ActiveRecord::Base
  belongs_to :user
  has_many :storages
  
  after_create :create_belonging
  
  def create_belonging
    Belonging.create(:name => name, :user_id => user_id)
  end
end
