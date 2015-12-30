ActionMailer::Base.raise_delivery_errors = App.raise_mail_delivery_errors
ActionMailer::Base.perform_deliveries    = App.mailer_perform_deliveries
ActionMailer::Base.default_url_options   = App.mailer_default_url_options
ActionMailer::Base.delivery_method       = :smtp
ActionMailer::Base.smtp_settings         = App.smtp_settings
