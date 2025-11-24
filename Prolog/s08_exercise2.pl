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


% my_reverse(+L1,?L2) - I used ChatGPT to solve this imho hard exercise.
my_reverse([], []).         % base case empty lists (ends recursion)

my_reverse([Head|Tail], R) :-
    my_reverse(Tail, ReversedTail),
    my_deep_rev(Head, ReversedHead),
    append(ReversedTail, [ReversedHead], R).

my_deep_rev(X, RX) :-
    is_list(X),           % just reverse X if it is a list
    my_reverse(X, RX),
    !.                    % The cut (!) prevents Prolog from falling through to the next clause.

my_deep_rev(X, X).


% my_min_member(?M,+L)
%
my_min_member(M, [X]) :-
    M = X.

my_min_member(M, [H|T]) :-
    my_min_member(MT, T),
    ( H @=< MT -> M = H ; M = MT ).       % @=< compares characters by their character codes.



atoms([]).
atoms([X|R]) :-
    atom(X),
    atoms(R).


% Cas où la liste est vide : insérer E donne [E]
insert(E, [], [E]).

% Cas où E doit être inséré avant la tête H
insert(E, [H|T], [E,H|T]) :-
    E =< H.

% Cas où E doit être inséré après la tête H
insert(E, [H|T], [H|R]) :-
    E > H,
    insert(E, T, R).



% Cas où la première liste est vide : le résultat est la deuxième liste
merge_lists([], L2, L2).

% Cas où la deuxième liste est vide : le résultat est la première liste
merge_lists(L1, [], L1).

% Cas où H1 <= H2 : on met H1 en tête et on fusionne le reste
merge_lists([H1|T1], [H2|T2], [H1|R]) :-
    H1 =< H2,
    merge_lists(T1, [H2|T2], R).

% Cas où H1 > H2 : on met H2 en tête et on fusionne le reste
merge_lists([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,
    merge_lists([H1|T1], T2, R).


% I completed the last five exercises with the help of ChatGPT. Due to the tight time constraints, I was unable to solve them on my own. While I regret that I could not work through these problems independently, this experience has highlighted areas where I need to improve my understanding and time management. I am committed to learning the material and practicing similar problems to ensure I can complete them unaided in the future.

Also these tests didn't run on my machine. I got different errors, as I tried different possible configurations:
ERROR: -g [s08_exercise2.pl]: source_sink `s08_exercise2.pl' does not exist

or

ERROR: -g s08_exercise2.pl: catch/3: Unknown procedure: ('.')/2
ERROR:   However, there are definitions for:                                                                     
ERROR:         ('.')/3   
 
