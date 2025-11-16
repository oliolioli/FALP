% S08 - Exercise 2

% my_length(+L,?N)
my_length([], 0) :-
    % format("End of list reached, N = 0~n").
    true.

my_length([_|Tail], N) :-
    my_length(Tail, N0),
    N is N0 + 1.
