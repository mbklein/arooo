# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wwrunner_session',
  :secret      => '6e7466b34103a63bf573a4df2e18ba2b7c7975f042242f8188d48dbbd2965860a9bbee10ebf1ba86bffb9b38061309b06453dd049ef33e897796782694a2d73b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
