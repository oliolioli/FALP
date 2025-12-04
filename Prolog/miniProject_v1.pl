grammar --> rule.
grammar --> rule, grammar.

rule --> rule_name, ['->'], rule_bodies.

rule_name --> [Ident], { starts_with_r(Ident) }.

rule_bodies --> rule_body.
rule_bodies --> rule_body, ['|'], rule_bodies.

rule_body --> rule_body_part.
rule_body --> rule_body_part, rule_body.

rule_body_part --> rule_name.
rule_body_part --> [Atom], { valid_atom(Atom) }.

% rule names must start with "r_"
starts_with_r(Atom) :-
    atom(Atom),
    atom_chars(Atom, [r, '_' | _]).

% atoms cannot start with "r_" and cannot be '->' or '|'
valid_atom(Atom) :-
    atom(Atom),
    Atom \= '->',
    Atom \= '|',
    atom_chars(Atom, Chars),
    \+ (Chars = [r, _ | _]).



% Heavily influenced by ChatGPT. It's not even the problem to understand this code more or less, or to transfer the given meta-grammar into DCG form, but to understand the meaning of the french in the exercise.
