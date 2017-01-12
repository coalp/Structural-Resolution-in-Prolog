
% Translation of numeric words between German and English

 tran(eins, one).
 tran(zwei, two).
 tran(drei, three).
 tran(vier, four).
 tran(fuenf, five).
 tran(sechs, six).
 tran(sieben, seven).
 tran(acht, eight).
 tran(neun, nine).

 listTran([],[]).
 listTran([De|Des],[En|Ens]) :-
     tran(De, En),
     listTran(Des,Ens).
