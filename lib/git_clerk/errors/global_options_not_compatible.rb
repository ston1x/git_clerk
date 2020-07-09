module GitClerk
  class OptParser
    class GlobalOptionsNotCompatible < StandardError
      MESSAGE = "Given global options %<uncompatible>s are not compatible with the command '%<main_command>s'.".freeze
      AVAILABLE_OPTIONS_DEFINITION = "\nAvailable options are:".freeze

      attr_reader :message

      def initialize(options = {})
        @message = format(MESSAGE, options) + compatible_options_for(options[:main_command])
      end

      private

      def compatible_options_for(command)
        options = COMPATIBLE_OPTIONS[command]

        AVAILABLE_OPTIONS_DEFINITION +
          ''.tap do |str|
            options.each { |k, v| str << "\n#{k} - #{v}" }
          end
      end
    end
  end
end
