require 'bundler/setup'
require 'rspec/expectations'
require 'open3'
require 'rspec'

require_relative 'rspec-terraform/version'
require_relative 'rspec-terraform/matchers/create_a_plan'
require_relative 'rspec-terraform/matchers/require_variables'

RSpec.configure do |config|
  # https://github.com/hashicorp/terraform/pull/2730
  # Correct credentials must be provided
  config.before(:all, provider: :aws) do
    unless ENV['TF_VAR_access_key'] && ENV['TF_VAR_secret_key'] && ENV['TF_VAR_region']
      fail 'You must provide your AWS credentials and region as environment variables: '\
      "'TF_VAR_access_key', 'TF_VAR_secret_key', 'TF_VAR_region'"
    end
  end

  config.after(:each, provider: :aws) do
    cleanup!
  end

  def cleanup!
    `rm -f plan.tf`
    `rm -f terraform.tfstate`
    `rm -f provider.tf`
  end
end
