for d in */ ; do
    cd $d
    echo $(pwd; git branch --show-current)
    cd ../
done

