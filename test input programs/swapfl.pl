
/*
* Examples for relation swapfl:
* [a,b,c,d] R [d,b,c,a]
* [yue, 1,2,3, beata] R [beata, 1,2,3, yue]
*/

append([],L,L).
append([H|T],L,[H|R]) :- append(T,L,R).


swapfl_v1(L1,L2) :-
  append([H_L1], T_L1, L1),
  append(Hs_T_L1, [T_T_L1], T_L1),
  append([T_T_L1], T_L2, L2),
  append(Hs_T_L1,[H_L1],T_L2).
/*
If L1 is queried about amd L2 is given, the append version of swapfl
will first give a correct answer then fall into non-termination. Because
the way it wors is that is tries different structure for L1 to see which
one fits, starting from L1 having 1 elements, then two elements, and
so on, until L1 happens to be equal in length to L2. Then it will continue
trying even longer possibility of L2, which is endless.
*/

swapfl_v2([A,B],[B,A]).
swapfl_v2([H1,X|T1],[H2,X|T2]) :- swapfl_v2([H1|T1],[H2|T2]).

/*
The key to define a relation recursively, is to find how how to inductively
generate new members for that relation, starting from a given member.
*/
