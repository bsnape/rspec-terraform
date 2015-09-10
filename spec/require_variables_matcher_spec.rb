describe 'require variables matcher' do
  after(:each) do
    delete_variables_file
  end

  context 'when a module expects one variable' do
    before(:each) do
      variables = 'variable "foo" {}'
      create_variables_file variables
    end

    it 'passes the assertion when the correct variables are provided' do
      missing_variable = ['foo']
      expect { expect('terraform plan -out=plan.tf').to require_variables(missing_variable) }.not_to raise_error
    end

    it 'identifies missing variables' do
      expected_variables = []
      error              = RSpec::Expectations::ExpectationNotMetError
      error_message      = /The missing variables were: \["foo"\]/
      expect { expect('terraform plan -out=plan.tf').to require_variables(expected_variables) }.to raise_error(error, error_message)
    end

    it 'identifies extra variables' do
      expected_variables = %w(foo bar)
      error              = RSpec::Expectations::ExpectationNotMetError
      error_message      = /The extra variables were: \["bar"\]/
      expect { expect('terraform plan -out=plan.tf').to require_variables(expected_variables) }.to raise_error(error, error_message)
    end
  end

  context 'when a module expects multiple variables' do
    before(:each) do
      variables = "variable \"foo\" {}\nvariable \"bar\" {}"
      create_variables_file variables
    end

    it 'identifies multiple missing terraform variables in any order' do
      missing_variables = %w(bar foo)
      expect { expect('terraform plan -out=plan.tf').to require_variables(missing_variables) }.not_to raise_error
    end
  end
end

def create_variables_file(content)
  File.open('variables.tf', 'w+') { |f| f.write(content) }
end

def delete_variables_file
  File.delete 'variables.tf'
end
