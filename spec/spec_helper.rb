# frozen_string_literal: true

require_relative 'support/response_helper.rb'
require_relative 'support/AuthHelper.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include ResponseHelper
  config.include AuthHelper

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
