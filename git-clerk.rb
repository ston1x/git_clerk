dirs = []

def regular_folder?(filename)
  File.directory?(filename) && !(%w[.git . ..].include? filename)
end

# full or short
def current_dir_name(path:)
  path == :full ? Dir.pwd : short_dir_name
end

def short_dir_name
  Dir.pwd.split('/').last
end

def contains_git
  Dir.entries('.').include?('.git')
end

def enrich_with_additional_data(dir_hash)
  #dir_hash[additional_entry] = blablabla
  dir_hash
end

def branch
  branch = `git rev-parse --abbrev-ref HEAD`.chomp
end

def dirty_files
  untracked = `git status --porcelain 2>/dev/null| grep "^??" | wc -l`.chomp.to_i
  # added_to_index = `git status --porcelain 2>/dev/null| grep "^M" | wc -l`.chomp.to_i
  total_uncommited = `git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l`.chomp.to_i

  {
    untracked: untracked,
    uncommited: total_uncommited
  }
end

def dirty?
  # result = `git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo true`.chomp
  # dirty_files = `git status --porcelain 2>/dev/null| grep "^??" | wc -l`.chomp
  dirty = dirty_files
  dirty[:untracked] + dirty[:uncommited] > 0 ? dirty : false
end

Dir.open(Dir.pwd).each do |filename|
   dirs << filename if regular_folder?(filename)
end

# ARGS
path_type = :full

# Start clerking
data = []
dirs.each do |dir|
  Dir.chdir(dir) do
    next unless contains_git
    # row is a record for a single directory. Call it receipt or whatever you want
    row = {
      dir: dir,
      full_path: current_dir_name(path: :full),
      branch: branch,
      dirty: dirty?
    }
    data << enrich_with_additional_data(row)
  end
end

puts data
