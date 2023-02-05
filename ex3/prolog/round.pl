count([], _, _, Sum, Sum).
count([H|T], Dest, Len, Sum, Ans) :-
  NewS is Sum + mod(Dest - H + Len, Len),
  count(T, Dest, Len, NewS, Ans).

further([], _, _, Ans, Ans).
further([H|T], Len, Dest, Prev, Ans) :-
  D is mod(Dest - H + Len, Len),
  (D > Prev -> NewPrev is D, further(T, Len, Dest, NewPrev, Ans)
  ;D = Prev -> further(T, Len, Dest, Prev, Ans)
  ;further(T, Len, Dest, Prev, Ans)).


calc(_, Len, Len, AnsS, AnsS, AnsF, AnsF).
calc(List, Dest, Len, PrevSum, AnsSum, PrevFar, AnsFar) :-
  count(List, Dest, Len, 0, C),
  further(List, Len, Dest, 0, D),
  append(PrevSum, [C], NewSum),
  append(PrevFar, [D], NewFar),
  NewD is Dest + 1,
  calc(List, NewD, Len, NewSum, AnsSum, NewFar, AnsFar).

solve([], _, _, Steps, Steps, _, Town, Town).
solve([S|ST], [F|FT], Len, Prev, Steps, Current, AnsPos, Town) :-
  Rest is S - F + 1,
  (F =< Rest ->
    (S < Prev -> NewPrev is S, NewPos is Current, NewCurr is Current + 1
    ;NewPrev is Prev, NewPos is AnsPos, NewCurr is Current + 1)
  ;NewF is F - Rest, NewS is S + (2 - div(NewF + 2, Len))*Len,
   (NewS < Prev -> NewPrev is NewS, NewPos is Current, NewCurr is Current + 1
   ;NewPrev is Prev, NewPos is AnsPos, NewCurr is Current + 1)
  ;NewPrev is Prev, NewPos is AnsPos, NewCurr is Current + 1),
  solve(ST, FT, Len, NewPrev, Steps, NewCurr, NewPos, Town).

my_read_file(File,M, N, List):-
  open(File, read, Stream),
  read_line(Stream, [M, N]),
  read_line(Stream, List).

read_line(Stream, List) :-
  read_line_to_codes(Stream, Line),
  atom_codes(A, Line),
  atomic_list_concat(As, ' ', A),
  maplist(atom_number, As, List).

round(File, Steps, Town, Sum, Far) :-
  my_read_file(File, Len, _N, List),
  calc(List, 0, Len, [], Sum, [], Far),
  solve(Sum, Far, Len, 10000, Steps, 0, 0, Town), !.

/*mkStr(Steps, Town).

mkStr(Steps, Town) :-
  atom_chars(Steps,Town).*/
