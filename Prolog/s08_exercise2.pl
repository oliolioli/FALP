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
