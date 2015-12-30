Sidekiq.configure_server do |config|
  url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/'
  config.redis = { url: url, size: 9 }
end

Sidekiq.configure_client do |config|
  url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/'
  config.redis = { url: url, size: 1 }
end

# This must happen after the redis config above, otherwise it fails on heroku
# while looking for redis on localhost:6379.
require 'sidekiq/scheduler'
Sidekiq.schedule = YAML.load_file(File.expand_path('../../../config/scheduler.yml', __FILE__))
