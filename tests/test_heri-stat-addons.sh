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
'Macro average<TAB>mean (precision)<TAB> 60.4%
Macro average<TAB>max deviation (precision)<TAB> 1.39%
Macro average<TAB>standard deviation (precision)<TAB>0.565
Class  1     <TAB>mean (precision)<TAB> 63.3%
Class  1     <TAB>max deviation (precision)<TAB> 2.94%
Class  1     <TAB>standard deviation (precision)<TAB>  1.2
Class  2     <TAB>mean (precision)<TAB> 51.3%
Class  2     <TAB>max deviation (precision)<TAB> 5.51%
Class  2     <TAB>standard deviation (precision)<TAB> 2.12
Class  3     <TAB>mean (precision)<TAB> 58.8%
Class  3     <TAB>max deviation (precision)<TAB>0.738%
Class  3     <TAB>standard deviation (precision)<TAB>0.328
Class  4     <TAB>mean (precision)<TAB> 68.1%
Class  4     <TAB>max deviation (precision)<TAB>  1.2%
Class  4     <TAB>standard deviation (precision)<TAB> 0.43

Macro average<TAB>mean (recall)<TAB> 53.7%
Macro average<TAB>max deviation (recall)<TAB>  1.2%
Macro average<TAB>standard deviation (recall)<TAB>0.508
Class  1     <TAB>mean (recall)<TAB> 50.1%
Class  1     <TAB>max deviation (recall)<TAB> 5.95%
Class  1     <TAB>standard deviation (recall)<TAB> 2.17
Class  2     <TAB>mean (recall)<TAB> 32.8%
Class  2     <TAB>max deviation (recall)<TAB> 2.76%
Class  2     <TAB>standard deviation (recall)<TAB> 1.15
Class  3     <TAB>mean (recall)<TAB> 55.9%
Class  3     <TAB>max deviation (recall)<TAB>  1.6%
Class  3     <TAB>standard deviation (recall)<TAB> 0.75
Class  4     <TAB>mean (recall)<TAB> 76.1%
Class  4     <TAB>max deviation (recall)<TAB>0.441%
Class  4     <TAB>standard deviation (recall)<TAB>0.176

Macro average<TAB>mean (f1)<TAB> 56.3%
Macro average<TAB>max deviation (f1)<TAB> 1.03%
Macro average<TAB>standard deviation (f1)<TAB>0.422
Class  1     <TAB>mean (f1)<TAB> 55.9%
Class  1     <TAB>max deviation (f1)<TAB> 4.34%
Class  1     <TAB>standard deviation (f1)<TAB> 1.56
Class  2     <TAB>mean (f1)<TAB>   40%
Class  2     <TAB>max deviation (f1)<TAB> 2.69%
Class  2     <TAB>standard deviation (f1)<TAB> 1.22
Class  3     <TAB>mean (f1)<TAB> 57.3%
Class  3     <TAB>max deviation (f1)<TAB>0.764%
Class  3     <TAB>standard deviation (f1)<TAB>0.303
Class  4     <TAB>mean (f1)<TAB> 71.9%
Class  4     <TAB>max deviation (f1)<TAB> 0.54%
Class  4     <TAB>standard deviation (f1)<TAB>0.202

<TAB>mean (accuracy)<TAB> 64.2%
<TAB>max deviation (accuracy)<TAB>0.419%
<TAB>standard deviation (accuracy)<TAB>0.195

'

heri-stat-addons eval_results/evaluation?.txt 2>&1 |
    sed 's/	/<TAB>/g' |
    cmp 'heri-stat-addons #2' \
'Macro average mean (precision)              :   60.4%
Macro average max/std deviation (precision) :   1.39%    0.565
Class  1      mean (precision)              :   63.3%
Class  1      max/std deviation (precision) :   2.94%      1.2
Class  2      mean (precision)              :   51.3%
Class  2      max/std deviation (precision) :   5.51%     2.12
Class  3      mean (precision)              :   58.8%
Class  3      max/std deviation (precision) :  0.738%    0.328
Class  4      mean (precision)              :   68.1%
Class  4      max/std deviation (precision) :    1.2%     0.43

Macro average mean (recall)                 :   53.7%
Macro average max/std deviation (recall)    :    1.2%    0.508
Class  1      mean (recall)                 :   50.1%
Class  1      max/std deviation (recall)    :   5.95%     2.17
Class  2      mean (recall)                 :   32.8%
Class  2      max/std deviation (recall)    :   2.76%     1.15
Class  3      mean (recall)                 :   55.9%
Class  3      max/std deviation (recall)    :    1.6%     0.75
Class  4      mean (recall)                 :   76.1%
Class  4      max/std deviation (recall)    :  0.441%    0.176

Macro average mean (f1)                     :   56.3%
Macro average max/std deviation (f1)        :   1.03%    0.422
Class  1      mean (f1)                     :   55.9%
Class  1      max/std deviation (f1)        :   4.34%     1.56
Class  2      mean (f1)                     :     40%
Class  2      max/std deviation (f1)        :   2.69%     1.22
Class  3      mean (f1)                     :   57.3%
Class  3      max/std deviation (f1)        :  0.764%    0.303
Class  4      mean (f1)                     :   71.9%
Class  4      max/std deviation (f1)        :   0.54%    0.202

              mean (accuracy)               :   64.2%
              max/std deviation (accuracy)  :  0.419%    0.195

'
