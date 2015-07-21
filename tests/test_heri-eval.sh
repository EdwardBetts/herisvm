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
