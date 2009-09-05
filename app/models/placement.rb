class Placement < ActiveRecord::Base
  belongs_to :room
  belongs_to :belonging
  
  named_scope :current, :conditions => {:current => true}
end
