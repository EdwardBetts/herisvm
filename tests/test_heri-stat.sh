remove_fractions (){
    awk '{gsub(/0[.][0-9]+/, "0.NNNN"); print}' "$@"
}

# heri-stat
heri-stat golden1.txt result1.txt 2>&1 |
cmp 'heri-stat #1 defaults' \
'Class  1      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  2      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  3      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat golden5.txt result5.txt 2>&1 |
cmp 'heri-stat #1.1 defaults {golden,result}5.txt' \
'Class  A      P, R, F1:  1          1/1      ,  0.5        1/2      ,  0.6667
Class  B      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  C      P, R, F1:  1          3/3      ,  0.75       3/4      ,  0.8571
Class  E      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
Class  O      P, R, F1:  0          0/4      ,  0          0/0      ,  0     
Accuracy              :  0.7333    11/15     
Macro average P, R, F1:  0.8                 ,  0.55                ,  0.6466
'

heri-stat -uO golden5.txt result5.txt 2>&1 |
cmp 'heri-stat #1.1 defaults {golden,result}5.txt with O as "unclassified"' \
'Class  A      P, R, F1:  1          1/1      ,  0.5        1/2      ,  0.6667
Class  B      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  C      P, R, F1:  1          3/3      ,  0.75       3/4      ,  0.8571
Class  E      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
Micro average P, R, F1:  1         11/11     ,  0.7333    11/15     ,  0.8462
Macro average P, R, F1:  1                   ,  0.6875              ,  0.8082
'

heri-stat golden4.txt result4.txt 2>&1 |
cmp 'heri-stat #1 defaults with extra zeros' \
'Class  -1     P, R, F1:  0.5        2/4      ,  1          2/2      ,  0.6667
Class  1      P, R, F1:  1          2/2      ,  0.5        2/4      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.75                ,  0.75                ,  0.6667
'

heri-stat -R golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #2 -R' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

# heri-stat
heri-stat golden2.txt result2.txt 2>&1 |
cmp 'heri-stat #3 symbolic classes' \
'Class  A      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  B      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  C      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat -mR golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #4 -m' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat -Rr golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #5 -r' \
'Class  1     	precision	1.0	2/2
Class  1     	recall	0.NNNN	2/3
Class  1     	f1	0.NNNN	
Class  2     	precision	0.NNNN	1/2
Class  2     	recall	0.NNNN	1/2
Class  2     	f1	0.NNNN	
Class  3     	precision	0.NNNN	1/2
Class  3     	recall	1.0	1/1
Class  3     	f1	0.NNNN	
	accuracy	0.NNNN	4/6
'

heri-stat -Rc golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #6 -s' \
'	accuracy	0.NNNN	4/6
Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat -Rac golden1.txt result1.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #7 -Ras' \
'Macro average	precision	0.NNNN	
Macro average	recall	0.NNNN	
Macro average	f1	0.NNNN	
'

heri-stat golden3.txt result3.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #8 all equal' \
'Class  A      P, R, F1:  0          0/0      ,  0          0/6      ,  0     
Class  B      P, R, F1:  0          0/6      ,  0          0/0      ,  0     
Accuracy              :  0          0/6      
Macro average P, R, F1:  0                   ,  0                   ,  0     
'

heri-stat golden3.txt /dev/null 2>&1 |
remove_fractions |
cmp 'heri-stat #9 bad length' \
'Golden data and predictions should contain the same amount of classes
'

heri-stat golden3.txt bad_file.txt 2>&1 |
remove_fractions |
cmp 'heri-stat #10 bad input' \
"Bad line '' in file 'bad_file.txt'
"

heri-stat -1 all_in_one1.txt 2>&1 |
cmp 'heri-stat #11 option -1' \
'Class  1      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  2      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  3      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat golden2.txt result2.txt 2>&1 |
cmp 'heri-stat #12 symbolic classes and -1' \
'Class  A      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  B      P, R, F1:  0.5        1/2      ,  0.5        1/2      ,  0.5   
Class  C      P, R, F1:  0.5        1/2      ,  1          1/1      ,  0.6667
Accuracy              :  0.6667     4/6      
Macro average P, R, F1:  0.6667              ,  0.7222              ,  0.6556
'

heri-stat -t0.5 golden5.txt result5_prob.txt 2>&1 |
cmp 'heri-stat #13.1 -t 0.5' \
'Class  A      P, R, F1:  1          2/2      ,  1          2/2      ,  1     
Class  B      P, R, F1:  1          3/3      ,  1          3/3      ,  1     
Class  C      P, R, F1:  1          4/4      ,  1          4/4      ,  1     
Class  E      P, R, F1:  1          6/6      ,  1          6/6      ,  1     
Micro average P, R, F1:  1         15/15     ,  1         15/15     ,  1     
Macro average P, R, F1:  1                   ,  1                   ,  1     
'

heri-stat -t 0.6 golden5.txt result5_prob.txt 2>&1 |
cmp 'heri-stat #13.2 -t 0.6' \
'Class  A      P, R, F1:  1          2/2      ,  1          2/2      ,  1     
Class  B      P, R, F1:  1          3/3      ,  1          3/3      ,  1     
Class  C      P, R, F1:  1          4/4      ,  1          4/4      ,  1     
Class  E      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
Micro average P, R, F1:  1         14/14     ,  0.9333    14/15     ,  0.9655
Macro average P, R, F1:  1                   ,  0.9583              ,  0.9773
'

heri-stat -t 0.7 golden5.txt result5_prob.txt 2>&1 |
cmp 'heri-stat #13.3 -t 0.7' \
'Class  A      P, R, F1:  1          1/1      ,  0.5        1/2      ,  0.6667
Class  B      P, R, F1:  1          3/3      ,  1          3/3      ,  1     
Class  C      P, R, F1:  1          4/4      ,  1          4/4      ,  1     
Class  E      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
Micro average P, R, F1:  1         13/13     ,  0.8667    13/15     ,  0.9286
Macro average P, R, F1:  1                   ,  0.8333              ,  0.8939
'

heri-stat -t 0.8 golden5.txt result5_prob.txt 2>&1 |
cmp 'heri-stat #13.4 -t 0.8' \
'Class  A      P, R, F1:  1          1/1      ,  0.5        1/2      ,  0.6667
Class  B      P, R, F1:  1          2/2      ,  0.6667     2/3      ,  0.8   
Class  C      P, R, F1:  1          4/4      ,  1          4/4      ,  1     
Class  E      P, R, F1:  1          5/5      ,  0.8333     5/6      ,  0.9091
Micro average P, R, F1:  1         12/12     ,  0.8       12/15     ,  0.8889
Macro average P, R, F1:  1                   ,  0.75                ,  0.8439
'

heri-stat -t 0.93 golden5.txt result5_prob.txt 2>&1 |
cmp 'heri-stat #13.5 -t 0.93' \
'Class  A      P, R, F1:  0          0/0      ,  0          0/2      ,  0     
Class  B      P, R, F1:  0          0/0      ,  0          0/3      ,  0     
Class  C      P, R, F1:  1          3/3      ,  0.75       3/4      ,  0.8571
Class  E      P, R, F1:  1          3/3      ,  0.5        3/6      ,  0.6667
Micro average P, R, F1:  1          6/6      ,  0.4        6/15     ,  0.5714
Macro average P, R, F1:  0.5                 ,  0.3125              ,  0.381 
'
