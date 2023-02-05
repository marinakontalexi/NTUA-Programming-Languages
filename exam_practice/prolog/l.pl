walk([], _, _, _, _, C, C).
walk(_, [], _, _, _, C, C).
walk([H|T], [First|Rest], N, Sum, Curr, M, Max) :-
  (Sum + H > N ->
    NewSum is Sum - First,
    NewCurr is Curr - 1,
    walk([H|T], Rest, N, NewSum, NewCurr, M, Max)
  ; NewCurr is Curr + 1,
    New is max(NewCurr, M),
    walk(T, [First|Rest], N, Sum + H, NewCurr, New, Max)).

max_subseq(L, N, M) :-
  walk(L, L, N, 0, 0, 0, M).
