paths=()
statuses=()

# TODO: Move to args
full_paths=false
path_length=30

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

    statuses+=("$(git branch --show-current)")
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

  printf "${normal} $(printf "%30s %s" ${paths[$i]}) $branch_string\n"
done
