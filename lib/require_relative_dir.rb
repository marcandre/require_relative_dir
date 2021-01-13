# frozen_string_literal: true

require 'require_relative_dir/version'

module RequireRelativeDir
  SAME_AS_CALLER_NAME = Object.new

  def require_relative_dir(dir_name = SAME_AS_CALLER_NAME, except: nil, first: nil)
    path = RequireRelativeDir.find_base(dir_name)
    raise LoadError, "Directory '#{path}' not found" unless Dir.exist?(path)

    paths = Dir["#{path}/*.rb"].sort
    paths = RequireRelativeDir.remove_exceptions(paths, path, except) if except
    paths = RequireRelativeDir.put_first(paths, path, first) if first
    paths.each { |file| require file }
  end

  refine Object do
    include RequireRelativeDir
    private :require_relative_dir
  end

  extend self

  # @api private
  def self.remove_exceptions(paths, base, except)
    except = as_ruby_files(except, base)
    new_paths = paths - except
    if new_paths.size + except.size != paths.size
      not_found = (except - paths).map { |file| File.basename(file, '.rb') }
      raise ArgumentError, "The following exceptions where not found: #{not_found.join(', ')}" unless not_found.empty?
    end
    new_paths
  end

  # @api private
  def self.put_first(paths, base, first)
    first = as_ruby_files(first, base)
    first | paths
  end

  def self.as_ruby_files(names, base)
    names = Array(names).map(&:to_s)
    names.map! do |name|
      ext = '.rb' unless File.extname(name) == '.rb'
      "#{base}/#{name}#{ext}"
    end
  end

  def self.find_base(dir_name)
    caller_path = caller_locations(2..2).first.absolute_path
    dir_name = File.basename(caller_path, '.*') if dir_name == SAME_AS_CALLER_NAME
    base_path = File.dirname(caller_path)
    File.expand_path("#{base_path}/#{dir_name}")
  end
end
