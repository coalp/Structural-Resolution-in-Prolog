clause_tree(true) :- !.
clause_tree((G,R)) :-
   !,
   clause_tree(G),
   clause_tree(R).

clause_tree(G) :-
  (predicate_property(G, built_in);   % for built-in's
   predicate_property(G, nodebug) ),  % for std library preds
  !,
  call(G).

clause_tree(A) :-                     % rewriting reduction
            unifying_and_matching_rule(A, Body),
            clause_tree(Body).
clause_tree(A) :-                     % substitution reduction.
            unifying_not_matching_rule(A, _),        % Note 1
            clause_tree(A).                          % Note 1


unifying_and_matching_rule(A, Body) :-
         copy_term(A,A_copy),
         clause(A_copy,_,Ref),
         clause(A1,_,Ref),
         subsumes_term(A1,A),
         clause(A,Body,Ref).

unifying_not_matching_rule(A, Body) :-
        copy_term(A,A_copy),
        clause(A_copy,_,Ref),
        clause(A1,_,Ref),
        \+ subsumes_term(A1,A),
        clause(A,Body,Ref).

% Note 1: These  are the only  parts  changed compared with the matching
%         first  vanilla of continuation style. Here, after an unifying-
%         but-matching clause is found, what to evaluate next is not the
%         instantiated body of  the  clause but the instantiated head of
%         the clause. This corresponds to substitution reduction.
