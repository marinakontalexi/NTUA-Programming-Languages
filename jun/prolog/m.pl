find_depth([n(Data, _Kids)|_T], Data, D, D).
find_depth([n(_Data, Kids)|_T], E, C, D) :-
  N is C + 1,
  find_depth(Kids, E, N, D).

find_depth([n(_Data, _Kids)|T], E, C, D) :-
  find_depth(T, E, C, D).

  tree2([n(4, [n(6, [n(1, [])]), n(3, [n(2, [])])]),
    n(5, [n(4, []), n(1, [])]),
    n(9, [n(5, [n(0, []), n(4, [])]), n(7, [n(2, [])])])]).
