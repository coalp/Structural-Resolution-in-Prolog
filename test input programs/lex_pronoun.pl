

lex(man, noun).
lex(woman,noun).
lex(loves, verb).
lex(a, determinant).
lex(the, determinant).
lex(he, pronoun,subject).
lex(him,pronoun,object).
lex(she,pronoun,subject).
lex(her,pronoun,object).


noun_phrase([Word1,Word2|A],A,_) :-
              lex(Word1, determinant),
              lex(Word2, noun).
noun_phrase([Word|A],A,Feature) :- lex(Word,pronoun,Feature).

verb_phrase([Word|A],A) :-
               lex(Word, verb).
verb_phrase([Word|A],B) :-
               lex(Word, verb),
               noun_phrase(A,B,object).

sentence(A,C) :- noun_phrase(A,B,subject), verb_phrase(B,C).
