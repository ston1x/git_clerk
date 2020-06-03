require_relative 'git-clerk/dir_processor'

module GitClerk
  include Gitable
  def self.clerk
    # Dir.pwd or a given argv dir!
    DirProcessor.new('/Users/nstoianov/dev').clerk
  end
end
