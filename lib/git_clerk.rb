require_relative 'git-clerk/dir_processor'
require_relative 'git-clerk/visualizer'

module GitClerk
  include Gitable
  def self.clerk
    # TODO: take dir from argv || use Dir.pwd
    processor = DirProcessor.new('/Users/nstoianov/dev')
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
