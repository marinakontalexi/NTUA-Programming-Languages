issubset([],_).
issubset([X|L],[X|S]) :-
  issubset(L,S).
issubset(L, [_|S]) :-
  issubset(L,S).

inc([_]).
inc([A,B|T]) :-
  A =< B,
  inc([B|T]), !.

incsubseq(L, Size, R) :-
  length(R, Size),
  issubset(R, L),
  inc(R).
