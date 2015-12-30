Sidekiq.configure_server do |config|
  url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/'
  config.redis = { url: url, size: 9 }
end

Sidekiq.configure_client do |config|
  url = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/'
  config.redis = { url: url, size: 1 }
end
