% Of all unifying clauses, matching ones are used first.
% Therefore, unifying  clauses are sorted not only by their order of
% definition, but also whether they unify by matching or not.
% *- matching is checked by using built-in predicate subsumes_term/2,
%    which does not instantiate variables.
% *- The continuation style of the meta-interpreter is inherited from
%    the  term  matching meta-interpreter. This style does not suppot
%    correct loop detection nor proof tree building.


solve(Goal) :- solve(Goal,[]).
solve([],[]) :- !.                  % Note 1
solve([],[G|Goals]) :- !, solve(G, Goals).
solve([A|Bs], Goals) :- !,
           append(Bs, Goals, Goals1),
           solve(A, Goals1).
solve(A,Goals) :-
          unifying_and_matching_rule(A, Body),
          solve(Body, Goals).
solve(A,Goals) :-
          unifying_but_matching_rule(A, Body),
          solve(Body, Goals).

% choose clauses whose heads unifies with the goal, and specificly,
% matches the goal.
unifying_and_matching_rule(A, Body) :-
       copy_term(A,A_copy),         % Note 2
       rule(A_copy,_,Ref),          % Note 3
       rule(A1,_,Ref),              % Note 4
       subsumes_term(A1,A),         % Note 5
       rule(A,Body,Ref).            % Note 6

% choose clauses whose head unifies with the goal, and specificly,
% does not match the goal
unifying_but_matching_rule(A, Body) :-
      copy_term(A,A_copy),
      rule(A_copy,_,Ref),
      rule(A1,_,Ref),
      \+ subsumes_term(A1,A),
      rule(A,Body,Ref).

% Note 1: Clauses deal with mutually exclusive cases, hence the cuts
% Note 2: At run time variable A is bound to the current goal, A_copy
%         then is a variant of A
% Note 3: At run time, this procedure finds some clause whose head uni-
%         fies with a variant  of the  current goal and get the clause
%         reference number. Let's assume that the '_' is replaced by a
%         named  variable  ``Body'',   and  that  the  last  procedure
%         ``rule(A,Body,Ref)'' is removed. Then  this will cause error
%         in cases when the chosen clause  indeed matches the goal and
%         in  this  case if  some variables  in the body of the chosen
%         clause share value with variables from the variant of current
%         goal to which A_copy is bound, further instantiation for the
%         term bound  to Body  will not influence term bound to A, and
%         this is not the desired behaviour.  For this reason the body
%         of the  choosen clause is disgarded, as by '_' in the proce-
%         dure.  And ``rule(A,Body,Ref)'' is  added  as  the last step
%         to make sure the goal is reduced by correct sub-goals.
% Note 4: Get a copy of the chosen applicable rule.
% Note 5: Check whether the head also matches the goal, any binding made
%         for checking will be undone by implementation of subsumes_term/2.
% Note 6: If matches, use this rule to reduce the goal.

% sample object program

rule(direct(aberdeen, dundee),[],ref_1).
rule(direct(dundee,edinburgh),[],ref_2).
rule(direct(edinburgh,london),[],ref_3).

rule(travel(A,B), direct(A,B),            ref_4).
rule(travel(A,B), [direct(A,C),travel(C,B)],   ref_5).
