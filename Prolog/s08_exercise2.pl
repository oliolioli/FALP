% S08 - Exercise 2

% my_length(+L,?N)
my_length([], 0) :-
    true.

my_length([_|Tail], N) :-
    my_length(Tail, N0),
    N is N0 + 1.


% In this exercise ChatGPT was used to implement the unification for output.
my_append(L1, L2, L3) :-
    my_append_rec(L1, [], Acc1),   % traverse L1
    my_append_rec(L2, Acc1, Acc2), % traverse L2, continuing accumulator
    reverse(Acc2, L3).             % reverse to preserve original order

my_append_rec([Head|Tail], AccIn, AccOut) :-
    NewAcc = [Head|AccIn],
    %format("Adding element: ~q, Acc = ~q~n", [Head, NewAcc]),
    my_append_rec(Tail, NewAcc, AccOut).

% Base case: empty list, accumulator -> output
my_append_rec([], Acc, Acc).      % AccIn = AccOut (= Unification)


% my_last(+L,?E)

last_element([X], X).          % X is the last element if the list has exactly one element
last_element([_|Tail], X) :-   % otherwise, skip the head and check the tail
    last_element(Tail, X).


% my_select(?E,+L1,?L2)
my_select(E, L1, L2) :-
    my_select_rec(E, L1, [], L2).

% Base case: empty list
my_select_rec(_, [], Acc, Acc).

% Recursive case: Head = E, skip it
my_select_rec(E, [E|Tail], Acc, Result) :-
    my_select_rec(E, Tail, Acc, Result).

% Recursive case: Head \= E, include it
my_select_rec(E, [Head|Tail], Acc, Result) :-
    Head \= E,
    append(Acc, [Head], NewAcc),
    my_select_rec(E, Tail, NewAcc, Result).


% my_sum_list(+L,?S)
my_sum_list(L, S) :-
  my_sum_list_rec(L, 0, S).

my_sum_list_rec([Head|Tail], Acc, S) :-
  NewAcc is Acc + Head,
  my_sum_list_rec(Tail, NewAcc, S).

my_sum_list_rec([], Acc, Acc).  % Base case with binding

