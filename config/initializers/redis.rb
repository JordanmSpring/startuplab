class Redis
  def self.connect!
    opts = { url: ENV["REDISTOGO_URL"] || "redis://localhost:6379/#{Rails.env.test? ? 1 : 0}" }

    opts[:logger] = Rails.logger if App.log_redis

    Redis.current = Redis.new(opts)
  end
end

Redis.connect!
