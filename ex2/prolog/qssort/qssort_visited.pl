final(Q, []) :-
  isSorted(Q).

isSorted([_A]).
isSorted([A, B|T]) :-
  A =< B,
  isSorted([B|T]).

next([Q|T], [], A, NextQ, NextS, NextA) :-
    NextQ = T,
    NextS = [Q],
    append(A, ['Q'], NextA).

next([], [S|T], A, NextQ, NextS, NextA) :-
    NextQ = [S],
    NextS = T,
    append(A, ['S'], NextA).

next([Q|TQ], [S|TS], A, NextQ, NextS, NextA) :-
  NextQ = TQ,
  NextS = [Q, S|TS],
  append(A, ['Q'], NextA).

next([Q|QS], [S|TS], A, NextQ, NextS, NextA) :-
  Q =\= S,
  append([Q|QS], [S], NextQ),
  NextS = TS,
  append(A, ['S'], NextA).

solved([], "empty").
solved(A, U) :-
  atom_chars(U,A), !.

solve([[Q,S,A]|T], Prev, R) :-
  (not(member([Q,S,_], Prev)) ->
    append(Prev,[Q,S,A],NewPrev)
  ; solve(T,Prev,R)),
  (final(Q,S) ->
    solved(A,R)
  ; findall([NQ,NS,NA], next(Q, S, A, NQ, NS, NA), L),
    save(L, T, NewStates),
    solve(NewStates, NewPrev, R)).

save([[Q,S,A]], T, NewStates) :-
  (member([Q,S,_], T) ->
    append(T, [], NewStates)
  ; append(T, [[Q,S,A]], NewStates)).

save([[Q1,S1,A1], [Q2,S2,A2]], T, NewStates) :-
  (member([Q1,S1,_], T) ->
    append(T, [], NewStates1);
    append(T, [[Q1,S1,A1]], NewStates1)),
  (not(member([Q2,S2,_], T)) ->
    append(NewStates1, [[Q2,S2,A2]], NewStates);
    NewStates = NewStates1).

save1([M], T, NewStates) :-
  append(T, [M], NewStates).
save1([M1, M2], T, NewStates) :-
  append(T, [M1,M2], NewStates).

qssort(File, Result):-
  my_read_file(File, _N, L),
  solve([[L, [], []]], [], Result), !.

my_read_file(File, N, List):-
  open(File, read, Stream),
  read_line(Stream, [N]),
  read_line(Stream, List).

read_line(Stream, List) :-
  read_line_to_codes(Stream, Line),
  atom_codes(A, Line),
  atomic_list_concat(As, ' ', A),
  maplist(atom_number, As, List).
