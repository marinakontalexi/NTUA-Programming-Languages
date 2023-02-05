next(X, Y) :- Y is X + 1.
next(X, Y) :- Y is X - 1.
next(X, Y) :- Y is X + 2.
next(X, Y) :- Y is X - 2.

jump(Size, X/Y, Z/P) :-
  next(X, Z), next(Y, P),
  D1 is abs(Z - X),
  D2 is abs(P - Y),
  D1 + D2 =:= 3,
  Z =< Size,
  Z > 0,
  P =< Size,
  P > 0.

knightpath(_, [_One]).
knightpath(Size, [F, S|T]) :-
  jump(Size, F, S),
  knightpath(Size, [S|T]),
  not(member(F, T)).  %sos member check at the end
