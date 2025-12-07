%% Mini-Project : Analyse Syntaxique - Partie 2 %%

% DCG rules for parsing grammars and generating DCG rule terms.
% Parses grammars in the form: rule_name -> body1 | body2 | ...
% Returns a list of DCG rules (RuleName --> Body) for each alternative.
grammar(AllRules) --> rule(Rules), grammar(RestRules), 
    { append(Rules, RestRules, AllRules) }.
grammar(Rules) --> rule(Rules).

% rule(-Rules, +Input, -Rest)
% Parses a single rule definition (name -> body1 | body2 ...).
rule(Rules) --> 
    rule_name(RuleName), 
    ['->'], 
    rule_bodies(Bodies),
    { findall((RuleName --> BodyTerm),
              (member(Body, Bodies), 
               list_to_term_without_functor(Body, BodyTerm)),
              Rules) }.

%% rule_name(-Ident, +Input, -Rest)
% Matches an atom starting with 'r_'. rule_name(-Ident, +Input, -Rest)
rule_name(Ident) --> [Ident], { starts_with_r(Ident) }.

% rule_name(-Ident, +Input, -Rest)
% Matches an atom starting with 'r_'.
rule_bodies([Body|RestBodies]) --> 
    rule_body(Body), 
    ['|'], 
    rule_bodies(RestBodies).
rule_bodies([Body]) --> rule_body(Body).

% rule_body(-Body, +Input, -Rest)
% Parses a sequence of terminals and rule names.
rule_body([Part|Parts]) --> rule_body_part(Part), rule_body(Parts).
rule_body([Part]) --> rule_body_part(Part).

% rule_body_part(-Part, +Input, -Rest)
% Matches either a rule name or a terminal atom.
rule_body_part(RuleName) --> rule_name(RuleName).
rule_body_part([Atom]) --> [Atom], { valid_atom(Atom) }.

% list_to_term_without_functor(+List, -Term)
% Converts a list [e1, e2, ..., en] into a term (e1, e2, ..., en).
list_to_term_without_functor([X], X).
list_to_term_without_functor([X, Y|R], P) :-
  list_to_term_without_functor([Y|R], F),
  P =.. [',', X, F].

% generate_rules(++Grammar)
% Parses Grammar and dynamically asserts the generated DCG clauses.
generate_rules(Grammar) :-
    grammar(Rules, Grammar, []),
    maplist(assert_dcg_rule, Rules).

% assert_dcg_rule(+DCGRule)
% Expands a DCG rule and asserts the resulting clauses.
assert_dcg_rule(DCGRule) :-
    expand_term(DCGRule, Clauses),
    maplist(assertz, Clauses).

% starts_with_r(+Atom)
% Checks if Atom starts with 'r_'.
starts_with_r(Atom) :-
    atom(Atom),
    atom_chars(Atom, [r, '_' | _]).

% valid_atom(+Atom)
% True if Atom is valid as a terminal (excludes '->', '|', or starting with 'r_').
valid_atom(Atom) :-
    atom(Atom),
    Atom \= '->',
    Atom \= '|',
    atom_chars(Atom, Chars),
    \+ (Chars = [r, '_' | _]).
