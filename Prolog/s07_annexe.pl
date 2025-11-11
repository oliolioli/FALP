% S07 - Exercice : Relations familiales - Annexe
%
% Exercise 1
% Recherchez dans la documentation les prédicats suivants, testez-les et expliquez-les en quelques lignes.

% 1. = is called 'Unification', is true when both elements can be made identical by binding them. Meaning: foo(X,a) = foo(b,Y) will be true by binding X=b and Y=a. See prediate '==' for comparison.

% 2. \= checks if unification is possible. Thus returns true if equal after binding, otherwise not.

% 3. == True if arguments are strictly equal, without any binding.

% 4. \== Not strictly true, compare above.

% 5. =\= Checks for numeric equality.

% 6. =:= Checks for numeric inequality.

% 7. is takes a variable or number on the left side and an arithmetic expression on the right side. For example: X is 3 + 4 will result in X = 7.


% Exercice 2
% ****************************************************
% male(PersonName)

male(hector).
male(paul).
male(david).
male(marc).
male(felix).
male(jean).
male(roger).
male(didier).
male(nicolas).
male(jacques).
male(luc).
male(martin).
male(patrick).
male(sebastien).

% ****************************************************
% female(PersonName)

female(anne).
female(julie).
female(elisa).
female(danielle).
female(sophie).
female(carole).
female(virginie).
female(martine).
female(claudia).
female(lise).
female(helene).
female(isa).
female(melissa).

% ****************************************************
% parent(ParentName, ChildName)

parent(hector,julie).
parent(anne,julie).
parent(hector,paul).
parent(anne,david).
parent(elisa,marc).
parent(elisa,danielle).
parent(felix,jean).
parent(jean,carole).
parent(julie,carole).
parent(marc,didier).
parent(didier,nicolas).
parent(carole,nicolas).
parent(roger,virginie).
parent(virginie,martine).
parent(didier,martine).
parent(paul,jacques).
parent(sophie,jacques).
parent(jacques,luc).
parent(virginie,luc).
parent(virginie,claudia).
parent(jacques,claudia).
parent(nicolas,lise).
parent(claudia,lise).
parent(david,helene).
parent(danielle,helene).
parent(martin,patrick).
parent(helene,patrick).
parent(claudia,sebastien).
parent(patrick,sebastien).
parent(martine,isa).
parent(sebastien,isa).
parent(claudia,melissa).
parent(patrick,melissa).

% Exemples

% Do X and Y have children (together)?
have_children(X,Y) :- parent(X,Z), parent(Y,Z), X \= Y.

% Is X a sister of Y?
sister(X,Y) :- female(X), parent(Z,X), parent(Z,Y), X \= Y.

% child(X,Y) : vrai si X est un enfant de Y
child(X,Y) :- parent(Y,X).

% father(X,Y) : vrai si X est le père de Y
father(X,Y) :- parent(X,Y), male(X).

% vrai si X est la mère de Y
mother(X,Y) :- parent(X,Y), female(X).

% vrai si X est un des grand-parents de Y
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% vrai si X est un grand-père de Y
grandfather(X,Y) :- father(X,Z), parent(Z,Y).

% vrai si X est une tante de Y
aunt(X,Y) :- child(Y,Z), sister(X,Z).

% vrai si X est un ascendant de Y. Un ascendant est soit un des
% deux parents, un des grands-parents, un des arrières-grands-parents, etc.
%
ancestor_1(X, Z) :- parent(X, Z).                   % base case
ancestor_1(X, Z) :- parent(X, Y), ancestor_1(Y, Z).

% Second variant with reversed sub-goals
ancestor_2(X, Z) :- parent(X, Z).                   % base case
ancestor_2(X, Z) :- ancestor_2(Y, Z), parent(X, Y).

% The second variant didn't terminated on my machine, which seems to be caused by the default depth-first search strategy of Prolog. The second variant calls the recursive call ancestor_2 first and thus can lead to a infinite recursion. The first variant in contrast calls parent(X,Y) first and thus calls ancestor_1 with already known parent Y.




% Exercise 3)
%
% Whereas hanoi(3,p1,p2,p3) doesn't print what it's given in the exercise ("dep de d vers g, etc."), but of course: "dep de p1 vers p3".
% But we will get the correct printout with params: hanoi(3,d,i,g).


hanoi(1, D, _, G) :-                          % base case
    format("dep de ~q vers ~q~n", [D, G]).

hanoi(N, D, I, G) :-
    N > 1,
    M is N - 1,                               % decrement
    hanoi(M, D, G, I),                        % G and I interchanged
    format("dep de ~q vers ~q~n", [D, G]),   
    hanoi(M, I, D, G).                        % I and D interchanged

% I solved exercise 1-2 by myself and watched a lot of videos about the towers of Hanoi, but honestly needed help from ChatGPT for this exercise. I could program the scaffold but then had problems with the order of the calls.
