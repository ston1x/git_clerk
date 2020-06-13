require 'open3'

module GitClerk
  module Gitable
    def branch
      # NOTE: The Open3 approach is less performant,
      # although it captures the errors and doesn't print them directly.
      stdout, _stderr, _status = Open3.capture3('git rev-parse --abbrev-ref HEAD')
      stdout.chomp
    end

    def dirty?
      return nil unless @show_dirty

      dirty = dirty_files
      (dirty[:untracked] + dirty[:uncommited]).positive? ? dirty : false
    end

    def dirty_files
      {
        untracked: untracked,
        uncommited: uncommited
      }
    end

    def untracked
      `git status --porcelain 2>/dev/null| grep "^??" | wc -l`.chomp.to_i
    end

    def uncommited
      `git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l`.chomp.to_i
    end

    def contains_git
      Dir.entries('.').include?('.git')
    end
  end
end
