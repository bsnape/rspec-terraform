RSpec::Matchers.define :require_variables do |expected_variables|
  match do |command|
    Open3.popen3(command) do |_stdin, _stdout, stderr, _wait_thr|
      @stderr = stderr.read
    end

    @missing_variables = @stderr.scan(/not set: (\w+)/).flatten
    @missing_variables.sort == expected_variables.sort
  end

  failure_message do
    message = "The test expects variables: #{expected_variables}\n"
    message += "Terraform expects variables: #{@missing_variables}\n"

    missing = @missing_variables - expected_variables
    message += "The missing variables were: #{missing}" unless missing.empty?

    extra   = expected_variables - @missing_variables
    message += "The extra variables were: #{extra}" unless extra.empty?

    message
  end
end
