module GitClerk
  class OptParser
    class OptionInsteadOfArgumentError < StandardError
      attr_reader :message

      def initialize(unpermitted_values)
        @message = generate_error_message(unpermitted_values)
      end

      private

      def generate_error_message(unpermitted)
        ''.tap do |str|
          unpermitted.each do |arg, value|
            str << "Argument #{arg} doesn't support value #{value}\n"
          end
        end
      end
    end
  end
end
