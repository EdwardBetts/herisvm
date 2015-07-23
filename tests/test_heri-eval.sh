# heri-eval -- no tests yet

res_dir="$tmpdir/dir-eval"
mkdir "$res_dir"

export PATH="$(pwd):$PATH"

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -O "$res_dir/errors.txt" -n5 matrix.libsvm >/dev/null
sort "$res_dir/errors.txt" |
cmp 'heri-eval #1 -O' \
'#14 1 0
#28 0 1
#29 0 1
#30 0 1
#32 0 1
'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -o "$res_dir/results.txt" -n5 matrix.libsvm >/dev/null
awk 'NR == 14 || NR == 28' "$res_dir/results.txt" |
cmp 'heri-eval #2 -o' \
'1 0
0 1
'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -m "$res_dir/confusion_matrix.txt" -n5 matrix.libsvm >/dev/null
cat "$res_dir/confusion_matrix.txt" |
cmp 'heri-eval #3 -m' \
'4 : 0 1
1 : 1 0
'

heri-eval -h 2>&1 | sed -n 's/^usage:.*/usage:/p' |
cmp 'heri-eval #4 -h' \
'usage:
'

{ heri-eval 2>&1; echo ex=$?; } |
cmp 'heri-eval #5 no args' \
'Either -v or -e must be specified, run heri-eval -h for details
ex=1
'

rm $res_dir/*
env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
heri-eval -e matrix_test.libsvm \
  -o "$res_dir/results.txt" \
  -m "$res_dir/confusion_matrix.txt" \
  -O "$res_dir/errors.txt" matrix.libsvm 2>&1 |
cmp 'heri-eval #6 -e' \
'Total statistics
  Class  0      P, R, F1:  0.75       3/4      ,  0.5        3/6      ,  0.6   
  Class  1      P, R, F1:  0.5714     4/7      ,  0.8        4/5      ,  0.6667
  Accuracy              :  0.6364     7/11     
  Macro average P, R, F1:  0.6607              ,  0.65                ,  0.6333
'

cat "$res_dir/results.txt" "$res_dir/confusion_matrix.txt" "$res_dir/errors.txt" |
cmp 'heri-eval #6.1 -e + -o + -O + -m' \
'1 1
1 1
1 0
1 1
1 1
0 0
0 1
0 1
0 1
0 0
0 0
3 : 0 1
1 : 1 0
#3 1 0
#7 0 1
#8 0 1
#9 0 1
'
