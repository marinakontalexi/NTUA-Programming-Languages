halve([], [], []).
halve([A], [A], []).
halve([HL,HR|T], [Left|TL], [Right|TR]) :-
  Left = HL,
  Right = HR,
  halve(T,TL,TR).

merge([], [], []).
merge([], S, S).
merge(S, [], S).
merge([[A,IndA]|TA], [[B, IndB]|TB], [[N, IndN]|TN]) :-
  (A < B ->
    N is A,
    IndN is IndA,
    merge(TA, [[B, IndB]|TB], TN)
  ; N is B,
    IndN is IndB,
    merge([[A,IndA]|TA], TB, TN)).

mergeSort([],[]).
mergeSort([A], [A]).
mergeSort(List, NewList) :-
  halve(List, L, R),
  mergeSort(L, NewL),
  mergeSort(R, NewR),
  merge(NewL, NewR, NewList).

longest(File, Result):-
    my_read_file(File, _M, N, L),
    prefix(L,Lpref, N),
    mergeSort(Lpref, Lsort),
    reverseandmax(Lsort, L5),
    max_list(L5, Result), !.

my_read_file(File,M, N, List):-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, List).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).

% prefix
prefix(L, S, N) :- append([0],L,NewL), pref(NewL, S, N, 0, 0).
pref([], [], _, _, _).
pref([H|T], [[U,P]|V], N, SUM, Depth) :-
  U is - H - N + SUM,
  P is Depth,
  NewDepth is Depth + 1,
  pref(T, V, N, U, NewDepth).

index([],[]).
index([[_H1,I1]|T1], [H2|T2]) :-
  H2 is I1,
  index(T1, T2).

reverseandmax(L1, R):-
  index(L1,Lind),
  reverse(Lind, L2),
  findMaxind(L2, -1, -1, R).

findMaxind([], _, NewStart, NewStart).
findMaxind([A|T], Max, Start, Res) :-
    X is max(A, Max),
    B is X - A,
    NewStart is max(B, Start),
    findMaxind(T, X, NewStart, Res).
