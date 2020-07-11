module GitClerk
  class CommandRunner
    def initialize(options)
      @main_command      = options[:main_command]
      @flags             = options[:flags]
      @key_value_options = options[:key_value_options]
    end

    def run
      raise(CommandNotImplementedError, @main_command) unless command_exists?

      send(@main_command)
    end

    def clerk
      processor = DirProcessor.new(@key_value_options, @flags)
      processor.clerk!
      visualize(processor.data)
    end

    def help
      version
      pp OptParser::COMPATIBLE_OPTIONS
    end

    def version
      puts "#{GEM_NAME} v#{VERSION}"
    end

    private

    def command_exists?
      self.class.method_defined?(@main_command)
    end

    # Used for visualizing clerked data
    def visualize(data)
      @visualizer = Visualizer.new(data)
      @visualizer.pretty_print
    end
  end
end
