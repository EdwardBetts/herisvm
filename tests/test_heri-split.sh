# -*- coding: utf-8 -*-

dataset="$tmpdir/dataset"
res_dir="$tmpdir/dir1"

mkdir "$res_dir"

generate_random_dataset(){
    awk '
BEGIN {
   srand()
   for (i=1; i <= 10000; ++i){
      print int(rand()*10), "feaures", i
   }
}' > "$dataset"
}

{ heri-split < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.1 error' \
'Options -c/-R and -d are mandatory, see heri-split -h for details
exit status=1
'

{ heri-split -c 3 < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.2 error' \
'Options -c/-R and -d are mandatory, see heri-split -h for details
exit status=1
'

{ heri-split -d "$res_dir" < /dev/null 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #1.3 error' \
'Options -c/-R and -d are mandatory, see heri-split -h for details
exit status=1
'

generate_random_dataset

rm -rf "$res_dir"/*

{ heri-split -rc2 -d "$res_dir" "$dataset" 2>&1; echo "exit status=$?"; } |
cmp 'heri-split -r #2 exit code' \
'exit status=0
'

ls -1 "$res_dir" | sort |
cmp 'heri-split -r #3 result files' \
'test1.txt
test2.txt
testing_fold.txt
train1.txt
train2.txt
'

for i in 1 2; do
    { cat "$res_dir/test${i}.txt" "$res_dir/train${i}.txt" | sort -k3,3n; } |
	cmp2 "heri-split -r #4.${i} all objects" \
	     "$dataset"
done

{ cat "$res_dir/"test?.txt | sort -k3,3n; } |
cmp2 "heri-split -r #5 testing sets correctness" \
     "$dataset"

rm -rf "$res_dir"/*

{ heri-split -c 3 -d "$res_dir" "$dataset" 2>&1; echo "exit status=$?"; } |
cmp 'heri-split #2 exit code' \
'exit status=0
'

ls -1 "$res_dir" | sort |
cmp 'heri-split #3 result files' \
'test1.txt
test2.txt
test3.txt
testing_fold.txt
train1.txt
train2.txt
train3.txt
'

for i in 1 2 3; do
    { cat "$res_dir/test${i}.txt" "$res_dir/train${i}.txt" | sort -k3,3n; } |
	cmp2 "heri-split #4.${i} all objects" \
	     "$dataset"
done

{ cat "$res_dir/"test?.txt | sort -k3,3n; } |
cmp2 "heri-split #5 testing sets correctness" \
     "$dataset"

rm "$res_dir"/*
heri-split -r -d "$res_dir" -c 4 dataset1.txt
val1=`cat $res_dir/test1.txt $res_dir/test2.txt $res_dir/test3.txt $res_dir/test4.txt`
val2=`awk '{printf "%d %d свойство%d\n", $1, NR, NR}' $res_dir/testing_fold.txt |
   sort -k1,1n -k2,2n |
   awk '{print $2, $3}'`
printf '%s' "$val1" | cmp "heri-split -r #6 correct testing_fold.txt" \
     "$val2"

rm "$res_dir"/*
heri-split -d "$res_dir" -c 4 dataset1.txt
val1=`cat $res_dir/test1.txt $res_dir/test2.txt $res_dir/test3.txt $res_dir/test4.txt`
val2=`awk '{printf "%d %d свойство%d\n", $1, NR, NR}' $res_dir/testing_fold.txt |
   sort -k1,1n -k2,2n |
   awk '{print $2, $3}'`
printf '%s' "$val1" | cmp "heri-split #6 correct testing_fold.txt" \
     "$val2"

rm "$res_dir"/*
heri-split -d "$res_dir" -c 9 dataset2.txt
for i in 1 2 3 4 5 6 7 8 9; do
    wc -l "$res_dir/test$i.txt" | awk '{print $1}'
done |
cmp "heri-split #7 correct stratified sampling" \
    '1
1
1
1
1
1
1
1
1
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -c 4 dataset2.txt
for i in 1 2 3 4; do
    wc -l "$res_dir/test$i.txt" | awk '{print $1}'
done |
cmp "heri-split #7 correct random sampling" \
    '3
2
2
2
'

rm "$res_dir"/*
heri-split -d "$res_dir" -c 2 dataset3.txt
for j in 1 2; do
    echo "dataset: $j"
    for i in 1 2 3 4; do
	awk -v tag=$i '$1 == tag {cnt += 1}
	    END {printf("tag %s -> %s\n", tag, cnt)}' "$res_dir/test$j.txt"
    done
done |
cmp "heri-split #8 correct stratified sampling" \
    'dataset: 1
tag 1 -> 1
tag 2 -> 1
tag 3 -> 1
tag 4 -> 2
dataset: 2
tag 1 -> 1
tag 2 -> 1
tag 3 -> 1
tag 4 -> 2
'

rm "$res_dir"/*
generate_random_dataset
heri-split -d "$res_dir" -c 5 "$dataset"
for i in 0 1 2 3 4 5 6 7 8 9; do
    echo "tag: $i"
    for j in 1 2 3 4 5; do
	awk -v tag=$i '$1 == tag {cnt += 1}
	    END {print cnt}' "$res_dir/train$j.txt"
    done | sort | awk '{ma = $1} NR == 1 {mi = $1} END {print ((ma - mi) <= 1)}'
done |
cmp "heri-split #9 correct stratified sampling" \
'tag: 0
1
tag: 1
1
tag: 2
1
tag: 3
1
tag: 4
1
tag: 5
1
tag: 6
1
tag: 7
1
tag: 8
1
tag: 9
1
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R 70 dataset1.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
} | cmp "heri-split #10.1 -R" \
'3
6
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R 70 dataset2.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
} | cmp "heri-split #10.2 -R" \
'3
6
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R 70 dataset3.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
} | cmp "heri-split #10.3 -R" \
'3
7
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R99 dataset4.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
} | cmp "heri-split #10.4.1 -R" \
'1
1
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R1 dataset4.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
} | cmp "heri-split #10.4.2 -R" \
'1
1
'

rm "$res_dir"/*
heri-split -r -d "$res_dir" -R67 dataset5.txt
{
    awk 'END {print NR}' "$res_dir/test.txt"
    awk 'END {print NR}' "$res_dir/train.txt"
    awk '$0 == "0" {cnt0++} $0 == "1" {cnt1++} END {print cnt1, cnt0}' "$res_dir/testing_fold.txt"
} | cmp "heri-split #10.5 -R" \
'33
67
33 67
'

rm "$res_dir"/*
heri-split -d "$res_dir" -R50 dataset2.txt
{
    awk '{print $1}' "$res_dir/test.txt" | sort
    echo '==='
    awk '{print $1}' "$res_dir/train.txt" | sort
} | cmp "heri-split #11.1 -R" \
'1
1
1
1
===
1
1
1
1
1
'

rm "$res_dir"/*
heri-split -d "$res_dir" -R 50 dataset3.txt
{
    awk '{print $1}' "$res_dir/test.txt" | sort
    echo ===
    awk '{print $1}' "$res_dir/train.txt" | sort
} | cmp "heri-split #11.2 -R" \
'1
2
3
4
4
===
1
2
3
4
4
'

rm "$res_dir"/*
heri-split -d "$res_dir" -R67 dataset5.txt
{
    awk '{++h[$1]} END {for (k in h) print k, h[k]}' "$res_dir/test.txt"
    echo ===
    awk '{++h[$1]} END {for (k in h) print k, h[k]}' "$res_dir/train.txt"
    echo ===
    awk '$0 == "0" {cnt0++} $0 == "1" {cnt1++} END {print cnt1, cnt0}' "$res_dir/testing_fold.txt"
} | cmp "heri-split #11.4 -R" \
'3 13
2 13
1 13
4 13
0 13
===
3 7
2 7
1 7
4 7
0 7
===
65 35
'
