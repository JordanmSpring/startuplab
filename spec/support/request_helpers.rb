require 'digest/sha1'

module RequestHelpers
  def do_post(path, opts = {})
    make_request :post, path, opts
  end

  def do_patch(path, opts = {})
    make_request :patch, path, opts
  end

  def do_get(path, opts = {})
    make_request :get, path, opts
  end

  def do_put(path, opts = {})
    make_request :put, path, opts
  end

  def do_delete(path, opts = {})
    make_request :delete, path, opts
  end

  def json_body
    JSON.parse(response.body)
  end

  def authenticate_heroku(user = ENV['HEROKU_USERNAME'], pass = ENV['HEROKU_PASSWORD'])
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
  end

  def authenticate_app(heroku_app, token = nil)
    Timecop.freeze(Time.local(2015))
    token ||= sso_token(heroku_app)
    do_get "/heroku/resources/#{heroku_app.to_param}", token: token, timestamp: Time.zone.now.to_i
    Timecop.return
  end

  def sso_token(heroku_app)
    Digest::SHA1.hexdigest("#{heroku_app.slug}:#{ENV['SSO_SALT']}:#{Time.zone.now.to_i}")
  end

  private

  def make_request(method, path, opts)
    env = opts.delete(:env) || @env || {}
    send(method, path, opts, env)
  end
end
