longest(File, Result):-
  my_read_file(File, _M, N, L),
  prefix(L, Lpref, N),
  [HL|_TL] = Lpref,
  lmin(Lpref, Lmin, HL),
  reverse(Lpref, Rpref),
  [HR|_TR] = Rpref,
  rmax(Rpref, RMax, HR),
  reverse(RMax, Rmax),
  check(0, 0, Lmin, Rmax, -1, Result), !.

prefix(L, S, N) :- append([0],L,NewL), pref(NewL, S, N, 0).
pref([], [], _, _).
pref([H|T], [U|V], N, SUM) :-
  U is - H - N + SUM,
  pref(T, V, N, U).

lmin([],[],_).
lmin([H|T],[A|B], Min) :-
  A is min(H,Min),
  lmin(T, B, A).

rmax([],[],_).
rmax([H|T],[A|B], Max) :-
  A is max(H,Max),
  rmax(T, B, A).

check(_, _, [], _, MaxDiff, MaxDiff).
check(_, _, _, [], MaxDiff, MaxDiff).
check(I, J, [LM|TL], [RM|TR], MaxDiff, Res) :-
  (LM < RM ->
    D = J - I,
    NewMax is max(MaxDiff, D),
    NewI is I,
    NewJ is J + 1,
    NewL = [LM|TL],
    NewR = TR
  ; NewI is I + 1,
    NewJ is J,
    NewL = TL,
    NewR = [RM|TR],
    NewMax = MaxDiff),
  check(NewI, NewJ, NewL, NewR, NewMax, Res).

my_read_file(File,M, N, List):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, List).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).
