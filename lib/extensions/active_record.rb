class ActiveRecord::Base
  def map_name_and_id
    map { |r| [r.name, r.id] }
  end
end