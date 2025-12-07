%% Mini-Project : Analyse Syntaxique - Partie 2 %%

% Modified DCG rules with extra arguments to generate DCG rules
grammar(AllRules) --> rule(Rules), grammar(RestRules), 
    { append(Rules, RestRules, AllRules) }.
grammar(Rules) --> rule(Rules).

rule(Rules) --> 
    rule_name(RuleName), 
    ['->'], 
    rule_bodies(Bodies),
    { findall((RuleName --> BodyTerm),
              (member(Body, Bodies), 
               list_to_term_without_functor(Body, BodyTerm)),
              Rules) }.

rule_name(Ident) --> [Ident], { starts_with_r(Ident) }.

rule_bodies([Body|RestBodies]) --> 
    rule_body(Body), 
    ['|'], 
    rule_bodies(RestBodies).
rule_bodies([Body]) --> rule_body(Body).

rule_body([Part|Parts]) --> rule_body_part(Part), rule_body(Parts).
rule_body([Part]) --> rule_body_part(Part).

rule_body_part(RuleName) --> rule_name(RuleName).
rule_body_part([Atom]) --> [Atom], { valid_atom(Atom) }.

% Given helper predicate
list_to_term_without_functor([X], X).
list_to_term_without_functor([X, Y|R], P) :-
  list_to_term_without_functor([Y|R], F),
  P =.. [',', X, F].

% generate_rules(++Grammar): generates and asserts the clauses modeling the grammar
generate_rules(Grammar) :-
    grammar(Rules, Grammar, []),
    maplist(assert_dcg_rule, Rules).

% Helper predicate to expand and assert a single DCG rule
assert_dcg_rule(DCGRule) :-
    expand_term(DCGRule, Clauses),
    maplist(assertz, Clauses).

% Original helper predicates
starts_with_r(Atom) :-
    atom(Atom),
    atom_chars(Atom, [r, '_' | _]).

valid_atom(Atom) :-
    atom(Atom),
    Atom \= '->',
    Atom \= '|',
    atom_chars(Atom, Chars),
    \+ (Chars = [r, '_' | _]).
