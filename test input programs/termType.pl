

termType(X, variable) :- var(X).

termType(X, atom) :- atom(X).

termType(X, number) :- number(X).

termType(X, constant) :- atomic(X).

termType(X,simple_term) :- atomic(X).
termType(X,simple_term) :- var(X).

termType(X,complex_term) :- complex_term(X).

termType(X,term) :- termType(X,simple_term).
termType(X,term) :- complex_term(X).


complex_term(X) :- nonvar(X), functor(X,_,A),A > 0.

groundTerm(X) :- atomic(X).
groundTerm(X) :- complex_term(X), '=..'(X,L), groundTermS(L).

groundTermS([]).
groundTermS([H|T]) :-  groundTerm(H), groundTermS(T).
