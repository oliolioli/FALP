% S08 - Exercise 2

% my_length(+L,?N)
my_length([], 0) :-
    true.

my_length([_|Tail], N) :-
    my_length(Tail, N0),
    N is N0 + 1.


my_append(L1, L2, L3) :-
    my_append_rec(L1, [], Acc1),   % traverse L1
    my_append_rec(L2, Acc1, Acc2), % traverse L2, continuing accumulator
    reverse(Acc2, L3).             % reverse to preserve original order

% Recursive helper: prepend each element to accumulator
my_append_rec([Head|Tail], AccIn, AccOut) :-
    NewAcc = [Head|AccIn],
    format("Adding element: ~q, Acc = ~q~n", [Head, NewAcc]),
    my_append_rec(Tail, NewAcc, AccOut).

% Base case: empty list, accumulator becomes output
my_append_rec([], Acc, Acc).      % AccIn = AccOut (= Unification)
