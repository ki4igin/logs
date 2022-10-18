fn() { declare local s="${1##*/}"; s="${s%%.*}"; echo "${s##*[!1-9]}"; }

mkdir -p logs
files=$(find -name *.log | sort -u)
first_file=$(find -name *.log | sort -u | head -1)
last_file=$(find -name *.log | sort -u | tail -1)

num=$(fn $last_file)
cnt_files=$(ls -1q log* | wc -l)

echo ${num}
num=$(($num + 1))

echo $first_file
echo $last_file
echo $cnt_files
echo $(printf "%03d" ${num})

if [[ $cnt_files > 4 ]]; then
    echo "Hello"
fi

if  (($num > 999)) ; then
    cnt=1
    echo $files
    for file in $files; do
        mv $file ${file%%[0-9]*.log}$(printf "%03d" ${cnt})
        cnt=$(($cnt + 1))
    done
fi

