class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :belongings, :through => :list_items
end
