require 'shoulda/matchers'

unless ENV['NOCOV']
  require 'simplecov'

  # cov_formats = [SimpleCov::Formatter::HTMLFormatter]
  # SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(cov_formats)
end
# require 'vcr'

# We have lots of stuff in the support folder, so be specific about load order
Dir["#{File.dirname(__FILE__)}/../spec/support/auth/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/data_helpers/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/example_groups/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/../spec/support/shared_examples/*.rb"].each { |f| require f }

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/vcr_cassettes'
#   c.hook_into :webmock
#   c.default_cassette_options = { record: :once, match_requests_on: [:method] }
#   c.configure_rspec_metadata!
# end

RSpec.configure do |config|
  config.define_derived_metadata(file_path: Regexp.new('/spec/services/')) do |metadata|
    metadata[:type] = :service
  end

  config.include Auth::SecurityHelpers, type: :request
  config.include RequestSpecHelpers, type: :request
  config.include DataHelpers::AppData, type: :request
  config.include DataHelpers::AppData, type: :service

  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
