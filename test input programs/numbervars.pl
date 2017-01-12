
% numvars(+Term, +N1,-N2).
% True if variables in Term could be replaced by term '$VAR'(N) with integer
% N ranging between N1 and N2-1 inclusively.


% numvars that works well for SLD resolution
numvars('VAR'(N), N, N1) :- N1 is N + 1.
numvars(Term, N, N) :- nonvar(Term), atomic(Term).
numvars(Term,N1,N2) :-
    nonvar(Term), compound(Term),
    functor(Term,_,N),
    numvars(0,N,Term,N1,N2).

numvars(N,N,_,N1,N1).
numvars(I,N,Term,N1,N3) :-
      I < N,
      I1 is I + 1,
      arg(I1,Term,Arg),
      numvars(Arg,N1,N2),
      numvars(I1,N,Term,N2,N3).


% modified (fortified) numvars to work well with S-resolution. Two changes from that for SLD resolution.
% change 1: subsumes test ensures only the correct answer is returned when query unifies with numvars('VAR'(N),N,N1), e.g. numvars('VAR'(1),1,N).
%           Note also that although meta-call predicate \+ <something> is used,luckily <something> is also built-in, not causing
%           interpreter leak.
% change 2: for already replaced variables, if they occur in the remaining part of the term that is not yet processed, such
%           situation is charaterised by (nonvar(N),M > N), and their nick names of the form 'VAR'(*) is treated as contants.
numvars2('VAR'(N), N, N1) :- N1 is N + 1.
numvars2('VAR'(N), M, M) :- nonvar(N), M > N. % change 2
numvars2(Term, N, N) :- nonvar(Term), atomic(Term).
numvars2(Term,N1,N2) :-
      nonvar(Term), compound(Term), \+ subsumes_term('VAR'(_),Term), % change 1
      functor(Term,_,N),
      numvars2(0,N,Term,N1,N2).

numvars2(N,N,_,N1,N1).
numvars2(I,N,Term,N1,N3) :-
            I < N,
            I1 is I + 1,
            arg(I1,Term,Arg),
            numvars2(Arg,N1,N2),
            numvars2(I1,N,Term,N2,N3).
