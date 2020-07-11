module GitClerk
  class CommandRunner
    class CommandNotImplementedError < StandardError
      attr_reader :message

      def initialize(command)
        @message = "Command '#{command}' is not implemented."
      end
    end
  end
end
