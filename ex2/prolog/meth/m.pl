
rem([H|T], H, Prev, NewL) :-
  append(T, Prev, NewL).
rem([H|T], N, Prev, NewL) :-
  append([H], Prev, Prev),
  rem(T, N, Prev, NewL).

inl([A], [A]).
inl([H|T], A) :-
  inL([H|T], A).
inl([H|T], A) :- inl(T, A).

inL(L, [N|[]]) :-
  intoL(L, N).
inL(L, [N|T]) :-
  intoL(L, N),
  rem(L, N, [], NewL),
  inl(NewL, T).

intoL([H|_T], H).
intoL([_H|T], N) :- intoL(T, N).

inorder([]).
inorder([_]).
inorder([A,B|T]) :-
  A =< B,
  inorder([B|T]).

incsubseq(L, N, Ans) :-
  inl(L, Ans),
  length(Ans, N),
  inorder(Ans).
