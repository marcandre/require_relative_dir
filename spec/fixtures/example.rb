# frozen_string_literal: true

# This intermediate file is to insure we use the correct caller_location

def call_require_relative_dir(*args, **options)
  RequireRelativeDir.require_relative_dir(*args, **options)
end
