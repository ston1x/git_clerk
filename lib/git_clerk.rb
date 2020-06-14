require_relative 'git_clerk/dir_processor'
require_relative 'git_clerk/visualizer'

module GitClerk
  include Gitable
  def self.clerk
    # TODO: take dir from argv || use Dir.pwd
    dir = '/Users/nstoianov/dev/'
    processor = DirProcessor.new(dir)
    processor.clerk

    # TODO: take it from the argv
    visualization_needed = true
    visualization_needed && visualize(processor.data)
  end

  def self.visualize(data)
    visualizer = Visualizer.new(data)
    visualizer.pretty_print
  end
end
