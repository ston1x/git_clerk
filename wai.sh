while getopts ":h :a :y" option; do
   case $option in
      h) # display Help
         echo "HALP"
         exit;;
      a) # display a
        echo "AAA"
        exit;;
      y) # display y
        echo "YYY"
        exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
