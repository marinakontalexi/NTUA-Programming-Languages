% 5
prime(2).                     %no time for actual prime/1
prime_start(L, P) :-
  cut_primes(L, [], [_H|Primes]),
  reverse(Primes, P1),
  p_start(P1, [], P).

p_start([], Prev, Prev).
p_start([H|T], P, Ans) :-
  p_start(T, [H|P], Ans).

p_start([H|T], [P|Tail], Ans) :-
  append(H, P, Prev),
  p_start(T, [Prev|Tail], Ans).

cut_primes([], Prev, [P]) :-
  reverse(Prev, P).
cut_primes([H|T], Prev, Ans) :-
  prime(H),
  reverse(Prev, P),
  cut_primes(T, [H], A),
  Ans = [P|A].
cut_primes([H|T], Prev, Ans) :-
  not(prime(H)),
  cut_primes(T, [H|Prev], Ans).

  % 5 again
  prime_start1(L, [[FP|T]]) :-
    findfirstprime(L, [FP|T]).

  prime_start1(L, X) :-
    findfirstprime(L, FP),
    prime_start_help(FP, [], X).

  prime_start_help(L, Prev, New) :-
    append(Start, [H|T], L),
    Start = [_|_],
    prime(H),
    append(Prev, [Start], N),
    append(N, [[H|T]], New).

  prime_start_help(L, Prev, New) :-
    append(Start, [H|T], L),
    Start = [_|_],
    prime(H),
    append(Prev, [Start], NewP),
    prime_start_help([H|T], NewP, New).
