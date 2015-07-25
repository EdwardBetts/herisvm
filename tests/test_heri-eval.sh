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

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
heri-eval -S 100500 -s -n5 matrix.libsvm | awk 'NR==1, /^Total/' |
cmp 'heri-eval #7 -S 100500 -s' \
'Fold 1 statistics
  Class  0      P, R, F1:  1          6/6      ,  0.75       6/8      ,  0.8571
  Class  1      P, R, F1:  0.75       6/8      ,  1          6/6      ,  0.8571
  Accuracy              :  0.8571    12/14     
  Macro average P, R, F1:  0.875               ,  0.875               ,  0.8571

Fold 2 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8571     6/7      ,  1          6/6      ,  0.9231
  Accuracy              :  0.9286    13/14     
  Macro average P, R, F1:  0.9286              ,  0.9375              ,  0.9282

Fold 3 statistics
  Class  0      P, R, F1:  0.8889     8/9      ,  1          8/8      ,  0.9412
  Class  1      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
  Accuracy              :  0.9286    13/14     
  Macro average P, R, F1:  0.9444              ,  0.9167              ,  0.9251

Fold 4 statistics
  Class  0      P, R, F1:  1          8/8      ,  1          8/8      ,  1     
  Class  1      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
  Accuracy              :  1         14/14     
  Macro average P, R, F1:  1                   ,  1                   ,  1     

Fold 5 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8333     5/6      ,  1          5/5      ,  0.9091
  Accuracy              :  0.9231    12/13     
  Macro average P, R, F1:  0.9167              ,  0.9375              ,  0.9212

Total statistics
'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
heri-eval -S 100500 -p '-mr' -n5 matrix.libsvm |
cmp 'heri-eval #8 -p' \
'Total statistics
  Class  0      P, R, F1:  0.973     36/37     ,  0.9       36/40     ,  0.9351
  Class  1      P, R, F1:  0.875     28/32     ,  0.9655    28/29     ,  0.918 
  Accuracy              :  0.9275    64/69     

Total cross-folds statistics
  Macro average max/std deviation(P)   :  12.5 %    4.55 
  Class  0      max/std deviation(P)   :  11.1 %    4.97 
  Class  1      max/std deviation(P)   :  25   %    11   

  Macro average max/std deviation(R)   :  12.5 %    4.52 
  Class  0      max/std deviation(R)   :  25   %    10.5 
  Class  1      max/std deviation(R)   :  16.7 %    7.45 

  Macro average max/std deviation(F1)  :  14.3 %    5.06 
  Class  0      max/std deviation(F1)  :  14.3 %    5.08 
  Class  1      max/std deviation(F1)  :  14.3 %    5.15 

                max/std deviation(A)   :  14.3 %    5.06 

'
