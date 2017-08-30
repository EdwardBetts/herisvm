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
'Macro average<TAB>mean(P)<TAB> 60.4%
Macro average<TAB>max deviation(P)<TAB> 1.39%
Macro average<TAB>standard deviation(P)<TAB>0.565
Class  1     <TAB>mean(P)<TAB> 63.3%
Class  1     <TAB>max deviation(P)<TAB> 2.94%
Class  1     <TAB>standard deviation(P)<TAB>  1.2
Class  2     <TAB>mean(P)<TAB> 51.3%
Class  2     <TAB>max deviation(P)<TAB> 5.51%
Class  2     <TAB>standard deviation(P)<TAB> 2.12
Class  3     <TAB>mean(P)<TAB> 58.8%
Class  3     <TAB>max deviation(P)<TAB>0.738%
Class  3     <TAB>standard deviation(P)<TAB>0.328
Class  4     <TAB>mean(P)<TAB> 68.1%
Class  4     <TAB>max deviation(P)<TAB>  1.2%
Class  4     <TAB>standard deviation(P)<TAB> 0.43

Macro average<TAB>mean(R)<TAB> 53.7%
Macro average<TAB>max deviation(R)<TAB>  1.2%
Macro average<TAB>standard deviation(R)<TAB>0.508
Class  1     <TAB>mean(R)<TAB> 50.1%
Class  1     <TAB>max deviation(R)<TAB> 5.95%
Class  1     <TAB>standard deviation(R)<TAB> 2.17
Class  2     <TAB>mean(R)<TAB> 32.8%
Class  2     <TAB>max deviation(R)<TAB> 2.76%
Class  2     <TAB>standard deviation(R)<TAB> 1.15
Class  3     <TAB>mean(R)<TAB> 55.9%
Class  3     <TAB>max deviation(R)<TAB>  1.6%
Class  3     <TAB>standard deviation(R)<TAB> 0.75
Class  4     <TAB>mean(R)<TAB> 76.1%
Class  4     <TAB>max deviation(R)<TAB>0.441%
Class  4     <TAB>standard deviation(R)<TAB>0.176

Macro average<TAB>mean(F1)<TAB> 56.3%
Macro average<TAB>max deviation(F1)<TAB> 1.03%
Macro average<TAB>standard deviation(F1)<TAB>0.422
Class  1     <TAB>mean(F1)<TAB> 55.9%
Class  1     <TAB>max deviation(F1)<TAB> 4.34%
Class  1     <TAB>standard deviation(F1)<TAB> 1.56
Class  2     <TAB>mean(F1)<TAB>   40%
Class  2     <TAB>max deviation(F1)<TAB> 2.69%
Class  2     <TAB>standard deviation(F1)<TAB> 1.22
Class  3     <TAB>mean(F1)<TAB> 57.3%
Class  3     <TAB>max deviation(F1)<TAB>0.764%
Class  3     <TAB>standard deviation(F1)<TAB>0.303
Class  4     <TAB>mean(F1)<TAB> 71.9%
Class  4     <TAB>max deviation(F1)<TAB> 0.54%
Class  4     <TAB>standard deviation(F1)<TAB>0.202

<TAB>mean(A)<TAB> 64.2%
<TAB>max deviation(A)<TAB>0.419%
<TAB>standard deviation(A)<TAB>0.195

'

heri-stat-addons eval_results/evaluation?.txt 2>&1 |
    sed 's/	/<TAB>/g' |
    cmp 'heri-stat-addons #2' \
'Macro average mean(P)                :   60.4%
Macro average max/std deviation(P)   :   1.39%    0.565
Class  1      mean(P)                :   63.3%
Class  1      max/std deviation(P)   :   2.94%      1.2
Class  2      mean(P)                :   51.3%
Class  2      max/std deviation(P)   :   5.51%     2.12
Class  3      mean(P)                :   58.8%
Class  3      max/std deviation(P)   :  0.738%    0.328
Class  4      mean(P)                :   68.1%
Class  4      max/std deviation(P)   :    1.2%     0.43

Macro average mean(R)                :   53.7%
Macro average max/std deviation(R)   :    1.2%    0.508
Class  1      mean(R)                :   50.1%
Class  1      max/std deviation(R)   :   5.95%     2.17
Class  2      mean(R)                :   32.8%
Class  2      max/std deviation(R)   :   2.76%     1.15
Class  3      mean(R)                :   55.9%
Class  3      max/std deviation(R)   :    1.6%     0.75
Class  4      mean(R)                :   76.1%
Class  4      max/std deviation(R)   :  0.441%    0.176

Macro average mean(F1)               :   56.3%
Macro average max/std deviation(F1)  :   1.03%    0.422
Class  1      mean(F1)               :   55.9%
Class  1      max/std deviation(F1)  :   4.34%     1.56
Class  2      mean(F1)               :     40%
Class  2      max/std deviation(F1)  :   2.69%     1.22
Class  3      mean(F1)               :   57.3%
Class  3      max/std deviation(F1)  :  0.764%    0.303
Class  4      mean(F1)               :   71.9%
Class  4      max/std deviation(F1)  :   0.54%    0.202

              mean(A)                :   64.2%
              max/std deviation(A)   :  0.419%    0.195

'
