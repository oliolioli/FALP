% S10 - Exercise 1

e(V) --> t(V).
e(V) --> t(V1), ['+'], e(V2), { V is V1 + V2 }.   % Addition

t(V) --> f(V).
t(V) --> f(V1), ['*'], t(V2), { V is V1 * V2 }.   % Multiplication

f(N) --> [N], { integer(N) }.
f(N) --> ['('], e(N), [')'].                      % Parenthesized expressions


