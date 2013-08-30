$Title  Data for Oil Pipeline Design Problem

Set n nodes in the oil pipeline network /
    1   H87
    2   ECHIRA
    3   SIMBA-CONOCO-C
    4   AGIP-TASSI
    5   SIMBA-CONOCO-B
    6   J87
    7   CONN07
    8   MBASSI-CONOCO
    9   WELL09
    10  NAMBA-TENNECO
    11  ELF-B
    12  NDOGO-C-ELF
    13  PANGA-AGIP
    14  BIGORNEAU
    15  CONN15
    16  AGIP-PANGA-B
    17  CONN17
    18  MASSANGA-TENNECO-A
    19  WELL19
    20  MASSANGA-TENNECO-B
    21  TCHIBALA-ELF
    22  HOURICULA
    23  LUCINA-SHELL
    24  CONN24
    25  CONN25
    26  TCHIBOBO-TRITON-A
    27  CONN27
    28  MWENGUI-ELF
    29  MBYA-ELF
    30  CONN30
    31  TCHIBOBO-TRITON-B
    32  K8
    33  GAMBA /
    k            type of oil pipe / 1*6 /

Parameters
     cap(k)  capacity of type k oil pipe / 2 5, 3 10, 4 25, 5 50, 6 100 /
     pipecost(k) monetary units for type k capacity / 2 10, 3 15, 4 25, 5 40, 6 65 /
     p(n)   production at each node /
       1   5, 2   7, 3   5, 4   6, 5   5, 6   4, 8   7, 9   3, 10  5,
       11  4, 12  3, 13  6, 14  9, 16  5, 18  6, 19  5, 20  4, 21  6,
       22  3, 23  8, 26  5, 28  5, 29 10, 31  6, 32  6 /
     edgedist(n,n) generalized distance of each edge /
       1 .2   3.50, 1 .3   1.90, 1 .4   5.40, 2 .3   3.70, 2 .7   1.15,
       3 .4   4.90, 3 .5   2.50, 3 .7   2.60, 3 .33  4.80, 4 .5   5.30,
       4 .6   4.00, 5 .6   4.30, 5 .8   2.70, 5 .9   2.10, 5 .33  3.75,
       6 .8   2.60, 7 .33  1.60, 8 .9   2.20, 8 .10  2.20, 9 .12  2.30,
       9 .33  1.60, 10.11  2.00, 10.13  2.80, 10.33  5.30, 11.12  1.10,
       11.13  1.80, 12.13  2.50, 12.14  1.20, 12.33  3.00, 13.14  2.10,
       13.16  3.20, 14.15  1.20, 14.16  5.30, 15.16  6.30, 15.17  2.10,
       15.33  1.65, 16.17  4.80, 17.19  7.30, 17.24  2.70, 18.19  1.50,
       19.20  1.80, 19.21  0.90, 19.23  3.00, 20.21  1.30, 20.26  2.20,
       20.29  4.80, 21.22  2.50, 21.23  2.80, 21.26  2.90, 22.23  0.80,
       23.24  2.40, 23.25  3.00, 23.26  5.00, 23.29  3.70, 24.25  0.90,
       24.29  4.50, 25.29  3.30, 25.30  0.90, 26.27  1.20, 26.28  2.80,
       26.31  2.50, 27.28  2.10, 27.31  1.50, 28.29  1.30, 28.31  3.00,
       29.30  2.60, 29.31  4.00, 30.32  0.90 /

Set       regnode(n)   non-port nodes
          port(n)      port
          arc(n,n)     arcs in the network
          kk(k)        reduced set of pipe line types

Parameter dist(n,n)    the distance of the arcs
;

dist(m,n) = edgedist(m,n) + edgedist(n,m);
arc(m,n)$dist(m,n) = yes;

* Last node is the port
port(n)$(card(n)=ord(n)) = yes;
regnode(n) = yes; regnode(port) = no;
arc(port,n) = no;

kk(k) = yes; kk('1') = no; kk('2') = no;
pipecost1 = pipecost('2');
cap1 = cap('2');
* Adjust data for removed pipe line type
pipecost(kk) = pipecost(kk) - pipecost1;
cap(kk) = cap(kk) - cap1;

