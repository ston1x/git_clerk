VERSION=0.2.2.8
paths=()
statuses=()

# TODO: Move to args
full_paths=false
path_length=30

# Display help
function help {
   echo "git-clerk $VERSION"
   echo
   echo "Syntax: git-clerk [-l|f|h|v]"
   echo
   echo "Options:"
   echo "-l    Specify path length (default=30)"
   echo "-f    Print full paths (default=false)"
   echo "-h    Help"
   echo "-v    Version info"
}

function version_info {
  echo "git-clerk v$VERSION"
}

# Check command arguments
while getopts ":l:fhv" option
do
  case $option in
    l) # Specify path length
      path_length=${OPTARG}
      ;;
    f) # print full paths
      full_paths=true
      ;;
    h) # display help
      help
       exit;;
    v) # display version info
      version_info
      exit;;
   \?) # incorrect argument
       echo "Error: Invalid argument(s)"
       echo "Run 'git-clerk -h' for help"
       exit;;
  esac
done

for d in */ ; do
    cd $d;
    if [[ ! -d .git/ ]]
    then
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

    statuses+=("$(git rev-parse --abbrev-ref HEAD)")
    cd ../
done;

# Colors
green='\e[32m'
blue='\e[34m'
normal='\e[0m'

len=${#paths[@]}
for (( i=0; i<$len; i++ )); do
  branch=${statuses[$i]}
  if [ $branch == "master" ]; then
    branch_string="$green$branch"
  else
    branch_string="$blue$branch"
  fi

  printf "${normal} $(printf "%${path_length}s %s" ${paths[$i]}) $branch_string\n"
done
