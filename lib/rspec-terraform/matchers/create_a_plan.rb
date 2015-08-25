RSpec::Matchers.define :create_a_plan do
  match do |command|
    Open3.popen3(command) do |_stdin, stdout, stderr, _wait_thr|
      @stderr = stderr.read
      @stdout = stdout.read
    end

    plan_file    = File.exist?('plan.tf')
    tfstate_file = File.exist?('terraform.tfstate')

    plan_file && tfstate_file && @stderr.empty?
  end

  failure_message do
    "Expected plan.tf and terraform.tfstate files to be created.\n"\
    "Terraform output: \n#{@stderr}"
  end
end
