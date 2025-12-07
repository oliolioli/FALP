%% Mini-Project : Analyse Syntaxique - Partie 2 %%

grammar --> rule.                                             % start symbol of grammar
grammar --> rule, grammar.                                    % followed by a rule or another grammar

rule --> rule_name, ['->'], rule_bodies.                      % defining a rule, consisting of a rule_name, arrow and rule_bodies

rule_name --> [Ident], { starts_with_r(Ident) }.              % rule_names consist of atoms starting with 'r_' (see starts_with_r/1)

rule_bodies --> rule_body.                                    % rule_bodies consisting of one single body ..
rule_bodies --> rule_body, ['|'], rule_bodies.                % .. or multiple rule_bodies

rule_body --> rule_body_part.                                 % rule_bodies consist of one single part ..
rule_body --> rule_body_part, rule_body.                      % .. or multiple parts

rule_body_part --> rule_name.                                 % rule_body_part is a rule_name or ..
rule_body_part --> [Atom], { valid_atom(Atom) }.              % an atom (see valid_atom/1)

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
