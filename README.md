# RequireRelativeDir

Simple utility to `require` all Ruby files in a given directory.

## Usage

```
# lib/your_gem_or_app.rb
require 'require_relative_dir'

module YourGemOrApp
  extend RequireRelativeDir

  require_relative_dir # or pass 'your_gem_or_app' to be more explicit
end

# lib/your_gem_or_app/whatever.rb

require 'some_gem'
require 'some_other_gem'

module YourGemOrApp
  require_relative_dir 'concerns'  # requires all of 'your_gem_or_app/concerns/'
  require_relative_dir 'utils', except: 'big_and_unused_for_now'

  class Whatever
    # ...
  end
end
```

Alternatively, you could call `extend RequireRelativeDir` at the top level but that is not recommended as it might conflict one day with a builtin version (see for example [this discussion](https://bugs.ruby-lang.org/issues/14927)). It might not be exactly equivalent too.

## Installation

Nothing special.

Add this line to your application's Gemfile:

```ruby
gem 'require_relative_dir'
```

And then execute:

    $ bundle


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcandre/require_relative_dir.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
