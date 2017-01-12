
% LNP exercise 6.6
% :-set_prolog_flag(generate_debug_info, false).


% trial 4

color(red).
color(blue).
color(green).

pet(snail).
pet(jaguar).
pet(zebra).

national(english).
national(spanish).
national(japanese).

% street where houses are distinct.
street([house(N1,C1,P1),house(N2,C2,P2),house(N3,C3,P3)]) :-
     national(N1), national(N2), N1 \= N2,
     national(N3), N1 \= N3, N2 \= N3,
     color(C1), color(C2),  C1 \= C2,
     color(C3), C1 \= C3, C2 \= C3,
     pet(P1),pet(P2),P1 \=P2,
     pet(P3),  P1 \= P3, P2 \= P3.

% M :: house/3, S :: [house/3]
street_member(M,S) :- street(S),member(M,S).

% A,B :: house/3, S :: [house/3].
street_neighbour(A,B,S) :- street(S), subList([A,B],S).

constrained_street(S) :- street_member(house(english, red, _), S),
                         street_member(house(spanish, _, jaguar),S),
                         street_neighbour(house(_,_,snail),house(japanese,_,_),S),
                         street_neighbour(house(_,_,snail),house(_,blue,_),S).

% B is to the right of A means be is immediately on the right side of A.

% X :: national
zebra(X) :- constrained_street(S), street_member(house(X,_,zebra), S).

append([],L,L).
append([H|L1],L2,[H|L3]) :- append(L1,L2,L3).

prefix(P,L) :- append(P , _ , L).
suffix(S,L) :- append(_ , S , L).

subList(S,L) :-
    prefix(A,L),
    suffix(S,A).


member(X,[X|_]).
member(X,[_|T]) :- member(X,T).


/*
Trial 1

% house(Owner_Nationality, House_Color, Pet).
% [house/3,house/3,house/3,house/3]
% neighbouring houses have different property;
% use cycled list to represent the street so by
% taking 2-member sublists, all houses could be compared.

subList()



red_house(english_family).

jaguar(spanish_family).

right_of(japanese_family,  X) :- snail(X).

right_of(B,A) :- snail(A), blue_house(B).



%Trial 2

% house(Owner_Nationality, House_Color, Pet).
% street is [house/3,house/3,house/3], and my predicates
% only need to handle three-element lists.

distinct([house(N1,C1,P1),house(N2,C2,P2),house(N3,C3,P3)]) :-
      house(N1,C1,P1),house(N2,C2,P2),house(N3,C3,P3),
      right_of(house(japanese, _,_), house(_,_,snail)),
      left_of(house(_,_,snail), house(_,blue,_)),
      N1 \= N2, N1 \= N3, N2 \= N3,
      C1 \= C2, C1 \= C3, C2 \= C3,
      P1 \=P2, P1 \= P3, P2 \= P3.

house(english,red,_).
house(_,blue,_).
house(_,green,_).
house(spanish, _,jaguar).
house(japanese,_,_).




right_of(B,A) :- distinct([A,B,_]).
right_of(B,A) :- distinct([A,_,B]).
right_of(B,A) :- distinct([_,A,B]).


left_of(A,B) :- distinct([A,B,_]).
left_of(A,B) :- distinct([A,_,B]).
left_of(A,B) :- distinct([_,A,B]).

zebra(X) :- house(X,_,zebra).
snail(X) :- house(X,_, snail).
jaguar(X) :- house(X,_,jaguar).

% trial 3
color(red).
color(blue).
color(green).

pet(snail).
pet(jaguar)
pet(zebra).

national(english).
national(spanish).
national(japanese).


house(english,red,P) :- pet(P).
house(spanish, C, jaguar) :- color(C).
house(japanese, C, P) :-
     color(C),pet(P), right_of(P, snail).
house(N, blue,P) :- national(P),  pet(P), left_of(snail, p).

left_of(A,B) :- A \= B.

right_of(A,B) :- left_of(B,A).

*/
