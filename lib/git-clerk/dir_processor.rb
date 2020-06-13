require_relative 'gitable'
require 'colorize'

module GitClerk
  class DirProcessor
    include GitClerk::Gitable

    attr_reader :all_dirs, :data, :current_dir, :path_type
    def initialize(dir)
      @current_dir = dir
      @all_dirs    = []
      @data        = []

      # ARGS
      # TODO: these should be taken from the argvs
      @path_type  = :full
      @show_dirty = true
    end

    def clerk
      collect_dirs
      clerk_through_dirs
    end

    private

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
            dir: dir,
            full_path: current_dir_name(path: path_type),
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
    def current_dir_name(path:)
      path == :full ? Dir.pwd : short_dir_name
    end

    def short_dir_name
      Dir.pwd.split('/').last
    end

    def enrich_with_additional_data(entry)
      # nothing to add for now
      entry
    end
  end
end
