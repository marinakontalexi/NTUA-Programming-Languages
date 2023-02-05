final(Q, []) :-
  isSorted(Q).

isSorted([_A]).
isSorted([A, B|T]) :-
  A =< B,
  isSorted([B|T]).

next([[Q|T], []], 'Q', [NextQ, NextS]) :-
    NextQ = T,
    NextS = [Q].

next([[], [S|T]], 'S', [NextQ, NextS]) :-
    NextQ = [S],
    NextS = T.

next([[Q|TQ], [S|TS]], 'Q', [NextQ, NextS]) :-
  NextQ = TQ,
  NextS = [Q, S|TS].

next([[Q|TQ], [S|TS]], 'S', [NextQ, NextS]) :-
  Q =\= S,
  append([Q|TQ], [S], NextQ),
  NextS = TS.

solve([Q,[]], []) :-
  isSorted(Q).

solve(Curr, [Move|Moves]) :-
  next(Curr, Move, Next),
  solve(Next, Moves).

solve(I, Moves, []) :-
  length(Moves, L),
  mod(L, 2) =\= 1,
  solve(I, Moves), !.

qssort(File, Result):-
  my_read_file(File, _N, I),
  solve([I,[]], M, []),
  mkStr(M,Result), !.

mkStr([], "empty").
mkStr(M, Result) :-
  atom_chars(Result,M).

my_read_file(File, N, List):-
  open(File, read, Stream),
  read_line(Stream, [N]),
  read_line(Stream, List).

read_line(Stream, List) :-
  read_line_to_codes(Stream, Line),
  atom_codes(A, Line),
  atomic_list_concat(As, ' ', A),
  maplist(atom_number, As, List).
