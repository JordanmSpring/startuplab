source 'https://rubygems.org'

ruby '2.2.2'

gem 'activeadmin',                  github: 'activeadmin'
gem 'active_model_serializers',     '~> 0.9.3'
gem 'activesupport-json_encoder'
gem 'angular_rails_csrf',           '~> 1.0.4'
gem 'angular-rails-templates'
gem 'app'
gem 'devise'
gem 'devise_invitable',             '~> 1.5.2'
gem 'font-awesome-rails'
gem 'gon'
gem 'htmltoword',                   github: 'recurser/htmltoword', branch: 'feature/adjust-styling'
gem 'jbuilder',                     '~> 2.0'
gem 'nokogiri'                      # Required by premailer-rails.
gem 'pg'
gem 'premailer-rails'
gem 'puma'
gem 'pundit'
gem 'rails',                        '4.2.3'
gem 'rakismet'
gem 'responders'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sinatra',                      require: nil # For sidekiq admin.
gem 'stripe'
gem 'stripe_event'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'omniauth-twitter'
gem 'thumbs_up'

# Assets
gem 'bower-rails'
gem 'coffee-rails',                 '~> 4.1.0'
gem 'haml'
gem 'jquery-rails'
gem 'redcarpet'
gem 'sass-rails',                   '~> 5.0'
gem 'turbolinks'
gem 'uglifier',                     '>= 1.3.0'

group :development do
  gem 'pry'
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'spring'
  gem 'web-console',                '~> 2.0'
end

group :test do
  gem 'test_after_commit'               # Note - will not be needed in rails 5.
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'phantomjs',                      require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webmock',                        require: false
end

group :production do
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc'
end
