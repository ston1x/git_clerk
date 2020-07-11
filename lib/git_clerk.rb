require 'git_clerk/dir_processor'
require 'git_clerk/visualizer'
require 'git_clerk/opt_parser'
require 'git_clerk/errors/main_command_not_specified_error'
require 'git_clerk/errors/options_not_compatible_error'
require 'git_clerk/errors/option_instead_of_argument_error'
require 'pry'

module GitClerk
  include Gitable

  DEFAULT_OPTIONS = {
    verbose: false,
    dir: Dir.pwd,
    show_dirty: false
  }.freeze

  def self.clerk_and_print
    parser = OptParser.new
    parser.parse!
    options = parser.result
    pp options
  rescue StandardError => e
    puts e.message

    # ---- TODO: decomment it back after pry tests on options!!!
    # processor = DirProcessor.new(Dir.pwd)
    # processor.clerk
    # visualize(processor.data)
    # ---- ENDS HERE ----

    # result = clerk(options)
    # visualize(result.data)
  end

  def self.clerk(options = DEFAULT_OPTIONS)
    # TODO: take dir from argv || use Dir.pwd
    # processor = DirProcessor.new(options)
    processor = DirProcessor.new(Dir.pwd)
    processor.clerk
  end

  def self.visualize(data)
    visualizer = Visualizer.new(data)
    visualizer.pretty_print
  end
end
