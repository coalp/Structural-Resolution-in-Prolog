% Q1 of LPN Sec. 4.5
% An example for relation combine1:
% ([1,2,3],[a,b,c],[1,a,2,b,3,c]).

combine1([],[],[]).
combine1([H1|L1],[H2|L2],[H1,H2|L3]):- combine1(L1,L2,L3).

% An example for relation combine2.
% ([1,2,3],[a,b,c],[ [1,a] , [2,b] , [3,c] ])
combine2([],[],[]).
combine2([H1|L1],[H2|L2],[[H1,H2]|L3]):- combine2(L1,L2,L3).

% An example for relation combine3.
% ([1,2,3],[a,b,c],[j(1,a),j(2,b),j(3,c)])
combine3([],[],[]).
combine3([H1|L1],[H2|L2],[j(H1,H2)|L3]):- combine3(L1,L2,L3).
