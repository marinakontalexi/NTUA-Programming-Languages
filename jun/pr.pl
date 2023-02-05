count_unique([], 0).
count_unique([H|T], X) :-
  count_unique(T, X),
  member(H, T).
count_unique([H|T], Y) :-
  count_unique(T, X), !,
  Y is X+1.
