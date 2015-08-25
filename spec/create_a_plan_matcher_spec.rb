describe 'create a plan matcher' do

  it 'expects plan.tf and terraform.tfstate to exist in the root directory' do
    File.new('plan.tf', 'w+')
    File.new('terraform.tfstate', 'w+')
    expect { expect('').to create_a_plan }.not_to output.to_stderr_from_any_process
    File.delete 'plan.tf'
    File.delete 'terraform.tfstate'
  end

  context 'when plan.tf does not exist in the root directory' do
    before do
      File.new('terraform.tfstate', 'w+')
    end

    it 'raises an RSpec ExpectationNotMetError error' do
      expect { expect('').to create_a_plan }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    after do
      File.delete 'terraform.tfstate'
    end
  end

  context 'when terraform.tfstate does not exist in the root directory' do
    before do
      File.new('plan.tf', 'w+')
    end

    it 'raises an RSpec ExpectationNotMetError error' do
      expect { expect('').to create_a_plan }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    after do
      File.delete 'plan.tf'
    end
  end

  it 'returns the terraform output when it errors' do
    expect { expect('terraform plan foo').to create_a_plan }.to raise_error(RSpec::Expectations::ExpectationNotMetError).with_message(/Error loading config: open foo: no such file or directory/)
  end
end
