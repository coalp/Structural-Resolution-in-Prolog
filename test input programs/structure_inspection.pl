% length(List,++Length)
% length check, or generate a list of variables of length Length

mylength([],0).
mylength([_|T], N) :- N > 0, N1 is N - 1, mylength(T,N1).

%myrange(++BottomValue,++TopValue, -NumList)
myrange(N,N,[N]).
myrange(M,N,[M|T]) :- M < N, M1 is M + 1, myrange(M1,N,T).

% build list bottom-up
% myrange2(++BottomValue,++TopValue, -NumList)
% e.g. ?- myrange2(1,6,L).
myrange2(M,N,L) :- myrange2(M,N,[N],L).

myrange2(M,N,Temp,L) :- M < N,
                        N1 is N - 1,
                        myrange2(M,N1,[N1|Temp],L).
myrange2(M,M,Temp,Temp).

% myflatten(+List,-FList)
% Flist is flattened version of List, and List shall be a possibly nested list of constant symbols.
% Flattening corresponds to a depth firsst traversal of a tree of the list.

myflatten(Xs,Ys) :- myflatten(Xs,[],Ys).

% the middle argument of myflatten/3 is a stack for lists yet to flatten.
myflatten([],[],[]).
myflatten([H|T],S,[H|Ys]) :- atomic(H), H \= [], myflatten(T,S,Ys).
myflatten([H|T],S,Ys) :- non_empty_list(H),myflatten(H,[T|S],Ys).
myflatten([],[Item|Items],Ys) :- myflatten(Item,Items,Ys).

non_empty_list([_|_]).

% The answer is computed top-down, and each predicate call is to compute the remining part  of the answer.


% Given a ground term t, t1 is t's subterms if:
% - t1 = t, or
% - t1 is a subterm of any of t's argument, if any.

% subterm(Sub,++Term).
% true if Term has some subterm that unifis with Sub. Could be used to either find subterms or check subterms.

subterm(Term,Term).
subterm(Sub,Term) :- compound(Term), functor(Term,_,Arity), subterm(Arity,Sub,Term).

% auxiliary subterm/3. Using two clauses, one for driving the iteration together with underlying backtracking,
% they other is to compare.
subterm(Arity, Sub,Term) :- Arity > 1, Ari is Arity - 1, subterm(Ari, Sub,Term).
subterm(Arity,Sub,Term) :- arg(Arity, Term, Arg), subterm(Sub,Arg).

% The tree of Term is traversed in a depth first manner.


% substitute(++OldSub,++NewSub, ++OldTerm, -NewTerm).
% True if substituting all occurrence of subterm OldSub by NewSub in OldTerm gives NewTerm.

% Whe OldTerm unifies with OldSub, i.e.
% The sub term to be replaced is the entire term, which could be ether atomic or compound,
% Then the NewTerm is simply unified with NewSub.
% e.g. substitute NewSub = a for OldSub(OldTerm) = b in OldTerm = b gives NewSub = a.
substitute(OldTerm,NewSub,OldTerm,NewSub).

% When OldSub and OldTerm is not identical, there are further two cases which are dealt with by the following
% two clauses respectively:
% To be processed term OldTerm is a constant, since it doesn't unify with Old, it shall be intact
% e.g. substitute NewSub = a for OldSub = b in OldTerm = c gives c intact.
% e.g. substitute NewSub = a(t) for OldSub = b(t) in OldTerm = c gives c intact.
substitute(OldSub,_,OldTerm,OldTerm) :-  OldTerm \= OldSub, atomic(OldTerm).
% To be processed term OldTerm is a compound term, then its arguments shall be inspected and necessary replacement be made.
% -- The test compound(OldTerm) and OldTerm \= OldSub in third clause, as well as the test as the body of the second clause,
% -- are necessary since arriving at these junctures not only if previous clauses fail, but also if previous clauses success and program back tracks.
substitute(OldSub,NewSub, OldTerm, NewTerm) :-
       OldTerm \= OldSub,
       compound(OldTerm),
       functor(OldTerm,Functor,Arity),
       functor(NewTerm,Functor,Arity), % NewTerm here is just a template, sharing the same principle functor and arity as OldTerm but all it arguments are uninstantiated variables
       substitute(Arity, OldSub, NewSub, OldTerm, NewTerm).

% Auxiliary predicate to populate the template for NewTerm
substitute(N, OldSub ,NewSub, OldTerm, Template) :-
       N > 0,
       arg(N,OldTerm,OldArg),
       substitute(OldSub, NewSub, OldArg, NewArg),
       arg(N,Template,NewArg),
       N1 is N - 1,
       substitute(N1, OldSub ,NewSub, OldTerm, Template).
% When N is 1 in above precedure, all arguments in the template has been filled,
% The remaining task is to let the program terminate successfully so the computed substitutions could be passed up.
substitute(0, _ , _ , _ , _).
