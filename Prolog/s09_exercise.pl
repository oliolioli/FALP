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

fibonacci_acc(N, Prev, Acc, FN) :-
  NewAcc is Prev + Acc,
  N1 is N-1,
  fibonacci_acc(N1, Acc, NewAcc, FN).

% Call this function as follows: fibonacci_acc(N, 0, 1, FN). Whereas N is an integer.


%count_occur(+X,+L,-N)
count_occur(X, [Head|Tail], N) :-
  count_occur(X, Tail, M),
  ((Head == X) -> N is M+1; M = N).

count_occur(_, [], 0).

% Call this function as follows: count_occur(X, [a,b,c], N). Whereas X is the list item to be counted and [a,b,c] a list.

%count_occur_acc(+X,+L,++Acc,-N)
count_occur_acc(X, [Head|Tail], Acc ,N) :-
  (Head == X -> NewAcc is Acc + 1; NewAcc is Acc),
  count_occur_acc(X, Tail, NewAcc, N).

count_occur_acc(_, [], Acc, Acc). 


%Exercise 2.1
% B1 -> 0 B1 | 1
b1([1|Tail]-Tail).
b1([0|Rest]-Tail) :-
    b1(Rest-Tail).

% S1 -> B1 B1
s1(Input-Tail) :-
    b1(Input-Temp),
    b1(Temp-Tail).


% Example: s1([0,0,1,0,1]-[]).


%Exercise 2.2
% S2 -> a b S2 | ε
s2(Tail-Tail).             % base case ε, Tail-Tail is another way to write []-[] which is in fact just the empty list.

s2([a,b|Rest]-Tail) :-
  s2(Rest-Tail).


% Example: s2([a,b,a,b]-[]). 


%Exercise 2.3
% S3 -> a b T3 c T3
s3([a,b|Rest0]-Final) :-
    t3(Rest0-Rest1),        % parse first T3
    Rest1 = [c|Rest2],      % match the 'c'
    t3(Rest2-Final).        % parse second T3

% S3 → T3
s3(Input-Rest) :-
    t3(Input-Rest).

% T3 -> U3 T3 d
t3(Input-Final) :-
    u3(Input-Mid1),       % parse U3
    t3(Mid1-[d|Final]).   % parse T3, then check for final 'd'

% T3 -> ε
t3(Rest-Rest).

% U3 -> k S3
u3([k|Rest]-Final) :-
    s3(Rest-Final).


% Examples: 
% s3([a,b,c]-[]).       % true
% s3([k,a,b,c,d]-[]).   % true
% s3([a,b,k,a,b,c,d,c,k,a,b,c,d]-[]).  % true

% s3([a,c,b]-[]).       % false
% s3([k,a,b,c]-[]).     % false
% s3([a,b,x,c]-[]).     % false
