require "require_relative_dir/version"

module RequireRelativeDir
  SAME_AS_CALLER_NAME = Object.new

  def require_relative_dir(dir_name = SAME_AS_CALLER_NAME, except: nil)
    caller_path = caller_locations(1..1).first.absolute_path
    dir_name = File.basename(caller_path, '.*') if dir_name == SAME_AS_CALLER_NAME
    base_path = File.dirname(caller_path)
    path = File.expand_path("#{base_path}/#{dir_name}")
    raise LoadError, "Directory '#{path}' not found" unless Dir.exist?(path)
    paths = Dir["#{path}/*.rb"].sort
    paths = RequireRelativeDir.remove_exceptions(paths, except) if except
    paths.each { |file| require file }
  end

  extend self

  private
  def self.remove_exceptions(paths, except)
    except = Array(except).map(&:to_s)
    except.map! { |exception| File.extname(exception) == '.rb' ? exception[0...-3] : exception }
    paths.reject { |file| except.delete File.basename(file, '.rb') }
  ensure
    raise ArgumentError, "The following exceptions where not found: #{except.join(', ')}" unless except.empty?
  end
end
