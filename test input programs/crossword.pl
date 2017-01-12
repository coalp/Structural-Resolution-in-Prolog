
% LPN Exer 2.4

% word(SevenLetterWord, Letter1, Letter2, Letter3,Letter4,Letter5,Letter6,Letter7).
% The sequence Letter1, Letter2, Letter3,Letter4,Letter5,Letter6,Letter7 forms
% word SevenLetterWord.

word(astante, a,s,t,a,n,t,e).
word(astoria, a,s,t,o,r,i,a).
word(baratto, b,a,r,a,t,t,o).
word(cobalto, c,o,b,a,l,t,o).
word(pistola, p,i,s,t,o,l,a).
word(statale, s,t,a,t,a,l,e).

% crossword(VerticalWord1,VerticalWord2,VerticalWord3,HorizontalWord1,HorizontalWord2, HorizontalWord3).
% VerticalWord1,VerticalWord2,VerticalWord3,HorizontalWord1,HorizontalWord2, HorizontalWord3 is the answer of a crossword puzzle.

crossword(V1,V2,V3,H1,H2,H3) :-
   word(V1, _,   S1,_   ,S4,_   ,S7,_   ),
   word(V2, _   ,S2,_   ,S5,_   ,S8,_   ),
   word(V3, _   ,S3,_   ,S6,_   ,S9,_   ),
   word(H1, _   ,S1,_   ,S2,_   ,S3,_   ),
   word(H2, _   ,S4,_   ,S5,_   ,S6,_   ),
   word(H3, _   ,S7,_   ,S8,_   ,S9,_   ).

/*
crossword(V1,V2,V3,H1,H2,H3) :-
   word(V1, V1C1,S1,V1C2,S4,V1C3,S7,V1C4),
   word(V2, V2C1,S2,V2C2,S5,V2C3,S8,V2C4),
   word(V3, V3C1,S3,V3C2,S6,V3C3,S9,V3C4),
   word(H1, H1C1,S1,H1C2,S2,H1C3,S3,H1C4),
   word(H2, H2C1,S4,H2C2,S5,H2C3,S6,H2C4),
   word(H3, H3C1,S7,H3C2,S8,H3C3,S9,H3C4).
*/
