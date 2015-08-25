require 'spec_helper'

describe RSpec::Terraform do
  it 'has a version number' do
    expect(RSpec::Terraform::VERSION).not_to be nil
  end

  it 'creates terraform environment variables for AWS providers', provider: :aws do
    expect(ENV['TF_VAR_access_key']).to eq 'foo'
    expect(ENV['TF_VAR_secret_key']).to eq 'bar'
  end
end
