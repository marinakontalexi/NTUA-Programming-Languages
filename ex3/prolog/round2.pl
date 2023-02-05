round(File, Steps, Town) :-
  my_read_file(File, Len, C, List),
  msort(List, Sorted),
  Len_1 is Len - 1,
  compute_towns(Sorted, Len_1, 0, 0, [], Towns), %!,
  [_H|T] = Towns,
  firstsum(T, Len, 1, 0, FSum),
  findsums(T, C, Len, FSum, [], RestSum),
  append([FSum], RestSum, Sum),
  append(Towns, Towns, Double),
  farthest(Double, 0, Len, [], Far),
  solve(Sum, Far, Len, 99999999999, Steps, 0, 0, Town), !.

compute_towns([], Len, Len, Current, Ans, NewAns) :- append(Ans, [Current], NewAns), !.
compute_towns([], Len, Prev, Current, Ans, Answer) :-
  append(Ans, [Current], NewAns),
  NewPrev is Prev + 1,
  compute_towns([], Len, NewPrev, 0, NewAns, Answer).

compute_towns([H|T], Len, Prev, CurrentSum, Ans, Arr) :-
  (H =:= Prev ->
    NewCurrentSum is CurrentSum + 1,
    compute_towns(T, Len, Prev, NewCurrentSum, Ans, Arr)
  ;H > Prev ->
    append(Ans, [CurrentSum], NewAns),
    NewPrev is Prev + 1,
    compute_towns([H|T], Len, NewPrev, 0, NewAns, Arr)).


firstsum([], _, _, Res, Res).
firstsum([H|T], Len, Position, Prev, Res) :-
  NewPrev is Prev + H * (Len - Position),
  NewPos is Position + 1,
  firstsum(T, Len, NewPos, NewPrev, Res).

findsums([], _, _, _, Sum, Sum).
findsums([H|T], C, Towns, Prev, PrevSum, Sum) :-
  N is Prev + C - Towns*H,
  append(PrevSum, [N], NewSum),
  findsums(T, C, Towns, N, NewSum, Sum).


farthest(_, Cities, Cities, Answer, Answer) :- !.
farthest([_H|T], CurrentPosition, Cities, CurrentAns, Answer) :-
  NewPosition is CurrentPosition + 1,
  farthest_help(T, CurrentPosition, NewPosition, Cities, CurrentAns, NewAns), !,
  farthest(T, NewPosition, Cities, NewAns, Answer).


farthest_help([0|T], City, Current, Cities, Ans, NewAns) :-
  Next is Current + 1,
  farthest_help(T, City, Next, Cities, Ans, NewAns).

farthest_help(_, City, Current, Cities, Ans, NewAns) :-
  Position is mod(2*Cities + City - Current, Cities),
  append(Ans, [Position], NewAns), !.

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
