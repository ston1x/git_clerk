require 'git_clerk/dir_processor'
require 'git_clerk/visualizer'
require 'git_clerk/opt_parser'

module GitClerk
  include Gitable

  DEFAULT_OPTIONS = {
    verbose: false,
    dir: Dir.pwd,
    show_dirty: false
  }.freeze

  def self.clerk_and_print
    options = OptParser.parse
    processor = DirProcessor.new(Dir.pwd)
    processor.clerk
    visualize(processor.data)

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
