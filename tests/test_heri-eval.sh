res_dir="$tmpdir/dir-eval"
mkdir -p "$res_dir"

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
'Either -n or -r or -e must be specified, run heri-eval -h for details
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
heri-eval -S 100500 -f -n5 matrix.libsvm | awk 'NR==1, /^Total/' |
cmp 'heri-eval #7 -S 100500 -f' \
'Fold 1x1 statistics
  Class  0      P, R, F1:  1          6/6      ,  0.75       6/8      ,  0.8571
  Class  1      P, R, F1:  0.75       6/8      ,  1          6/6      ,  0.8571
  Accuracy              :  0.8571    12/14     
  Macro average P, R, F1:  0.875               ,  0.875               ,  0.8571

Fold 1x2 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8571     6/7      ,  1          6/6      ,  0.9231
  Accuracy              :  0.9286    13/14     
  Macro average P, R, F1:  0.9286              ,  0.9375              ,  0.9282

Fold 1x3 statistics
  Class  0      P, R, F1:  0.8889     8/9      ,  1          8/8      ,  0.9412
  Class  1      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
  Accuracy              :  0.9286    13/14     
  Macro average P, R, F1:  0.9444              ,  0.9167              ,  0.9251

Fold 1x4 statistics
  Class  0      P, R, F1:  1          8/8      ,  1          8/8      ,  1     
  Class  1      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
  Accuracy              :  1         14/14     
  Macro average P, R, F1:  1                   ,  1                   ,  1     

Fold 1x5 statistics
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
  Macro average        P> mean, maxdev, stddev      : 93.3   6.71   4.55
  Class  0             P> mean, maxdev, stddev      : 97.8   8.89   4.97
  Class  1             P> mean, maxdev, stddev      : 88.8   13.8   11.0

  Macro average        R> mean, maxdev, stddev      : 93.3   6.67   4.52
  Class  0             R> mean, maxdev, stddev      : 90.0   15.0   10.5
  Class  1             R> mean, maxdev, stddev      : 96.7   13.3   7.45

  Macro average       F1> mean, maxdev, stddev      : 92.6   7.37   5.06
  Class  0            F1> mean, maxdev, stddev      : 93.3   7.59   5.08
  Class  1            F1> mean, maxdev, stddev      : 92.0   8.03   5.15

                       A> mean, maxdev, stddev      : 92.7   7.25   5.06

'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
heri-eval -S 100500 -p '-mr' -n5 -f -t2 matrix.libsvm |
cmp 'heri-eval #8.1 -p -t2' \
'Fold 1x1 statistics
  Class  0      P, R, F1:  1          6/6      ,  0.75       6/8      ,  0.8571
  Class  1      P, R, F1:  0.75       6/8      ,  1          6/6      ,  0.8571
  Accuracy              :  0.8571    12/14     

Fold 1x2 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8571     6/7      ,  1          6/6      ,  0.9231
  Accuracy              :  0.9286    13/14     

Fold 1x3 statistics
  Class  0      P, R, F1:  0.8889     8/9      ,  1          8/8      ,  0.9412
  Class  1      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
  Accuracy              :  0.9286    13/14     

Fold 1x4 statistics
  Class  0      P, R, F1:  1          8/8      ,  1          8/8      ,  1     
  Class  1      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
  Accuracy              :  1         14/14     

Fold 1x5 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8333     5/6      ,  1          5/5      ,  0.9091
  Accuracy              :  0.9231    12/13     

Fold 2x1 statistics
  Class  0      P, R, F1:  1          8/8      ,  1          8/8      ,  1     
  Class  1      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
  Accuracy              :  1         14/14     

Fold 2x2 statistics
  Class  0      P, R, F1:  1          8/8      ,  1          8/8      ,  1     
  Class  1      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
  Accuracy              :  1         14/14     

Fold 2x3 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8571     6/7      ,  1          6/6      ,  0.9231
  Accuracy              :  0.9286    13/14     

