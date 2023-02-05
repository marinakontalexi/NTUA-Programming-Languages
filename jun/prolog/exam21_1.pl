%2b
unique([]).
unique([Item | Rest]) :-
  member(Item, Rest),!, fail.
unique([_ | Rest]) :-
  unique(Rest).

%5a

find_max(n(X, Y, Z), P, Max) :-
  (X = n(_, _, _) -> find_max(X, P, M1)
; M1 is max(X, P)),
  (Y = n(_, _, _) -> find_max(Y, M1, M2)
; M2 is max(Y, M1)),
  (Z = n(_, _, _) -> find_max(Z, M2, Max)
; Max is max(Z, M2)).

maximize_h(n(X, Y, Z), n(MX, MY, MZ), Max) :-
  (X = n(_, _, _) -> maximize_h(X, MX, Max)
; MX = Max),
  (Y = n(_, _, _) -> maximize_h(Y, MY, Max)
; MY = Max),
  (Z = n(_, _, _) -> maximize_h(Z, MZ, Max)
; MZ = Max).

maximize(Tree, MaxTree) :-
  find_max(Tree, -1, Max),
  maximize_h(Tree, MaxTree, Max).


%5b

unoddsum(X, X) :- integer(X).
unoddsum(n(X, Y, Z), Node) :-
  unoddsum(X, NodeX),
  unoddsum(Y, NodeY),
  unoddsum(Z, NodeZ),
  (integer(NodeX), integer(NodeY), integer(NodeZ),
   1 is mod(NodeX + NodeY + NodeZ, 2) -> Node is 17
; Node = n(NodeX, NodeY, NodeZ)).
