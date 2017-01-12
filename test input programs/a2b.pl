% example for recursing down a pair of lists simutaneously

% We define a binry relation where the first member is a list of
% constant a and the second member is a list of contant b of the same length
% that of the first member.

a2b([], []).
a2b([a|Ta],[b|Tb]) :- a2b(Ta,Tb).

zero2one([],[]).
zero2one([0|T0],[s(0)|Ts0]):- zero2one(T0,Ts0).

my_member(X,[X|_]).
my_member(X,[_|T]) :-my_member(X,T).
