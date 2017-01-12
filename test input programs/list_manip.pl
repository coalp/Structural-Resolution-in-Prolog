% :-use_module(loop_detect_draw_tree).

% :-use_module(s_resolution_cont_vanilla).
% :-use_module(vanilla).

variant(Term1,Term2) :-
  verify((numvars(Term1,0,N),numvars(Term2,0,N),Term1 == Term2)).

verify(Goal) :- \+ (\+ Goal).



non_id(X,Y) :- X == Y, !, fail.
non_id(_,_).

non_var(X) :- var(X),!,fail.
non_var(_).


% find last elem of a list.
% my_last(Last,List).
my_last(X, [X]).
my_last(X,[_|T]) :- my_last(X,T).


my_last_but_one(X,[X,_]).
my_last_but_one(X,[_|T]) :- my_last_but_one(X,T).

% k_th_elem(K, X, L) true if X is K-th element in list L.
% For indexing the list: k_th_elem(+K,-X,+List),

k_th_elem(K, X, L) :- k_th_elem(1, K, X, L).

k_th_elem(K,K,X,[X|_]).
k_th_elem(I,K,X,[_|T]) :- I1 is I + 1,  k_th_elem(I1,K,X,T).

% compress(List1,List2)
% consecutive redundant element from List1 are compressed into one copy, the result is List2.
% compress([a,a,b,b,a,a,c,d,c],L). L = [a,b,a,c,d,c].

/*  Incorrect answer: removing all redundent elems
compress(Xs,L) :- compress(Xs,[],L1), reverse(L1,L).

compress([X|T], Acc, L) :- member(X,Acc), compress(T,Acc,L).
compress([X|T],Acc, L) :- \+ member(X,Acc),compress(T,[X|Acc],L).
compress([],L,L).
*/

compress(Xs,L) :- compress(Xs,[],L1), reverse(L1,L).

compress([X|T], [], L) :- compress(T,[X],L).
compress([X|T], [X|Acc], L) :- compress(T,[X|Acc],L).
compress([X|T], [Y|Acc], L) :- X \= Y, compress(T,[X,Y|Acc],L).
compress([],L,L).


% pack(List1,List2)
% Every group of consecutive redundent elements in List1 are grouped into a sub-list. The result is List2.
% ?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

pack(L1,L2) :- pack(L1,[],L), reverse(L,L2).

pack([X|T], [], L) :- pack(T, [[X]],L).
pack([X|T], [[X|Xs]|Acc], L) :- pack(T,[[X,X|Xs]|Acc],L).
pack([X|T], [[Y|Ys]|Acc], L) :- X \= Y, pack(T,[[X],[Y|Ys]|Acc],L).
pack([],L,L).

% encode(List1,List2)
% List1 is a list of items, List2 is run-length encoded version of List1.
% ?- encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]


encode(L1,L2) :- pack(L1,L), reverse(L,L3), encode_pack(L3,[],L2).

encode_pack([[E|Es]|T], Acc, L) :- length([E|Es],N), encode_pack(T,[[N,E]|Acc],L).
encode_pack([],L,L).

% encode_modified(Ls,Cs)
% Cs is modified run-length encoding of Ls.
% replace [1,E] by E in the encoding.
encode_modified(L1,L2) :- encode(L1,L),encode_modified_aux(L,L2).

encode_modified_aux([[1,E]|Cs], [E|Cs_mod]) :- encode_modified_aux(Cs, Cs_mod).
encode_modified_aux([[N,E]|Cs],[[N,E]|Cs_mod]) :- N \= 1, encode_modified_aux(Cs, Cs_mod).
encode_modified_aux([], []).

% decode(Code, Word)
% decode Code [N,E] into N copies of E, as Word [E,E,...,E].
% E are expecetd to be charaacters
decode(L1,L2) :- decode(L1, [], L2).

decode_aux([1,E], [E]).
decode_aux([N,E],[E|T]) :- N > 1, N1 is N - 1, decode_aux([N1,E],T).

decode([],L,L).
decode([[N,E]|Cs], Acc, L) :-
       decode_aux([N,E], W),
       append(Acc, W, Acc1),
       decode(Cs, Acc1, L).
decode([E|Cs], Acc, L) :-
        E \= [_,_],
        append(Acc,[E],Acc1),
        decode(Cs, Acc1,L).

encode_direct([X|Xs], Cs) :- encode_direct(1,[[1,X]],Xs,Cs1), reverse(Cs1,Cs).
encode_direct([], []).

encode_direct(I, [[I,E]|Acc], [E|Xs], Cs) :-
       I1 is I + 1,
       encode_direct(I1, [[I1,E]|Acc],Xs,Cs).

encode_direct(I, [[I,E]|Acc], [X|Xs], Cs) :-
        E \= X,
        I > 1,
        encode_direct(1, [[1,X],[I,E]|Acc], Xs,Cs).
encode_direct(I, [[I,E]|Acc], [X|Xs], Cs) :-
        E \= X,
        I = 1,
        encode_direct(1, [[1,X],E|Acc], Xs,Cs).

encode_direct(_, [[N, E]|Cs], [], [[N,E]|Cs]) :- N > 1.
encode_direct(_, [[1, E]|Cs], [], [E|Cs]).

/* Initial working solution, [1,K] shall be modified to K.
encode_direct([X|Xs], Cs) :- encode_direct(1,[[1,X]],Xs,Cs1), reverse(Cs1,Cs).

encode_direct(I, [[I,E]|Acc], [E|Xs], Cs) :-
       I1 is I + 1,
       encode_direct(I1, [[I1,E]|Acc],Xs,Cs).

encode_direct(I, [[I,E]|Acc], [X|Xs], Cs) :-
        E \= X,
        encode_direct(1, [[1,X],[I,E]|Acc], Xs,Cs).
encode_direct(_, Cs, [], Cs).

*/
