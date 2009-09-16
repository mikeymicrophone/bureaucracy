class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  
  def friends
    [user, friend]
  end
  
  def accept
    update_attribute(:status, 'accepted')
  end
  
  def reject
    update_attribute(:status, 'rejected')
  end
end
