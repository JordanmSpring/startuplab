class GravatarUrlGenerator
  GRAVATAR_URL = "http://gravatar.com/avatar"

  def initialize(email)
    @email = email
  end

  def generate(options = {})
    hash = Digest::MD5.hexdigest(@email)
    "#{GRAVATAR_URL}/#{hash}#{option_str(options)}"
  end

  private
    def option_str(options)
      return "" if options.empty?
      "".tap do |str|
        str << "?"
        str << options.map { |(key, val)| "#{key}=#{val}" }.join('&')
      end
    end
end
