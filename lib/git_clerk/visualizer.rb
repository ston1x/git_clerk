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
          strings << "#{entry[:path].ljust(find_longest_string(:path))} | #{colored_branch(entry[:branch])} #{'*'.colorize(:blue) if entry[:dirty]}"
        end
      end

      pretty_strings.each { |str| puts str }
      nil
    end

    private

    def colored_branch(branch)
      branch == 'master' ? branch.colorize(:green) : branch.colorize(:yellow)
    end

    def find_longest_string(key)
      keys = data.map { |e| e[key] }
      keys.max_by(&:length).length
    end
  end
end
