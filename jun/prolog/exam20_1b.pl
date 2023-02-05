%5a
triadiko_01(Tree, Zs, Os) :-
  triadiko_help(Tree, [], Zs, [], Os).

triadiko_help(n(X, Y, F), Z, Zs, O, Os) :-
  triadiko_help(X, Z, Z1, O, O1),
  triadiko_help(Y, Z1, Z2, O1, O2),
  triadiko_help(F, Z2, Zs, O2, Os).

triadiko_help(1, Z, Z, O, Os) :-
  append(O, [1], Os).

triadiko_help(0, Z, Zs, O, O) :-
  append(Z, [0], Zs).

%5b
binary(0).
binary(1).

count_odd_parity(Tree, Count) :-
  count_help(Tree, 0, Count), !.

count_help(n(X, Y, Z), P, Count) :-
  binary(X), binary(Y), binary(Z),
  Count is P + mod(X + Y + Z, 2).

count_help(n(X, Y, Z), P, Count) :-
  count_help(X, P, P1),
  count_help(Y, P1, P2),
  count_help(Z, P2, Count).

count_help(X, C, C) :- binary(X).
