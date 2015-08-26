RSpec::Matchers.define :require_variables do |expected_variables|
  match do |command|
    Open3.popen3(command) do |_stdin, _stdout, stderr, _wait_thr|
      @stderr = stderr.read
    end

    @missing_variables = @stderr.scan(/not set: (\w+)/).flatten
    @missing_variables.sort == expected_variables.sort
  end

  failure_message do
    "The following variables were expected but not found: #{@missing_variables.join(', ')}"
  end
end
