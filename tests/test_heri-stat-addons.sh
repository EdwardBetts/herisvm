remove_fractions (){
    awk '{gsub(/0[.][0-9]+/, "0.NNNN"); print}' "$@"
}

# heri-stat
heri-stat-addons -h eval_results/evaluation?.txt 2>&1 |
    cmp 'heri-stat-addons -h #0' \
'heri-stat-addons calculates mean and daviations for statistics
   calculated by heri-stat
Usage:
    heri-stat-addons [OPTIONS] [files...]
OPTIONS:
    -h, --help                       display this message and exit
    -R, --raw                        raw tab-separated output
 
'

heri-stat-addons -R eval_results/evaluation?.txt 2>&1 |
    sed 's/	/<TAB>/g' |
    cmp 'heri-stat-addons -R #1' \
'Macro average<TAB>precision: mean<TAB>60.4
Macro average<TAB>precision: maxdev<TAB>0.929
Macro average<TAB>precision: stddev<TAB>0.565
Class  1     <TAB>precision: mean<TAB>63.3
Class  1     <TAB>precision: maxdev<TAB>1.57
Class  1     <TAB>precision: stddev<TAB>1.20
Class  2     <TAB>precision: mean<TAB>51.3
Class  2     <TAB>precision: maxdev<TAB>2.92
Class  2     <TAB>precision: stddev<TAB>2.12
Class  3     <TAB>precision: mean<TAB>58.8
Class  3     <TAB>precision: maxdev<TAB>0.386
Class  3     <TAB>precision: stddev<TAB>0.328
Class  4     <TAB>precision: mean<TAB>68.1
Class  4     <TAB>precision: maxdev<TAB>0.612
Class  4     <TAB>precision: stddev<TAB>0.430

Macro average<TAB>recall: mean<TAB>53.7
Macro average<TAB>recall: maxdev<TAB>0.877
Macro average<TAB>recall: stddev<TAB>0.508
Class  1     <TAB>recall: mean<TAB>50.1
Class  1     <TAB>recall: maxdev<TAB>3.15
Class  1     <TAB>recall: stddev<TAB>2.17
Class  2     <TAB>recall: mean<TAB>32.8
Class  2     <TAB>recall: maxdev<TAB>1.66
Class  2     <TAB>recall: stddev<TAB>1.15
Class  3     <TAB>recall: mean<TAB>55.9
Class  3     <TAB>recall: maxdev<TAB>0.831
Class  3     <TAB>recall: stddev<TAB>0.750
Class  4     <TAB>recall: mean<TAB>76.1
Class  4     <TAB>recall: maxdev<TAB>0.298
Class  4     <TAB>recall: stddev<TAB>0.176

Macro average<TAB>f1: mean<TAB>56.3
Macro average<TAB>f1: maxdev<TAB>0.743
Macro average<TAB>f1: stddev<TAB>0.422
Class  1     <TAB>f1: mean<TAB>55.9
Class  1     <TAB>f1: maxdev<TAB>2.28
Class  1     <TAB>f1: stddev<TAB>1.56
Class  2     <TAB>f1: mean<TAB>40.0
Class  2     <TAB>f1: maxdev<TAB>1.70
Class  2     <TAB>f1: stddev<TAB>1.22
Class  3     <TAB>f1: mean<TAB>57.3
Class  3     <TAB>f1: maxdev<TAB>0.434
Class  3     <TAB>f1: stddev<TAB>0.303
Class  4     <TAB>f1: mean<TAB>71.9
Class  4     <TAB>f1: maxdev<TAB>0.335
Class  4     <TAB>f1: stddev<TAB>0.202

<TAB>accuracy: mean<TAB>64.2
<TAB>accuracy: maxdev<TAB>0.253
<TAB>accuracy: stddev<TAB>0.195

'

heri-stat-addons eval_results/evaluation?.txt 2>&1 |
    sed 's/	/<TAB>/g' |
    cmp 'heri-stat-addons #2' \
'Macro average precision> mean, maxdev, stddev      : 60.4  0.929  0.565
Class  1      precision> mean, maxdev, stddev      : 63.3   1.57   1.20
Class  2      precision> mean, maxdev, stddev      : 51.3   2.92   2.12
Class  3      precision> mean, maxdev, stddev      : 58.8  0.386  0.328
Class  4      precision> mean, maxdev, stddev      : 68.1  0.612  0.430

Macro average   recall> mean, maxdev, stddev      : 53.7  0.877  0.508
Class  1        recall> mean, maxdev, stddev      : 50.1   3.15   2.17
Class  2        recall> mean, maxdev, stddev      : 32.8   1.66   1.15
Class  3        recall> mean, maxdev, stddev      : 55.9  0.831  0.750
Class  4        recall> mean, maxdev, stddev      : 76.1  0.298  0.176

Macro average       f1> mean, maxdev, stddev      : 56.3  0.743  0.422
Class  1            f1> mean, maxdev, stddev      : 55.9   2.28   1.56
Class  2            f1> mean, maxdev, stddev      : 40.0   1.70   1.22
Class  3            f1> mean, maxdev, stddev      : 57.3  0.434  0.303
Class  4            f1> mean, maxdev, stddev      : 71.9  0.335  0.202

              accuracy> mean, maxdev, stddev      : 64.2  0.253  0.195

'