Fold 2x4 statistics
  Class  0      P, R, F1:  1          7/7      ,  0.875      7/8      ,  0.9333
  Class  1      P, R, F1:  0.8571     6/7      ,  1          6/6      ,  0.9231
  Accuracy              :  0.9286    13/14     

Fold 2x5 statistics
  Class  0      P, R, F1:  0.8571     6/7      ,  0.75       6/8      ,  0.8   
  Class  1      P, R, F1:  0.6667     4/6      ,  0.8        4/5      ,  0.7273
  Accuracy              :  0.7692    10/13     

Total statistics
  Class  0      P, R, F1:  0.973     72/74     ,  0.9       72/80     ,  0.9351
  Class  1      P, R, F1:  0.875     56/64     ,  0.9655    56/58     ,  0.918 
  Accuracy              :  0.9275   128/138    

Total cross-folds statistics
  Macro average        P> mean, maxdev, stddev      : 92.8   16.6   7.18
  Class  0             P> mean, maxdev, stddev      : 97.5   11.7   5.41
  Class  1             P> mean, maxdev, stddev      : 88.2   21.5   11.7

  Macro average        R> mean, maxdev, stddev      : 93.2   15.7   6.84
  Class  0             R> mean, maxdev, stddev      : 90.0   15.0   9.86
  Class  1             R> mean, maxdev, stddev      : 96.3   16.3   7.77

  Macro average       F1> mean, maxdev, stddev      : 92.5   16.2   7.27
  Class  0            F1> mean, maxdev, stddev      : 93.3   13.3   6.41
  Class  1            F1> mean, maxdev, stddev      : 91.7   19.0   8.20

                       A> mean, maxdev, stddev      : 92.6   15.7   7.13

'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -M tfc -S 100 -n2 matrix.libsvm 2>&1 |
cmp 'heri-eval #9.1 -M tfc' \
'Fold 1x1 statistics
  Class  0      P, R, F1:  0.95      19/20     ,  0.95      19/20     ,  0.95  
  Class  1      P, R, F1:  0.9333    14/15     ,  0.9333    14/15     ,  0.9333
  Accuracy              :  0.9429    33/35     
  Macro average P, R, F1:  0.9417              ,  0.9417              ,  0.9417

Fold 1x2 statistics
  Class  0      P, R, F1:  1         17/17     ,  0.85      17/20     ,  0.9189
  Class  1      P, R, F1:  0.8235    14/17     ,  1         14/14     ,  0.9032
  Accuracy              :  0.9118    31/34     
  Macro average P, R, F1:  0.9118              ,  0.925               ,  0.9111

Total statistics
  Class  0      P, R, F1:  0.973     36/37     ,  0.9       36/40     ,  0.9351
  Class  1      P, R, F1:  0.875     28/32     ,  0.9655    28/29     ,  0.918 
  Accuracy              :  0.9275    64/69     
  Macro average P, R, F1:  0.924               ,  0.9328              ,  0.9265

Total cross-folds statistics
  Macro average        P> mean, maxdev, stddev      : 92.7   1.50   2.11
  Class  0             P> mean, maxdev, stddev      : 97.5   2.50   3.54
  Class  1             P> mean, maxdev, stddev      : 87.8   5.49   7.76

  Macro average        R> mean, maxdev, stddev      : 93.3  0.833   1.18
  Class  0             R> mean, maxdev, stddev      : 90.0   5.00   7.07
  Class  1             R> mean, maxdev, stddev      : 96.7   3.33   4.71

  Macro average       F1> mean, maxdev, stddev      : 92.6   1.53   2.16
  Class  0            F1> mean, maxdev, stddev      : 93.4   1.55   2.20
  Class  1            F1> mean, maxdev, stddev      : 91.8   1.51   2.13

                       A> mean, maxdev, stddev      : 92.7   1.55   2.20

