# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bureacracy_session',
  :secret      => 'd823108930b291cf3924572ae05bc2c7fa80f75997c07daf084401eeb754f96a83fffcc7fac020c55b433e8950d21457753c9b78998a90909f5ff382a12e9e8f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
