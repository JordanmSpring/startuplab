# For allowing CORS on asset calls
Rails.application.config.middleware.insert_before 0, 'Rack::Cors' do
  allow do
    origins '*'

    resource '/assets/*',
      headers: :any,
      methods: [:get]
  end
end
