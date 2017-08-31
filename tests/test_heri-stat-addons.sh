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
Macro average<TAB>precision: max deviation<TAB>1.39
Macro average<TAB>precision: standard deviation<TAB>0.565
Class  1     <TAB>precision: mean<TAB>63.3
Class  1     <TAB>precision: max deviation<TAB>2.94
Class  1     <TAB>precision: standard deviation<TAB>1.20
Class  2     <TAB>precision: mean<TAB>51.3
Class  2     <TAB>precision: max deviation<TAB>5.51
Class  2     <TAB>precision: standard deviation<TAB>2.12
Class  3     <TAB>precision: mean<TAB>58.8
Class  3     <TAB>precision: max deviation<TAB>0.738
Class  3     <TAB>precision: standard deviation<TAB>0.328
Class  4     <TAB>precision: mean<TAB>68.1
Class  4     <TAB>precision: max deviation<TAB>1.20
Class  4     <TAB>precision: standard deviation<TAB>0.430

Macro average<TAB>recall: mean<TAB>53.7
Macro average<TAB>recall: max deviation<TAB>1.20
Macro average<TAB>recall: standard deviation<TAB>0.508
Class  1     <TAB>recall: mean<TAB>50.1
Class  1     <TAB>recall: max deviation<TAB>5.95
Class  1     <TAB>recall: standard deviation<TAB>2.17
Class  2     <TAB>recall: mean<TAB>32.8
Class  2     <TAB>recall: max deviation<TAB>2.76
Class  2     <TAB>recall: standard deviation<TAB>1.15
Class  3     <TAB>recall: mean<TAB>55.9
Class  3     <TAB>recall: max deviation<TAB>1.60
Class  3     <TAB>recall: standard deviation<TAB>0.750
Class  4     <TAB>recall: mean<TAB>76.1
Class  4     <TAB>recall: max deviation<TAB>0.441
Class  4     <TAB>recall: standard deviation<TAB>0.176

Macro average<TAB>f1: mean<TAB>56.3
Macro average<TAB>f1: max deviation<TAB>1.03
Macro average<TAB>f1: standard deviation<TAB>0.422
Class  1     <TAB>f1: mean<TAB>55.9
Class  1     <TAB>f1: max deviation<TAB>4.34
Class  1     <TAB>f1: standard deviation<TAB>1.56
Class  2     <TAB>f1: mean<TAB>40.0
Class  2     <TAB>f1: max deviation<TAB>2.69
Class  2     <TAB>f1: standard deviation<TAB>1.22
Class  3     <TAB>f1: mean<TAB>57.3
Class  3     <TAB>f1: max deviation<TAB>0.764
Class  3     <TAB>f1: standard deviation<TAB>0.303
Class  4     <TAB>f1: mean<TAB>71.9
Class  4     <TAB>f1: max deviation<TAB>0.540
Class  4     <TAB>f1: standard deviation<TAB>0.202

<TAB>accuracy: mean<TAB>64.2
<TAB>accuracy: max deviation<TAB>0.419
<TAB>accuracy: standard deviation<TAB>0.195

'

heri-stat-addons eval_results/evaluation?.txt 2>&1 |
    sed 's/	/<TAB>/g' |
    cmp 'heri-stat-addons #2' \
'Macro average precision: mean, max/std. deviation  : 60.4   1.39  0.565
Class  1      precision: mean, max/std. deviation  : 63.3   2.94   1.20
Class  2      precision: mean, max/std. deviation  : 51.3   5.51   2.12
Class  3      precision: mean, max/std. deviation  : 58.8  0.738  0.328
Class  4      precision: mean, max/std. deviation  : 68.1   1.20  0.430

Macro average recall: mean, max/std. deviation     : 53.7   1.20  0.508
Class  1      recall: mean, max/std. deviation     : 50.1   5.95   2.17
Class  2      recall: mean, max/std. deviation     : 32.8   2.76   1.15
Class  3      recall: mean, max/std. deviation     : 55.9   1.60  0.750
Class  4      recall: mean, max/std. deviation     : 76.1  0.441  0.176

Macro average f1: mean, max/std. deviation         : 56.3   1.03  0.422
Class  1      f1: mean, max/std. deviation         : 55.9   4.34   1.56
Class  2      f1: mean, max/std. deviation         : 40.0   2.69   1.22
Class  3      f1: mean, max/std. deviation         : 57.3  0.764  0.303
Class  4      f1: mean, max/std. deviation         : 71.9  0.540  0.202

              accuracy: mean, max/std. deviation   : 64.2  0.419  0.195

'
