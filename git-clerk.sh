#!/bin/bash

# Constant values
readonly VERSION=0.2.2.8
readonly normal='\e[0m'
readonly red='\e[31m'
readonly green='\e[32m'
readonly blue='\e[34m'

# Default variable values
full_paths=false
path_length=30
paths=()
statuses=()
show_dirty=false

# Display help
function help {
  echo "git-clerk $VERSION"
  echo
  echo "Syntax: git-clerk [-d|f|h|v -l <length in symbols>]"
  echo
  echo "Options:"
  echo "-d    Show asterisk if dirty (*)"
  echo "-f    Print full paths (default=false)"
  echo "-l    Specify path length (default=30)"
  echo "-h    Help"
  echo "-v    Version info"
}

# Display current version
function version_info {
  echo "git-clerk v$VERSION"
}

# Get command arguments
while getopts ":l:dfhv" option
do
  case $option in
    d) # Show asterisk if dirty
      show_dirty=true
      ;;
    l) # Specify path length
      path_length=${OPTARG}
      ;;
    f) # Print full paths
      full_paths=true
      ;;
    h) # Display help
      help
       exit;;
    v) # Display version info
      version_info
      exit;;
   \?) # Invalid argument
       echo "Error: Invalid argument(s)"
       echo "Run 'git-clerk -h' for help"
       exit;;
  esac
done

# Start clerking
for d in */ ; do
  cd $d;
  if [[ ! -d .git/ ]]
  then # ignore git-less directories
    cd ..
    continue
  fi

  if $full_paths ; then
    # save full paths
    paths+=( "$(pwd)" )
  else
    # save dir names only
    paths+=("${PWD##*/}")
  fi

  # Save branch name(and status)
  branch=$(git rev-parse --abbrev-ref HEAD)
  if $show_dirty ; then
    dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "${red}*")
    branch="$branch $dirty"
  fi
  statuses+=("$branch")
  cd ../
done;

len=${#paths[@]}
for (( i=0; i<$len; i++ )); do
  branch=${statuses[$i]}
  # if [ $branch == "master" ]; then
  if [[ $branch == *"master"* ]]; then
    branch_string="$green$branch"
  else
    branch_string="$blue$branch"
  fi

  printf "${normal} $(printf "%${path_length}s %s" ${paths[$i]}) $branch_string\n"
done
