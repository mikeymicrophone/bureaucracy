class User < ActiveRecord::Base
  acts_as_authentic
  has_many :belongings
  has_many :rooms
  has_many :storage_units
  has_many :storages
  has_many :lists
  has_many :friendships, :conditions => {:status => 'accepted'}
  has_many :requested_friendships, :conditions => {:status => 'accepted'}, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :accepting_friends, :through => :friendships, :source => :friend
  has_many :accepted_friends, :through => :requested_friendships, :source => :user
  
  after_create :create_default_lists
  
  def friends
    accepting_friends + accepted_friends
  end
  
  def friends_with? other
    Friendship.find_by_user_id_and_friend_id(id, other.id) || Friendship.find_by_user_id_and_friend_id(other.id, id)
  end
  
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
