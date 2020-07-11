module GitClerk
  class Visualizer
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def pretty_print
      return puts 'No git directories here!' if data.empty?

      pretty_strings = [].tap do |strings|
        data.each do |entry|
          strings << "#{path(entry[:path])} | #{colored_branch(entry[:branch])} #{dirtiness_status(entry[:dirty])}"
        end
      end

      pretty_strings.each { |str| puts str }
      nil
    end

    private

    def path(path)
      path.ljust(find_longest_string(:path))
    end

    def colored_branch(branch)
      branch == 'master' ? branch.colorize(:green) : branch.colorize(:yellow)
    end

    def dirtiness_status(dirty)
      '*'.colorize(:blue) if dirty
    end

    def find_longest_string(key)
      keys = data.map { |e| e[key] }
      keys.max_by(&:length).length
    end
  end
end
