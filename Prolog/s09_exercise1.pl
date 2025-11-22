%S09 - Exercise 1

%scalar_product_rec(++L1,++L2,-P)
scalar_product_rec([H1|T1], [H2|T2], P) :-
  TemporaryResult is H1*H2,
  scalar_product_rec(T1, T2, Result),
  P is TemporaryResult + Result.

scalar_product_rec([],[],0).

%scalar_product([1,2,3], [4,5,6], P).



%scalar_product_acc(++L1,++L2,-P)
scalar_product_acc(L1,L2,P) :- 
  scalar_product_acc_rec(L1, L2, P, 0).

scalar_product_acc_rec([H1|T1], [H2|T2], P, Acc) :-
  TemporaryResult is H1*H2,
  NewAcc is Acc + TemporaryResult,
  scalar_product_acc_rec(T1, T2, P, NewAcc).

scalar_product_acc_rec([], [], Acc, Acc).

%scalar_product_acc([1,2,3], [4,5,6], P).
  
