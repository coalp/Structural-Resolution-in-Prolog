

len([],0).
len([_|T],N) :- len(T,X), N is X+1.
/*
* the order of goals in the second clause
* has to be like that. Otherwise, in the following case,
* len([_|T],N) :-  N is X+1,len(T,X).
* When a term like len([a,b,c],3) is unified with len([_|T],N),
* there will be insufficient variable instantiation to evaluate
* the first subgoal ?- 3 is _G4+1.
*/

accLen([],A,A).
accLen([_|T],X,L) :- Acc is X+1, accLen(T,Acc,L).

leng(List, Len) :- accLen(List, 0, Len).

/*
The problem for the accen is that when query about what list has length 10,
the computer will first give a correct answer, but then fall into
non-termination by trying to verify even longer lists. To avoid this, add
atom Acc < L, however, this will cause the program to be only able to work
for such query, not the other way around.
*/
