% a parse tree is always a ground complex term.

printParseTree(T) :- printTerm(T, 0).

printTerm(T, Indent) :- atomic(T), tab(Indent),write(T).
printTerm(T, Indent) :- complex_term(T),
                T =.. [F|Args],
                tab(Indent),write(F),write('('),nl,
                IndentInc is Indent + 5,
                printTermList(Args,IndentInc),
                tab(Indent),write(')').
printTermList([],_).
printTermList([H|T],Indent) :- printTerm(H,Indent),nl,printTermList(T,Indent).

complex_term(X) :- nonvar(X), functor(X,_,A),A > 0.
