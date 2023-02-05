% 5a (limeno apo sagwna 1o erg prolog 2021)
max_data(n(Data, List), Max) :-
  currentmax(List, Data, Max).

currentmax([], M, M).
currentmax([n(Data, List)|Nodes], Prev, Max) :-
  NewPrev is max(Data, Prev),
  currentmax(List, NewPrev, M),
  currentmax(Nodes, M, Max).

% 5b
find_depth(n(Data,_), Data, 1).
find_depth(n(_,List), Data, Depth) :-
    member(Elem, List),
    find_depth(Elem, Data, ElemDepth),
    Depth is ElemDepth + 1.

%5b by me

depth(n(_, List), Depth) :- %random
  depth_h(List, 1, Depth).

depth_h([], D, D).
depth_h([n(_, List)|Rest], Prev, D) :-
  NP is Prev + 1,
  depth_h(List, NP, D1),
  depth_h(Rest, Prev, D2),
  D is max(D1, D2).


finddepth(Tree, E, D) :-
  find([Tree], E, D).

find([n(Data, _)|_], Data, 1).
find([n(_, List)|_], Data, D) :-
  find(List, Data, N),
  D is N + 1.
find([n(_, _)|T], Data, D) :-
  find(T, Data, D).

tree(n(8, [n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
  n(5, [n(4, []), n(1, [])]),
  n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])])).

tree2([n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
  n(5, [n(4, []), n(1, [])]),
  n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])]).
