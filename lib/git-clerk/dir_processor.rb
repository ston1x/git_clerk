require_relative 'gitable'

module GitClerk
  class DirProcessor
    include GitClerk::Gitable

    attr_reader :all_dirs, :data, :current_dir, :path_type
    def initialize(dir)
      @current_dir = dir
      @all_dirs    = []
      @data        = []

      # ARGS
      @path_type = :full
    end

    def clerk
      collect_dirs
      clerk_through_dirs
      pr_print
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

    def pr_print
      return puts 'No git directories here!' if data.empty?

      pretty_strings = [].tap do |strings|
        data.each do |entry|
          strings << "#{entry[:dir].ljust(find_longest(:dir))} | #{entry[:branch]} #{'*' if entry[:dirty]}"
        end
      end

      pretty_strings.each { |str| puts str }
    end

    def find_longest(key)
      keys = data.map { |e| e[key] }
      keys.max_by(&:length).length
    end

    def print_results
      data_to_print = data.empty? ? 'No git directories here!' : data
      puts data_to_print
    end
  end
end
