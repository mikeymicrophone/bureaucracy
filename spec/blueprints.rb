require 'machinist/active_record'
require 'sham'
require 'faker'

def find_or_make(klass, count = 1, blueprint = nil)
  existing = klass.send(:find, :all, :limit => count)
  if existing.length == count
    usable = existing
  else
    usable = (1..count).map { klass.send(:make, blueprint) }
  end
  if count == 1
    usable.first
  else
    usable
  end
end

User.blueprint do
  login { Faker::Internet.user_name }
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
end

StorageUnit.blueprint do
  name { Faker::Lorem.words(1) }
  user { find_or_make(User) }
end