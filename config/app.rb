# Base application configuration.
class App < Configurable # :nodoc:
  # Whether or not to attempt to deliver emails.
  config.mailer_perform_deliveries = true

  # Default host for sending emails.
  config.mailer_default_url_options = { host: 'startuplab.singlepartners.io' }

  # Log redis in the application log.
  config.log_redis = true
end
