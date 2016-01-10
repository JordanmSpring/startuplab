require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  # Fix 'Factory not registered' problem (http://bit.ly/1G6BFQ5).
  config.before(:all) do
    FactoryGirl.reload
  end
end
