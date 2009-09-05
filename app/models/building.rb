class Building < ActiveRecord::Base
  belongs_to :user
  has_many :rooms

  def belongings
    rooms.map(&:belongings)
  end
end
