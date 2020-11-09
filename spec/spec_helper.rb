# frozen_string_literal: true

require 'bundler/setup'
require 'require_relative_dir'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end
