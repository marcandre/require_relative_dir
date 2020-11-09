# frozen_string_literal: true

# This intermediate file is to insure we use the correct caller_location
if ENV['USAGE'] == 'legacy'
  puts 'Legacy'

  module Legacy
    extend RequireRelativeDir
  end

  def call_require_relative_dir(*args, **options)
    Legacy.class_eval { require_relative_dir(*args, **options) }
  end
else
  using RequireRelativeDir

  def call_require_relative_dir(*args, **options)
    require_relative_dir(*args, **options)
  end
end
