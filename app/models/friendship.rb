class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  
  named_scope :accepted, :conditions => {:status => 'accepted'}
  named_scope :rejected, :conditions => {:status => 'rejected'}
  named_scope :requested, :conditions => {:status => nil}
  
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
