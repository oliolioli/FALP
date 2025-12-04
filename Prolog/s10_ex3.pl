% Exercice 3 : Prédicats

%my_last(+L,-E)
my_last(L, E) :- phrase(my_last_dcg(E), L).

my_last_dcg(E) -->
    [X],
    my_last_dcg_tail(X, E).

my_last_dcg_tail(_, E) -->
    [X],
    my_last_dcg_tail(X, E).
my_last_dcg_tail(E, E) -->
    [].



%convert_to_dec(++L,-V)
%vrai si V est la valeur décimale du nombre binaire représenté par la liste L.

convert_to_dec(L, V) :-
    reverse(L, RL),                     % ensure right-to-left reading (because DCG wants it that way)
    phrase(bits_value(V, 0, 1), RL).    % DCG with two extra arguments


% DCG base case
bits_value(V, V, _) --> [].

% DCG recursive case
bits_value(V, Acc, Pow) -->
    [Bit],
    { member(Bit, [0,1]) },             % ensure bit is 0 or 1
    { NewAcc is Acc + Bit * Pow },      % update accumulator
    { NewPow is Pow * 2 },              % next power of 2
    bits_value(V, NewAcc, NewPow).
