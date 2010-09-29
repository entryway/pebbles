# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fixture_rails_root_session',
  :secret      => '689427bdbe058bf177815ae01519b220bbf2a164efcc01bf0d71b44a8236a2ea0553fb70cf274390382e357bfcc8389f677bf9f5a380ed3604782451c414d693'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
