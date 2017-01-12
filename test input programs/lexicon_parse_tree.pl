
lex(pro(he),he, pronoun, singular, subject).
lex(pro(him),him, pronoun, singular, object).

lex(pro(she),she, pronoun, singular, subject).
lex(pro(her),her, pronoun, singular, object).

lex(n(man),man, noun, singular,conInit).
lex(n(men),men, noun, plural,conInit).

lex(n(woman),woman,noun, singular,conInit).
lex(n(women),women, noun, plural,conInit).

lex(n(apple),apple, noun, singular,vowInit).
lex(n(apples),apples, noun, plural,vowInit).

lex(n(pear),pear, noun, singular,conInit).
lex(n(pears),pears, noun, plural,conInit).

% conInit, a noun with consonant initial latter
lex(det(a),a, det, singular, conInit).
% vowInit, a noun with vowel initial letter.
lex(det(an),an, det, singular, vowInit).
% SP stands for "singular or plural"
% CV stands for "consonant or vowel"
% lex(det(the),the, det, SP, CV).
lex(det(the),the, det, _, _).

lex(v(eat),eat, verb, plural).
lex(v(eats),eats, verb, singular).


% SO stands for Subject or  Object
% np(ListA,ListB, SP, SO)
np(np(DET,N),[Word1,Word2|A],A, SP, _) :- lex(DET,Word1,det, SP,CV),
                                          lex(N,Word2,noun, SP,CV).
np(np(PRO),[Word|A],A, SP , SO) :- lex(PRO,Word, pronoun, SP, SO).

vp(vp(V,NP),[Word|A],B,SP) :- lex(V,Word, verb, SP), np(NP,A,B,_,object).
vp(vp(V),[Word|A],A, SP) :- lex(V,Word, verb, SP).

s(s(NP,VP),A,C) :- np(NP,A,B,SP,subject), vp(VP,B,C,SP).
