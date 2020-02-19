paths=()
statuses=()
for d in */ ; do
    cd $d;
    if [[ ! -d .git/ ]]
    then
      cd ..
      continue
    fi
    paths+=("$(pwd)")
    statuses+=("$(git branch --show-current)")
    cd ../
done;
# echo "${statuses[*]}"
# echo "${paths[*]}"

len=${#paths[@]}
for (( i=0; i<$len; i++ )); do
  echo "$(echo "...${paths[$i]}" | tail -c 30) ${statuses[$i]}"
done


## Use bash for loop
# for (( i=0; i<$len; i++ )); do echo "${paths[$i]}" ; done
# echo $len
