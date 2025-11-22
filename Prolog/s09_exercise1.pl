%S09 - Exercise 1

%scalar_product(++L1,++L2,-P)
scalar_product([H1|T1], [H2|T2], P) :-
  TemporaryResult is H1*H2,
  scalar_product(T1, T2, Result),
  P is TemporaryResult + Result.

scalar_product([],[],0).

%scalar_product_acc(++L1,++L2,-P)
scalar_product_acc(L1,L2,P) :- 
  scalar_product_acc_rec(L1, L2, P, 0).

scalar_product_acc_rec([H1|T1], [H2|T2], P, Acc) :-
  TemporaryResult is H1*H2,
  NewAcc is Acc + TemporaryResult,
  scalar_product_acc_rec(T1, T2, P, NewAcc).

scalar_product_acc_rec([], [], Acc, Acc).


%fibonacci(++N,-FN), 
fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
  

fibonacci(N,FN) :-
  N1 is N-1,
  N2 is N-2,
  fibonacci(N1, FN1),
  fibonacci(N2, FN2),
  FN is FN1 + FN2.


%fibonacci_acc(++N,++Prev,++Acc,-FN)
fibonacci_acc(0, Result, _, Result) :- !.

fibonacci_acc(N,Prev,Acc,FN) :-
  NewAcc is Prev + Acc,
  N1 is N-1,
  fibonacci_acc(N1, Acc, NewAcc, FN).

% Call this function as follows: fibonacci_acc(N, 0, 1, FN). Whereas N is an integer.
