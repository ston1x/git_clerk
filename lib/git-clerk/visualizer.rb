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
          strings << "#{entry[:dir].ljust(find_longest_string(:dir))} | #{entry[:branch]} #{'*'.colorize(:blue) if entry[:dirty]}"
        end
      end

      pretty_strings.each { |str| puts str }
      nil
    end

    private

    def find_longest_string(key)
      keys = data.map { |e| e[key] }
      keys.max_by(&:length).length
    end
  end
end
