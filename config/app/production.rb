App.configure do
  config.raise_mail_delivery_errors = false

  config.smtp_settings = {
    port:            '587',
    address:         'smtp.sendgrid.net',
    user_name:       ENV['SENDGRID_USERNAME'],
    password:        ENV['SENDGRID_PASSWORD'],
    authentication:  :plain
  }

  # Don't log redis in the application log.
  config.log_redis = false
end
