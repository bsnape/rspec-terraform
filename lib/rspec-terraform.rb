require 'bundler/setup'

require_relative 'rspec-terraform/version'

RSpec.configure do |config|

  config.before(:each, provider: :aws) do
    ENV['TF_VAR_access_key'] = 'foo'
    ENV['TF_VAR_secret_key'] = 'bar'
  end

end
