% S08 - Exercice : Prédicats sur des listes - Tests

:- begin_tests(s08_tests).

% **********************************************
% my_length(+L,?N)

test(my_length1, true(Res == [ok])) :-
  findall(ok, my_length([], 0), Res).

test(my_length2, true(Res == [1])) :-
  findall(X, my_length([a], X), Res).

test(my_length3, true(Res == [2])) :-
  findall(X, my_length([a, b], X), Res).

test(my_length4, true(Res == [2])) :-
  findall(X, my_length([1, 2], X), Res).

% **********************************************
% my_append(?L1,?L2,?L3)

test(my_append1, true(Res == [ok])) :-
  findall(ok, my_append([a, b], [c, d], [a, b, c, d]), Res).

test(my_append2, true(Res == [[a, b, 1, 2]])) :-
  findall(X, my_append([a, b], [1, 2], X), Res).

test(my_append3, true(Res == [[3, 4]])) :-
  findall(X, my_append([1, 2], X, [1, 2, 3, 4]), Res).

test(my_append4, true(Res == [[a, b]])) :-
  findall(X, my_append(X, [c, d], [a, b, c, d]), Res).

test(my_append5, true(Res == [[]])) :-
  findall(X, my_append([], [], X), Res).

test(my_append6, true(Res == [[a]])) :-
  findall(X, my_append([], [a], X), Res).

test(my_append7, true(Res == [[1]])) :-
  findall(X, my_append([1], [], X), Res).

% **********************************************
% my_last(+L,?E)

test(my_last1, true(Res == [ok])) :-
  findall(ok, my_last([a], a), Res).

test(my_last2, true(Res == [ok])) :-
  findall(ok, my_last([a, c, b], b), Res).

test(my_last3, true(Res == [1])) :-
  findall(X, my_last([2, 3, 1], X), Res).

test(my_last4, true(Res == [1])) :-
  findall(X, my_last([1], X), Res).

test(my_last5, true(Res == [])) :-
  findall(X, my_last([], X), Res).

% **********************************************
% my_select(?E,+L1,?L2)

test(my_select1, true(Res == [ok])) :-
  findall(ok, my_select(a, [a, b, c], [b, c]), Res).

test(my_select2, true(Res == [[2, 3]])) :-
  findall(X, my_select(1, [1, 2, 3], X), Res).

test(my_select3, true(Res == [b])) :-
  findall(X, my_select(X, [a, b, c], [a, c]), Res).

test(my_select4, true(Res == [])) :-
  findall(X, my_select(1, [], X), Res).

test(my_select5, true(Res == [])) :-
  findall(X, my_select(a, [b, c], X), Res).

% **********************************************
% my_sum_list(+L,?S)

test(my_sum_list1, true(Res == [ok])) :-
  findall(ok, my_sum_list([1, 2, 3], 6), Res).

test(my_sum_list1, true(Res == [0])) :-
  findall(X, my_sum_list([], X), Res).

test(my_sum_list1, true(Res == [3])) :-
  findall(X, my_sum_list([3], X), Res).

test(my_sum_list1, true(Res == [6])) :-
  findall(X, my_sum_list([1, 2, 3], X), Res).

% **********************************************
% my_reverse(+L1,?L2)

test(my_reverse1, true(Res == [ok])) :-
  findall(ok, my_reverse([[1, 2], 3, [4, 5]], [[5, 4], 3, [2, 1]]), Res).

test(my_reverse2, true(Res == [[[e, d], c, [b, a]]])) :-
  findall(X, my_reverse([[a, b], c, [d, e]], X), Res).

test(my_reverse3, true(Res == [[]])) :-
  findall(X, my_reverse([], X), Res).

test(my_reverse4, true(Res == [[[7, 6], 5, [4, [3, 2], 1]]])) :-
  findall(X, my_reverse([[1, [2, 3], 4], 5, [6, 7]], X), Res).

test(my_reverse5, true(Res == [[[[[[b, a]]]]]])) :-
  findall(X, my_reverse([[[[[a, b]]]]], X), Res).

test(my_reverse6, true(Res == [[2, [], 1]])) :-
  findall(X, my_reverse([1, [], 2], X), Res).

test(my_reverse7, true(Res == [[2, foo(a, b), 1]])) :-
  findall(X, my_reverse([1, foo(a, b), 2], X), Res).

% **********************************************
% my_min_member(?M,+L)

test(my_min_member1, true(Res == [ok])) :-
  findall(ok, my_min_member(a, [a, b, c]), Res).

test(my_min_member2, true(Res == [1])) :-
  findall(X, my_min_member(X, [1, 2, 3]), Res).

test(my_min_member3, true(Res == [a])) :-
  findall(X, my_min_member(X, [b, a, c]), Res).

test(my_min_member4, true(Res == [1])) :-
  findall(X, my_min_member(X, [2, 3, 1]), Res).

test(my_min_member5, true(Res == [])) :-
  findall(X, my_min_member(X, []), Res).

% **********************************************
% atoms(+L)

test(atoms1, true(Res == [ok])) :-
  findall(ok, atoms([]), Res).

test(atoms2, true(Res == [ok])) :-
  findall(ok, atoms([a]), Res).

test(atoms3, true(Res == [ok])) :-
  findall(ok, atoms([a, b]), Res).

test(atoms4, true(Res == [])) :-
  findall(ok, atoms([1]), Res).

test(atoms5, true(Res == [])) :-
  findall(ok, atoms([1, a, b]), Res).

test(atoms6, true(Res == [])) :-
  findall(ok, atoms([a, b, 1]), Res).

% **********************************************
% insert(+E,?L1,?L2)

test(insert1, true(Res == [ok])) :-
  findall(ok, insert(a, [], [a]), Res).

test(insert2, true(Res == [[1]])) :-
  findall(X, insert(1, [], X), Res).

test(insert3, true(Res == [[1, 2, 3]])) :-
  findall(X, insert(1, [2, 3], X), Res).

test(insert4, true(Res == [[a, b, c]])) :-
  findall(X, insert(b, [a, c], X), Res).

test(insert5, true(Res == [[a, b, c]])) :-
  findall(X, insert(c, [a, b], X), Res).

test(insert6, true(Res == [[2, 3]])) :-
  findall(X, insert(1, X, [1, 2, 3]), Res).

test(insert7, true(Res == [[a, c]])) :-
  findall(X, insert(b, X, [a, b, c]), Res).

test(insert7, true(Res == [[1, 2]])) :-
  findall(X, insert(3, X, [1, 2, 3]), Res).

% **********************************************
% merge_lists(+L1,+L2,?L3)

test(merge_lists1, true(Res == [ok])) :-
  findall(ok, merge_lists([1, 3], [2, 4], [1, 2, 3, 4]), Res).

test(merge_lists2, true(Res == [[]])) :-
  findall(X, merge_lists([], [], X), Res).

test(merge_lists3, true(Res == [[a]])) :-
  findall(X, merge_lists([a], [], X), Res).

test(merge_lists4, true(Res == [[1]])) :-
  findall(X, merge_lists([], [1], X), Res).

test(merge_lists5, true(Res == [[a, b, c, d]])) :-
  findall(X, merge_lists([a, c], [b, d], X), Res).

test(merge_lists6, true(Res == [[1, 2, 3, 4]])) :-
  findall(X, merge_lists([2, 4], [1, 3], X), Res).

:- end_tests(s08_tests).
