describe 'require variables matcher' do
  context 'when a single variable is required' do
    before do
      variables = 'variable "foo" {}'
      create_variables_file variables
    end

    it 'identifies a missing terraform variable' do
      missing_variable = ['foo']
      expect { expect('terraform plan -out=plan.tf').to require_variables(missing_variable) }.not_to raise_error
    end

    after do
      delete_variables_file
    end
  end

  context 'when multiple variables are required' do
    before do
      variables = <<EOF
variable "foo" {}
variable "bar" {}
EOF
      create_variables_file variables
    end

    it 'identifies multiple missing terraform variables in any order' do
      missing_variables = ['bar', 'foo']
      expect { expect('terraform plan -out=plan.tf').to require_variables(missing_variables) }.not_to raise_error
    end

    after do
      delete_variables_file
    end
  end
end

def create_variables_file(content)
  File.open('variables.tf', 'w+') { |f| f.write(content) }
end

def delete_variables_file
  File.delete 'variables.tf'
end
