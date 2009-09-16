class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :belonging
  belongs_to :user
end
