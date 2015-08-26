describe 'create a plan matcher' do

  it 'expects plan.tf and terraform.tfstate to exist in the root directory' do
    create_plan_file
    create_state_file
    expect { expect('').to create_a_plan }.not_to output.to_stderr_from_any_process
    delete_plan_file
    delete_state_file
  end

  context 'when plan.tf does not exist in the root directory' do
    before do
      create_state_file
    end

    it 'raises an RSpec ExpectationNotMetError error' do
      expect { expect('').to create_a_plan }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    after do
      delete_state_file
    end
  end

  context 'when terraform.tfstate does not exist in the root directory' do
    before do
      create_plan_file
    end

    it 'raises an RSpec ExpectationNotMetError error' do
      expect { expect('').to create_a_plan }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    after do
      delete_plan_file
    end
  end

  it 'returns the terraform output when it errors' do
    error         = RSpec::Expectations::ExpectationNotMetError
    error_message = /Error loading config: open foo: no such file or directory/
    expect { expect('terraform plan foo').to create_a_plan }.to raise_error(error).with_message(error_message)
  end
end

def create_plan_file
  File.new('plan.tf', 'w+')
end

def create_state_file
  File.new('terraform.tfstate', 'w+')
end

def delete_plan_file
  File.delete 'plan.tf'
end

def delete_state_file
  File.delete 'terraform.tfstate'
end
