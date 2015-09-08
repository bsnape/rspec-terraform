# Rspec::Terraform

* [Motivation](#motivation)
  * [Looking Ahead](#looking-ahead)
* [Usage](#usage)
  * [Setup](#setup)
  * [Matchers](#matchers)
* [Contributing](#contributing)

## Motivation

[Terraform](https://github.com/hashicorp/terraform) is an awesome way of provisioning your infrastructure. However, with
any new tool, the ecosystem surrounding it is very immature. This can cause problems when sharing code or coming up
against the rough edges of a tool in active development.

The creation of `rspec-terraform` was initially intended to smooth the creation and sharing of common Terraform
modules. Some sort of basic testing would ensure a stable and clearly defined interface for each module.

### Looking Ahead

Eventually, a two-tiered approach to testing would be ideal.
 
Provisioning non-trivial infrastructure should involve the use of many Terraform modules (rather than defining
everything yourself). Taking AWS as an example, this would include VPCs, ASGs, SGs, public/private subnets etc. Each of
these modules should be unit tested using `rspec-terraform` so that the interfaces they expose are well-defined.

Assembling many individual modules into a cohesive platform should also - ideally - be tested. It's unclear at this
stage how this might look and is yet to be implemented. Something similar to
[`serverspec`](https://github.com/mizzy/serverspec) may work.

## Usage

As [outlined above](#motivation), only simple unit-test type operations are currently supported.

### Setup

You will need Ruby and bundler installed.

Create a `Gemfile` at the root of your Terraform module and add the following:

```ruby
source 'https://rubygems.org'

gem 'rspec-terraform'
```

Then install the gem:

```bash
bundle
```

### Matchers

**N.B.** You must set the provider for each test. This is best done in the opening `describe` block:

```ruby
describe 'tf-aws-vpc', provider: :aws do
  ...
end
```

At present, only the `AWS` provider is available.

The matchers currently implemented are:

1. `require_variables`

 ```ruby
 it 'expects the correct variables to be provided' do
  expected_variables = %w(vpccidr ec2nameserver region account envname domain)
  expect('terraform plan').to require_variables expected_variables
 end
 ```
2. `create_a_plan`

 ```ruby
 it 'creates a plan' do
   expect('terraform plan -var-file example_variables/test_values.tfvars').to create_a_plan
 end
 ```

## Contributing

1. Fork it ( https://github.com/bsnape/rspec-terraform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
