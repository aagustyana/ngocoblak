# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_etsy_test_session',
  :secret      => '19439a036ba1ab593f059b2f8ba1aa505ab327aa35913cb4ef3bccd4ece1799d93e34fbdb9e8881c39d804dee956c83fb63ac6156b45538844951a966f6af9db'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