'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -Mt -S 100 -n2 matrix.libsvm 2>&1 |
cmp 'heri-eval #9.2 -Mt' \
'Total statistics
  Class  0      P, R, F1:  0.973     36/37     ,  0.9       36/40     ,  0.9351
  Class  1      P, R, F1:  0.875     28/32     ,  0.9655    28/29     ,  0.918 
  Accuracy              :  0.9275    64/69     
  Macro average P, R, F1:  0.924               ,  0.9328              ,  0.9265

'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -M tf -S 100 -n2 matrix.libsvm 2>&1 |
cmp 'heri-eval #9.3 -M tf' \
'Fold 1x1 statistics
  Class  0      P, R, F1:  0.95      19/20     ,  0.95      19/20     ,  0.95  
  Class  1      P, R, F1:  0.9333    14/15     ,  0.9333    14/15     ,  0.9333
  Accuracy              :  0.9429    33/35     
  Macro average P, R, F1:  0.9417              ,  0.9417              ,  0.9417

Fold 1x2 statistics
  Class  0      P, R, F1:  1         17/17     ,  0.85      17/20     ,  0.9189
  Class  1      P, R, F1:  0.8235    14/17     ,  1         14/14     ,  0.9032
  Accuracy              :  0.9118    31/34     
  Macro average P, R, F1:  0.9118              ,  0.925               ,  0.9111

Total statistics
  Class  0      P, R, F1:  0.973     36/37     ,  0.9       36/40     ,  0.9351
  Class  1      P, R, F1:  0.875     28/32     ,  0.9655    28/29     ,  0.918 
  Accuracy              :  0.9275    64/69     
  Macro average P, R, F1:  0.924               ,  0.9328              ,  0.9265

'

env SVM_TRAIN_CMD=test_train SVM_PREDICT_CMD=test_predict \
    heri-eval -Mt -n2 matrix.libsvm -- -0 2>&1 |
cmp 'heri-eval #10.1 -- options' \
'Total statistics
  Class  0      P, R, F1:  0.5797    40/69     ,  1         40/40     ,  0.7339
  Class  1      P, R, F1:  0          0/0      ,  0          0/29     ,  0     
  Accuracy              :  0.5797    40/69     
  Macro average P, R, F1:  0.2899              ,  0.5                 ,  0.367 

'

env SVM_TRAIN_CMD=test_train SVM_PREDICT_CMD=test_predict \
    heri-eval -Mt -n2 matrix.libsvm -- -1 2>&1 |
cmp 'heri-eval #10.2 -- options' \
'Total statistics
  Class  0      P, R, F1:  0          0/0      ,  0          0/40     ,  0     
  Class  1      P, R, F1:  0.4203    29/69     ,  1         29/29     ,  0.5918
  Accuracy              :  0.4203    29/69     
  Macro average P, R, F1:  0.2101              ,  0.5                 ,  0.2959

'

env SVM_TRAIN_CMD=test_train SVM_PREDICT_CMD=test_predict \
    heri-eval -Mt -s '-r' -S117 -n2 matrix.libsvm -- -1 2>&1 |
cmp 'heri-eval #10.3 -- options' \
'Total statistics
  Class  0      P, R, F1:  0          0/0      ,  0          0/40     ,  0     
  Class  1      P, R, F1:  0.4203    29/69     ,  1         29/29     ,  0.5918
  Accuracy              :  0.4203    29/69     
  Macro average P, R, F1:  0.2101              ,  0.5                 ,  0.2959

'

env SVM_TRAIN_CMD=true SVM_PREDICT_CMD=rulebased_predict \
    heri-eval -Mt -S 100 -r 70 matrix.libsvm 2>&1 |
cmp 'heri-eval #10.4 -- options' \
'Total statistics
  Class  0      P, R, F1:  1         10/10     ,  0.8333    10/12     ,  0.9091
  Class  1      P, R, F1:  0.8182     9/11     ,  1          9/9      ,  0.9   
  Accuracy              :  0.9048    19/21     
  Macro average P, R, F1:  0.9091              ,  0.9167              ,  0.9045

'
