module GitClerk
  module Gitable
    def branch
      `git rev-parse --abbrev-ref HEAD`.chomp
    end

    def dirty?
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
