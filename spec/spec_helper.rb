RSpec.configure do |config|

config.expect_with :rspec do |expectations|

  expectations.include_chain_clauses_in_custom_matcher_descriptions = true
end

config.mock_with :rspec do |mocks|

  mocks.verify_partial_doubles = true
end

# We are not sure what this does:
config.shared_context_metadata_behavior = :apply_to_host_groups

end
