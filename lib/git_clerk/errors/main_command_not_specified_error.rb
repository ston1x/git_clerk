module GitClerk
  class OptParser
    class MainCommandNotSpecifiedError < StandardError
      attr_reader :message

      def initialize
        @message = "Main command was not specified. Available main commands are: #{MAIN_COMMANDS}"
      end
    end
  end
end
