% each node holds the sum of its children
find_sum(Tree, S) :-
  sum(Tree, S, 0, _).

sum([], [], Sum, Sum).
sum([n(Data, [])|T], [n(Data, [])|B], Carryover, Sum) :-
  C is Data + Carryover,
  sum(T, B, C, Sum).

sum([n(_Data, [H|T])|P], [n(S1, L)|B], Carryover, Sum) :-
  sum([H|T], L, 0, S1),
  S is S1 + Carryover,
  sum(P, B, S, Sum).

tree([n(2, [n(4, [n(1, []), n(3, []), n(5, [n(3, [])])]),
            n(6, [n(8, [n(1, [n(2, []), n(1, [])])]), n(7, [n(1,[])])])])]).

tree2([n(2,[n(1,[]), n(3, []), n(5, [n(2, [])])])]).
tree3([n(2, [n(3,[]), n(4, [n(1,[])])])]).

% each node holds the size of the tree beneath it
sizes(empty, 0, empty).
sizes(n(_, L, R), S + 1, n(S, N1, N2)) :-
  sizes(L, S1, N1),
  sizes(R, S2, N2),
  S is S1 + S2.


sizes([], S, S, []).
sizes([n(_, K)|Bros], Carryover, S, [n(S1, L)|R]) :-
  sizes(K, 0, S1, L),
  C is Carryover + S1 + 1,
  sizes(Bros, C, S, R).

% fill the given tree with 42 until it becomes a complete binary tree
depth(empty, D, D).
depth(n(_, L, R), Prev, D) :-
  N is Prev + 1,
  depth(L, N, D1),
  depth(R, N, D2),
  D is max(D1, D2).

fill(empty, D, D, empty).
fill(empty, C, D, n(42, L, R)) :-
  N is C + 1,
  fill(empty, N, D, L),
  fill(empty, N, D, R).

fill(n(Data, L, R), C, D, n(Data, L1, R1)) :-
  N is C + 1,
  fill(L, N, D, L1),
  fill(R, N, D, R1).

ntree1(n(1,empty,empty)).
ntree2(n(1,n(2,empty,empty),empty)).
ntree3(n(1,n(2,n(3,empty,empty),n(4,empty,n(5,empty,empty))),empty)).
