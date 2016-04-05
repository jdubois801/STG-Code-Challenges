To run the Scheme code, you will need a Scheme interpreter.  A nice one is available
online at http://repl.it/languages/Scheme/

The code implements a greedy solution to the change making problem on US currency.  This
was shown to be sufficient to find the minimum number of coins because the US currency coin
set is "canonical"[1] and a greedy algorithm will always find the minimum change set for a
"canonical" coin system.[2]

The code can be run on your source data by invoking the make-change function like:
(make-change 123.45)


Cai, X. (2009, March 21). Canonical Coin Systems for Change-Making Problems. Retrieved December 10, 2014, from http://arxiv.org/pdf/0809.0400.pdf

Pearson, D. (1994, June 14). A Polynomial-time Algorithm for the Change Making Problem. Retrieved December 10, 2014, from http://graal.ens-lyon.fr/~abenoit/algo09/coins2.pdf