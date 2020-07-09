require 'optparse'
require 'git_clerk/version'

module GitClerk
  class OptParser
    MAIN_COMMANDS  = %w[clerk help version].freeze
    GLOBAL_OPTIONS = %w[-p -f -d].freeze
    ALLOWED_ARGS   = (MAIN_COMMANDS + GLOBAL_OPTIONS).uniq.freeze
    COMPATIBLE_OPTIONS = {
      'clerk' => {
        '-p' => 'Path argument (used as -p YOUR_PATH)',
        '-f' => 'Show full paths',
        '-d' => 'Show dirtiness status (*)'
      },
      'help' => {},
      'version' => {}
    }.freeze

    attr_reader :args, :main_command, :global_options, :result

    def initialize
      @args = ARGV.dup
    end

    def parse!
      process_args!
      filter_args!
    end

    private

    def filter_args!
      @args.select! { |arg| ALLOWED_ARGS.include? arg }
    end

    def process_args!
      detect_main_command!
      detect_global_options!

      @result = {
        main_command: @main_command,
        global_options: @global_options
      }
    end

    def detect_main_command!
      @main_command = @args.shift

      raise MainCommandNotSpecifiedError unless MAIN_COMMANDS.include? @main_command
    end

    def detect_global_options!
      uncompatible = uncompatible_options

      if uncompatible.any?
        raise GlobalOptionsNotCompatible.new(
          uncompatible: uncompatible,
          main_command: @main_command
        )
      end

      @global_options = @args.select { |opt| GLOBAL_OPTIONS.include? opt }
    end

    def uncompatible_options
      compatible = COMPATIBLE_OPTIONS[@main_command].keys
      @args.reject { |g| compatible.include? g }
    end
  end
end
