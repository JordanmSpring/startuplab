require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Startuplab
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    #config.angular_html2js.module_name = 'templates'

    # Treat angular.js templates as assets.
    config.assets.paths << File.join(Rails.root, 'app', 'assets', 'templates')

    # Don't quote decimals in JSON responses, because it breaks angular number input fields.
    ActiveSupport::JSON::Encoding.encode_big_decimal_as_string = false

    # Use sidekiq as the ActiveJob queue adapter.
    config.active_job.queue_adapter = :sidekiq

    # Devise layouts.
    config.to_prepare do
      Devise::SessionsController.layout      'devise'
      Devise::RegistrationsController.layout 'devise'
      Devise::ConfirmationsController.layout 'devise'
      Devise::UnlocksController.layout       'devise'
      Devise::PasswordsController.layout     'devise'
    end
  end
end
