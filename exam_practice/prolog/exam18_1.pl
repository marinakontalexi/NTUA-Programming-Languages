%3b
isHeap(empty, _).
isHeap(n(D, L, R), P) :-
  D < P,
  isHeap(L, D),
  isHeap(R, D).

%5
recur(L, _, L, _, 0, _).
recur([H, S|T], [S|T], [H], Mid, Mid, 1).
recur([A, B, C|T], [C|T], [A, B], Mid, Mid, 0).

recur([H|T], Tail, Ans, Count, Middle, Parity) :-
  N is Count + 1,
  recur(T, Rest, Mid, N, Middle, Parity),
  Rest = [Next|Tail],
  append([H], [Mid|[Next]], Ans).

middle(L, Answer) :-
  length(L, Size),
  Parity is mod(Size, 2),
  Mid is div(Size,2) + Parity,
  recur(L, B, Answer, 1, Mid, Parity), !.


% good enough by nickie
mid([],[]).
mid([X],[X]).
mid([X,Y], [X,Y]).
mid([First|Rest], [First, Middle, Last]) :-
  append(Inside, [Last], Rest),
  Inside = [_|_],
  mid(Inside, Middle).
