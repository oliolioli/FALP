% Exercice 2 : Expressions régulières

e(L) --> a_star(L1), middle(M), a_star(L2), { append([L1, M, L2], L) }.

a_star([]) --> [].                              % base case
a_star([a|T]) --> [a], a_star(T).               % recursive case

middle([b,c]) --> [b, c].                       % treating the middle part
