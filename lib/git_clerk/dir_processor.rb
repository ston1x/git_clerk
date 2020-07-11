require_relative 'gitable'
require 'colorize'

module GitClerk
  class DirProcessor
    include GitClerk::Gitable

    attr_reader :all_dirs, :data, :current_dir, :full_paths
    def initialize(key_value_options, flags)
      @current_dir = key_value_options['-p'] || Dir.pwd
      @all_dirs    = []
      @data        = []
      parse_flags(flags)
    end

    def clerk!
      collect_dirs
      clerk_through_dirs
    end

    private

    def parse_flags(flags)
      @full_paths = flags[:full_paths] || false
      @show_dirty = flags[:show_dirty] || false
    end

    def collect_dirs
      Dir.chdir(current_dir) do
        Dir.open(current_dir).each do |filename|
          all_dirs << filename if regular_folder?(filename)
        end
      end
    end

    def clerk_through_dirs
      all_dirs.sort.each do |dir|
        Dir.chdir(current_dir + '/' + dir) do
          next unless contains_git

          entry = {
            path: current_dir_name(full_paths: full_paths),
            branch: branch,
            dirty: dirty?
          }

          data << enrich_with_additional_data(entry)
        end
      end
    end

    def regular_folder?(filename)
      File.directory?(filename) && !(%w[.git . ..].include? filename)
    end

    # full or short
    def current_dir_name(full_paths:)
      full_paths ? Dir.pwd : short_dir_name
    end

    def short_dir_name
      Dir.pwd.split('/').last
    end

    # Nothing to add for now
    def enrich_with_additional_data(entry)
      entry
    end
  end
end
