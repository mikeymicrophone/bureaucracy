class Storage < ActiveRecord::Base
  belongs_to :storage_unit
  belongs_to :belonging
  belongs_to :user
end
