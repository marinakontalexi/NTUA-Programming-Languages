/*
round(L, N, K, Min, Index):-
    msort(L, X),
    convert(N, 0, 0, 0, X, R),
    main(R, N, 0, K, 9999, 9999, Min, Index).
*/
%convert array
zeros([0], N, X):-
    X is N+1.

zeros([A|B], C, N):-
    A is 0,
    C_new is C + 1,
    zeros(B, C_new, N).

convert(N, C, I, P, [H], [A|B]):-
       (H == P -> A is I + 1,
        zeros(B, C, N);
        P_new is P + 1,
        convert(N, C, 0, P_new, [H], [A|B])).

convert(N, C, I, P, [H|T], [A|B]):-
    (H == P -> I_new is I + 1,
     C_new is C + 1,
     convert(N, C_new, I_new, P, T, [A|B]);
     A is I,
     P_new is P + 1,
     convert(N, C, 0, P_new, [H|T], B)).


%--------find the sum M of the initial list
%findSum([1,0,3,0,0],5,0,M).
findSum([_A|B], N, P, M):-
    P_new is P + 1,
    findSumHelp(B, N, P_new, M_prev),
    M is M_prev.

findSumHelp(A, N, P, M):-
    P is N - 1,

    M is A * (N - P).

findSumHelp([A|B], N, P, M):-
    P_new is P + 1,
    findSumHelp(B, N, P_new, M_prev),
    M is A * (N - P) + M_prev.


%--------newSum, K  is number of cars, N is number of cities
newSum(L, _K, N, 0, M):-
    findSum(L, N, 0, M).

newSum(L, K, N, P, M):-
    P_new is P - 1,
    newSum(L, K, N, P_new, M_prev),
    nth0(P, L, X),
    M is M_prev + K - N * X.

% --------find the max X of the list, and its place P given the place of
% first pointer T
findMaxHelp(L,[_A,B|C], 0, X, P, P_res):-
   (B == 0 -> P_new is P + 1, findMaxHelp(L,[B|C], 0, X, P_new, P_res);
    X is B,
    P_res is P).

findMaxHelp([A,B|C], [_|[]], 0, X, _P, P_res):-
     P_x is 0,
    (A == 0 -> P_new is P_x + 1,
     findMaxHelp([A,B|C],[A,B|C], 0, X, P_new, P_res);
    X is A,
    P_res is P_x).

findMaxHelp(L,[_A,B|C], T, X, P, P_res):-
    T_new is T - 1,
    P_new is P + 1,
    findMaxHelp(L,[B|C], T_new, X, P_new, P_res).

%save initial list in order to circle
findMax(L,T,X,P_res):-
    findMaxHelp(L,L,T,X,1,P_res).

% find max distance - T is first pointer, P is pointer of Max - T is
% given
findMaxDistance(L, _K, _N, T, R):-
    findMax(L, T, _X, P),
    (T < P -> R is T + P + 1;
    R is T - P).

updateMin(Sum, MaxD, T, Min_prev, Index_prev, Min, Index):-
    (Sum - MaxD + 1 >= MaxD, Sum < Min_prev  -> Min is Sum, Index is T;
    Min is Min_prev, Index is Index_prev).

%---M is N (number of cities), C is K (number of cars)
%main([1,0,3,0,0], 5, 0, 4,9999,999, Min, Index).

main(L, M, 0, C,_, _, Min_new, Index_new):-
    newSum(L, C, M, 0, Sum ),
    findMaxDistance(L, C, M, 0, MaxD),
    updateMin(Sum, MaxD, 0, 99999, _, Min, Index),
    main(L, M, 1, C, Min, Index, Min_new, Index_new).

main(L, M, T, C, Min_prev, Index_prev, Min, Index):-
    T is M - 1,
    newSum(L, C, M, T, Sum),
    findMaxDistance(L, C, M, T, MaxD),
    updateMin(Sum, MaxD, T, Min_prev, Index_prev, Min, Index).


main(L, M, T, C, Min_prev, Index_prev, Min_new, Index_new):-
    newSum(L, C, M, T, Sum),
    findMaxDistance(L, C, M, T, MaxD),
    updateMin(Sum, MaxD, T, Min_prev, Index_prev, Min, Index),
    T_new is T + 1,
    main(L, M, T_new, C, Min, Index, Min_new, Index_new).
