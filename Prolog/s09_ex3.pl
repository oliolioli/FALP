% Exercice 3 : Problème du zèbre
% Il faut répondre aux questions suivantes : Qui boit de l’eau ? Qui possède un zèbre ?

%houses_composition(?C,?A,?B,?F,?N)
houses_composition(C, A, B, F, N) :-
    % C: colors
    C = [C1, C2, C3, C4, C5],
    permutation([rouge, verte, bleue, jaune, blanche], C),

    % A: animals
    A = [A1, A2, A3, A4, A5],
    permutation([cheval, zebre, chien, renard, escargot], A),

    % B: drinks
    B = [B1, B2, B3, B4, B5],
    permutation([eau, vin, cafe, the, lait], B),

    % F: cigarettes
    F = [F1, F2, F3, F4, F5],
    permutation([chesterfield, old_gold, craven, gitane, kool], F),

    % N: nationalities
    N = [N1, N2, N3, N4, N5],
    permutation([espagnol, anglais, ukrainien, japonais, norvegien], N).


%same_index(?E1,?L1,?E2,?L2)        % do two elements in two different lists have the same index (= are in the same house)
same_index(E1, L1, E2, L2) :-
  nth1(Index, L1, E1),
  nth1(Index, L2, E2). 

%neighbour(?V1,?L1,?V2,?L2)         % do two neighbour are indeed neighbours?
neighbour(V1, L1, V2, L2) :-
   nth1(Index1, L1, V1),
   nth1(Index2, L2, V2),
   Diff is Index1 - Index2,
   abs(Diff) =:= 1.                % Neighboring means the difference between indices is 1.


% The following helper methods try to "find out" which properties do have the same index (meaning: are to be found in the same house).
drinks(Nationality, Beverage) :-
   houses_composition(_, _, BList, _, NList),
   same_index(Nationality, NList, Beverage, BList). 

has_animal(Nationality, Animal) :-
   houses_composition(_, AList, _, _, NList),
   same_index(Nationality, NList, Animal, AList).

smokes(Nationality, Cigarette) :-
   houses_composition(_, _, _, FList, NList),
   same_index(Nationality, NList, Cigarette, FList).

color(HouseNumber, Color) :-
   houses_composition(CList, _, _, _, _),
   nth1(HouseNumber, CList, Color).



% --------- Remarks to the solution ----------------------------------------------------------------------------
% After adding our knowledge:

% same_index(anglais, N, rouge, C).           % L’anglais habite une maison rouge.
% nth1(1, N, norvegien).                      % Le norvégien habite la première maison.
% neighbour(renard, A, chesterfield, F).      % The owner of a fox is a neighbour of someone smoking chesterfield.

% We can query our knowledge base and solve the riddle:

% drinks(Nationality, eau).
% Nationality = espagnol .

% has_animal(Nationality, zebre).
% Nationality = anglais .

% So we can answer the riddle such that the Spaniard who drinks water and the zebra belongs to the englishmen.

% How does this whole magic works?
% The program has 5 lists for houses: colors, animals, drinks, cigarettes, nationalities.
% permutation/2 generates all possible orderings of these lists.
% Applied constraints (see above) minimize the range of possible combinations.
% 
% Function same_index/4 and neighbour/4 help us to check which elements are in the same houses or next to each other.
% The helper predicates (drinks/2, has_animal/2, etc.) let us ask simple questions about the solution.
% So in my humble understanding of Prolog a (still quite huge) tree of facts is _declared_ and Prolog rules out which combinations are even possible.
