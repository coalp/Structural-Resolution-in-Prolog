% choose clauses by term matching instead of unification
% *- matching is checked  by using built_in predicate subsumes_term/2.
% *- Builtin  copy_term/2 is used to  make a copy  of a goal to use to
%    search  for a matching rule  without instantiating variables from
%    the goal. This predicate has some limitation regarding the ground
%    arguments  of the goal,  which is shared between the goal and its
%    copy, meaning that if a ground argument in the copy is forcefully
%    modified using setarg/3 then such modification will be synchro-
%    nised to the goal and vice versa.

solve(Goal) :- solve(Goal,[]).
solve([],[]).
solve([],[G|Goals]) :- solve(G, Goals).
solve([A|Bs], Goals) :-
           append(Bs, Goals, Goals1),
           solve(A, Goals1).
solve(A,Goals) :-
          matching_rule(A, Body),
          solve(Body, Goals).

matching_rule(A, Body) :-
       copy_term(A,A_copy),
       rule(A_copy,Body,Ref),
       rule(A1,_,Ref),
       subsumes_term(A1,A).

% rule(Head, Body, Ref).
% Object program clauses shall be represented in the above way.
% This echos built_in predicate clause/3  which, given a clause
% head,  returns the  body as  well  as an unique identifer for
% that  clause.  When the  rules are not represented in default
% way  using  ':-'  operator,  the identifier shall be provided
% explicitly.

% sample object program


rule(member(X,[X|_]),          [], ref_1).
rule(member(X,[_|Y]), member(X,Y), ref_2).
rule(member(a,[a,_,_]),        [], ref_3).
rule(member(a,[_,a,_]),        [], ref_4).
rule(member(a,[_,_,a]),        [], ref_5).

rule(related(abraham, issac),   [], ref_6).
rule(related(abraham, joseph),  [], ref_7).
rule(related(abraham, _),       [], ref_8).
rule(related(_, tom),           [], ref_9).
rule(related(_, _),             [], ref_10).
