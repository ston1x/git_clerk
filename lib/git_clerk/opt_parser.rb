require 'optparse'
require 'git_clerk/version'

module GitClerk
  class OptParser
    MAIN_COMMANDS  = %w[clerk help version].freeze
    VERBOSE_FLAG   = '-v'.freeze
    GLOBAL_FLAGS   = [VERBOSE_FLAG].freeze
    FLAGS          = %w[-f -d] + GLOBAL_FLAGS.freeze
    ALLOWED_ARGS   = (MAIN_COMMANDS + FLAGS).uniq.freeze
    COMPATIBLE_OPTIONS = {
      'clerk' => {
        '-p' => 'Path argument (used as -p YOUR_PATH)',
        '-f' => 'Show full paths',
        '-d' => 'Show dirtiness status (*)',
        '-v' => 'Verbose (show backtrace in case of an error)'
      },
      'help' => {},
      'version' => {}
    }.freeze

    # If a flag was passed, map to its name and value
    FLAGS_VALUES = {
      'clerk' => {
        '-f' => { full_paths: true },
        '-d' => { show_dirty: true },
        '-v' => { verbose: true }
      }
    }.freeze

    # Options which need arguments (like -p PATH)
    KEY_VALUE_OPTIONS = %w[-p].freeze

    attr_reader :args, :main_command, :flags, :key_value_options, :result

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
      detect_key_value_options!
      # TODO: verify path if -p was given!
      detect_flags!

      @result = {
        main_command: @main_command,
        flags: @flags,
        key_value_options: @key_value_options
      }
    end

    def detect_main_command!
      @main_command = @args.shift

      raise MainCommandNotSpecifiedError unless MAIN_COMMANDS.include? @main_command
    end

    def detect_flags!
      handle_uncompatible_options!

      flag_args = @args.select { |a| FLAGS.include? a }

      @flags = flag_args.map { |f| FLAGS_VALUES.dig(main_command, f) || {} }.reduce({}, :merge!) || {}
    end

    def detect_key_value_options!
      # Find key-value options and its values to the right
      id_pairs = args.map { |a| [args.index(a), args.index(a) + 1] if KEY_VALUE_OPTIONS.include? a }.compact.to_h

      handle_unpermitted_values!(id_pairs)
      # Take out the key-value options from @args
      # After #delete_at(k), the real v value is shifted to the left.
      # That's why I subtract 1
      @key_value_options = id_pairs.map { |k, v| [args.delete_at(k), args.delete_at(v - 1)] }.to_h
    end

    def handle_uncompatible_options!
      uncompatible = uncompatible_options
      return if uncompatible.empty?

      raise OptionsNotCompatibleError.new(
        uncompatible: uncompatible,
        main_command: @main_command
      )
    end

    def handle_unpermitted_values!(hash)
      unpermitted_values = hash.map { |k, v| [args[k], args[v]] if ALLOWED_ARGS.include? args[v] }.compact.to_h

      raise OptionInsteadOfArgumentError.new(unpermitted_values) if unpermitted_values.any?
    end

    def uncompatible_options
      compatible = COMPATIBLE_OPTIONS[@main_command].keys + GLOBAL_FLAGS
      @args.reject { |g| compatible.include? g }
    end
  end
end
