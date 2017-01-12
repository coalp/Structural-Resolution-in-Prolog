% Example query
% ?-s(X).
% Enumerate the a^n b^(2m) c^(2m) d^n formal language.

% N X N is a countable set.
/*
nat(0).
nat(X) :- nat(Y), X is Y + 1.
*/
% s_nat/1: natural number generator that works under structural resolution.
% sn stands for S-resolution Number.
s_nat(sn(0)).
s_nat(sn(X)) :-
      var(X),
      s_nat(Y),
      sn(Value) = Y,
      X is Value + 1.



% bounded_pair, e.g. (2,0), (1,1), (0,2) are
% bounded by natural number 2. I need a redicate
% that could generate all bounded pairs of a given
% natural number.

% pair is represented by a list

% bp_guarded, where bp stands for bounded pair.
% A guard is used to terminate the proof search.
% bp_guarded(<numeral guard>,<numeral>,<bounded pair>)
% <numeral guard> should be initialised to equal <numeral>.
bp_guarded(_,N,[N,0]).
bp_guarded(Guard,N,[C,D]) :-
    Guard > 0, Guard2 is Guard - 1,
    bp_guarded(Guard2,N,[A,B]),
    C is A - 1, D is B + 1.
% This works, but the code is not efficient enough, since
% there will be more book keeping as the pair deviate
% further from [N,0]
% There seems a choice: being able to present infinitely many results
% requires bookkeeping for many subgoal; while
% using accumulator means that there is little bookkeeping but large memory
% is needed for all the bounded pairs for a particular number, because
% these pairs will be given all at once.

% bounded_pair(<bound>,<bounded pair>)
% ?- bounded_pair(5,P).
bounded_pair(N,P) :- bp_guarded(N,N,P).


% cList: list with customised length A and uniform element N.
% accList(<numeral accumulator>, <list's uniform element>,
%        <accumulator list>, <output list>)
% <numeral accumulator> should be the expected length of <output list>

accList(0,_,L,L).
accList(A,X,AccL,L) :- Ac is A - 1, Ac >= 0, accList(Ac,X,[X|AccL],L).

% cList(<expected list length>, <expected uniform list element>,
%       <output list> )
cList(N,X,L) :- accList(N,X,[],L).

% enumerate N * N (cartesian product of the set of natural numbers)
% enum_pairs(P) :- nat(N),bounded_pair(N,P).
% new version of enum_pairs/1 that work under S-resolution
enum_pairs(P) :- s_nat(SN),SN = sn(N), bounded_pair(N,P).

s(ABCD) :-
  enum_pairs([N,M]),cList(N,a,A),cList(N,d,D),
  M2 is M * 2, cList(M2,b,B),cList(M2,c,C),
  append(A,B,AB),append(AB,C,ABC),append(ABC,D,ABCD).

append([],L,L).
append([H|L1],L2,[H|L3]) :- append(L1,L2,L3).

% trail 1
/*
mid_s --> [].
mid_s --> b,b,mid_s,c,c.


s --> a_part,mid_s,d_part.

a_part --> [].
a_part --> a, a_part.

a --> [a].
b --> [b].
c --> [c].
d --> [d].

d_part --> [].
d_part --> d, d_part.


% trail 2
s --> [].
s --> b,b,s,c,c.


a --> [a].
b --> [b].
c --> [c].
d --> [d].
*/

% natS(0).
% natS(s(X)) :- natS(X).

/*
bounded_pair(N,[N,0]).
bounded_pair(N,[C,D]) :-
    bounded_pair(N,[A,B]),
    C is A - 1, D is B + 1, C >= 0.
% Doesn't work, non-terminal after last answer
*/
/*
bounded_pair(N,[N,0]) :- natS(N).
bounded_pair(N,[A,s(B)]) :- bounded_pair(N,[s(A),B]).
% Doesn't work, non-terminal after last answer
*/
