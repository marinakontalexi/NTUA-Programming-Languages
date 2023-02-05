n(X,Y,Z).

count(1, PrevOnes, PrevZeros, NewPrev, PrevZeros) :-
  append([1], PrevOnes, NewPrev).

count(0, PrevOnes, PrevZeros, PrevOnes, NewPrev) :-
  append([0], PrevZeros, NewPrev).

count(n(X, Y, Z), PrevOnes, PrevZeros, Ones, Zeros) :-
  count(X, PrevOnes, PrevZeros, NewOnes, NewZeros),
  count(Y, NewOnes, NewZeros, NewOnes1, NewZeros1),
  count(Z, NewOnes1, NewZeros1, Ones, Zeros).

triadiko_01(Tree, Ones, Zeros) :-
  count(Tree, [], [], Ones, Zeros).

%-----------------------------------------------------
odd_parity(n(X, Y, Z), PrevCount, PrevOdd, Odds) :-
    odd_parity(X, 0, CountX, PrevOdd, NewOdd),
    odd_parity(Y, 0, CountY, NewOdd, NewOdd1),
    odd_parity(Z, 0, CountZ, NewOdd1, NewOdd2),
    Val is mod(PrevCount + CountX + CountY + CountZ, 2),
    Odds is NewOdd2 + Val.

odd_parity(A, PrevCount, PrevCount + A, PrevOdd, PrevOdd).
find_all_odd_parity(Tree, Count) :-
  odd_parity(Tree, 0, 0, Count).

%----------------------------------------------------
binary(0).
binary(1).

odd(X, Prev, Prev) :- binary(X).

odd(n(X,Y,Z), Prev, NewPrev) :-
  binary(X), binary(Y), binary(Z),
  NewPrev is Prev + mod(X+Y+Z, 2).

odd(n(X,Y,Z), Prev, Ans) :-
  odd(X, Prev, NewPrev),
  odd(Y, NewPrev, NewPrev1),
  odd(Z, NewPrev1, Ans).

count_odd_parity(Tree, Count) :-
  odd(Tree, 0, Count), !.
