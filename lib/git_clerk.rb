require 'git_clerk/dir_processor'
require 'git_clerk/visualizer'
require 'git_clerk/opt_parser'
require 'git_clerk/command_runner'
require 'git_clerk/errors/main_command_not_specified_error'
require 'git_clerk/errors/options_not_compatible_error'
require 'git_clerk/errors/option_instead_of_argument_error'
require 'git_clerk/errors/command_not_implemented_error'
require 'pry'

module GitClerk
  include Gitable

  def self.run
    parser = OptParser.new
    parser.parse!
    options = parser.result
    CommandRunner.new(options).run
  rescue StandardError => e
    puts e.class, e.message
    puts e.backtrace if options[:flags][:verbose]

    # ---- TODO: decomment it back after pry tests on options!!!
    # processor = DirProcessor.new(Dir.pwd)
    # processor.clerk
    # visualize(processor.data)
    # ---- ENDS HERE ----

    # result = clerk(options)
    # visualize(result.data)
  end

  # TODO: optimize this method for non-CLI usage
  def self.clerk
    raise NotImplementedError
  end
end
