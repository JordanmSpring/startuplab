App.configure do
  config.raise_mail_delivery_errors = false

  # Default host for sending emails.
  config.mailer_default_url_options = { host: 'startuplab-staging.herokuapp.com' }

  config.smtp_settings = {
    port:            '587',
    address:         'smtp.sendgrid.net',
    user_name:       ENV['SENDGRID_USERNAME'],
    password:        ENV['SENDGRID_PASSWORD'],
    authentication:  :plain
  }

  # Don't log redis in the application log.
  config.log_redis = false

  # Omniauth accounts.
  config.facebook_app_id = '158229161209989'
  config.twitter_api_key = '0t4z2ShioLDoJiTw6wmjTg9Zy'
end
