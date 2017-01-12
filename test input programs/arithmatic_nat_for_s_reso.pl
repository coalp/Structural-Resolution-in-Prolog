
/* To solve the problem that the S-resolution can't denumerate natural numbers
   using the following code and query ?-nat(X), where natural numbers are represented Arabic
   digits.
nat(0).
nat(X) :- nat(Y), X is Y + 1.
*/

/*
When natural numbers are represented by 0 and successo function, S-resolution
can answer query ?-nat(X). and denumerate numbers by back tracking.
nat(0).
nat(s(X)) :- nat(X).
*/

/*
For SLD resolution system, e.g. Prolog, in both the above case the numbers can be
denumerated using query ?-nat(X). Because S-resolution distinguish unifying-and-matching
from unifying-but-matching, while SLD doesn't.

For S-resolution, both clauses in successor representation are unifying-but-matching clauses,
so they will be chosen according to the order in which they are defined in the soource code.
while in arithmatic representation the second clause becomes unifying-and--matching so it is
always chosen prior to the first clause.

The key to solve the problem that S-resolution doesn't support enumerating arithmatic natural
numbers is, instead of giving up using such representation, to change the form of the code
so that both clauses turn back to unifying-but-matching clauses while the numbers is still
can be retrieved.

Observing the recursive clause of the successor representation, it is noticed that what makes this clause
unifying-but-matching is the successor functor that wraps the variable in the head of the clause. Therefore
a helper functor is introduced to the arithmatic definition to make both clauses unifying but-matching form
the query, and the base case is placed at first to be chosen first.
*/

% sn stands for S-resolution Number.
s_nat(sn(0)).
s_nat(sn(X)) :-
      var(X),   % If this procedure is removed, S-resolution will not terminate for finding ways to prove s_nat(sn(0)). See s_nat_dev_1/1, the developing version 1.
      s_nat(Y), % compare with the case when this procedure is replaced by s_nat(sn(Y)). See s_nat_dev_0/1, the developing version 0.
      sn(Value) = Y,
      X is Value + 1.

% query ?-s_nat(X).

%--------trial history ------------
% sn stands for S-resolution Number.
s_nat_dev_1(sn(0)).
s_nat_dev_1(sn(X)) :-
      s_nat_dev_1(Y),
      sn(Value) = Y,
      X is Value + 1.
% query ?-s_nat(X).
% Problem of s_nat_dev_1: after giving the first answer X = sn(0), the computer tried to find alternative ways to prove s_nat_dev_1(sn(0))
% first in back tracking. The second clause was chosen since the first one has been chosen and succeeded. The second clause needed to generate
% a new s_nat, sn(0) was generated and proved by the first clause. But soon Y = sn(0) was rejected by the body of second clause, and backtracking
% began with proving sn(0) with the second clause, which is the same thing the computer did when it is asked for the second answer. Hence the loop.
% The problem is caused by using the second clause to check sn(0) adn further generation of new s_nat. s_nat/1 solved this problem by testing that
% X is instantiated in the second clause, so that such check would not cause generating new s_nat. Also the second clause is supposed to be used
% to generate s_nat in a top down way, as the two nat/1 does, so it is important to make sure when the second clause is called, its argument is not
% instantiated.

% sn stands for S-resolution Number.
s_nat_dev_0(sn(0)).
s_nat_dev_0(sn(X)) :-
        s_nat_dev_0(sn(Y)),
        X is Y + 1.
% query ?-s_nat(X).
% Problem of s_nat_dev_0: It gives onne answer X = sn(0), then falls into non-erminating loop.
% After giving the first answer, baktracking starts to find alternative ways to prove  s_nat_dev_0(sn(0)).
% The second clause is chosen and a decendent goal is s_nat_dev_0(sn(Y)). This goal distinguishes the two clauses
% in S-resolution and always chooses the recursive in priory. s_nat_dev_1 solves this problem.
