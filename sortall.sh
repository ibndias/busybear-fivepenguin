for entry in "$1"/*
do
  cat $entry | awk ' {print $2 " " $1} ' | sort > $entry
done