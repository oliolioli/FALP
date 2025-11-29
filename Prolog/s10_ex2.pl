% Exercice 2 : Expressions régulières

% a*bca*

e1(L) --> a_star(L1), middle(M), a_star(L2), { append([L1, M, L2], L) }.

a_star([]) --> [].                              % base case
a_star([a|T]) --> [a], a_star(T).               % recursive case

middle([b,c]) --> [b, c].                       % treating the middle part


% The tests unfortunately demand another format and naming.


% (a.|bc)*u+

e2(L) --> expr_left_start(Left_star), expr_right(Right), { append([Left_star, Right], L) }.

expr_left_start([]) --> [].                                       % zero or more 'a' or 'bc'

expr_left_start([X,T]) --> a_something(X), expr_left_start(T).    % treat the left block
expr_left_start([X,T]) --> bc(X), expr_left_start(T).

a_something(a) --> [a].
bc([b,c]) --> [b, c].

expr_right([u,T]) --> [u], expr_right(T).                         % treat the right block
expr_right([u]) --> [u].                                          % base case: last 'u'



% The tests unfortunately demand another format and naming here as well.
% Code was debugged and written with help of ChatGPT, but just as a bystander.
