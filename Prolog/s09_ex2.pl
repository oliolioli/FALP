%Exercise 2.1
% B1 -> 0 B1 | 1
b1([1|Tail]-Tail).
b1([0|Rest]-Tail) :-
    b1(Rest-Tail).

% S1 -> B1 B1
s1(Input-Tail) :-
    b1(Input-Temp),
    b1(Temp-Tail).


% Example: s1([0,0,1,0,1]-[]).

%Exercise 2.2
% S2 -> a b S2 | ε
s2(T-T, [[]]-[]).     % ε

s2([a,b|R]-Tail, [[a,b|Out0]|OutRest]-OutTail) :-
    s2(R-Tail, [Out0|OutRest]-OutTail).         % base case ε, Tail-Tail is another way to write []-[] ; in fact the empty list.


%Exercise 2.3
% S3 -> a b T3 c T3
s3([a,b|Rest0]-Final) :-
    t3(Rest0-Rest1),        % parse first T3
    Rest1 = [c|Rest2],      % match the 'c'
    t3(Rest2-Final).        % parse second T3

% S3 → T3
s3(Input-Rest) :-
    t3(Input-Rest).

% T3 -> U3 T3 d
t3(Input-Final) :-
    u3(Input-Mid1),       % parse U3
    t3(Mid1-[d|Final]).   % parse T3, then check for final 'd'

% T3 -> ε
t3(Rest-Rest).

% U3 -> k S3
u3([k|Rest]-Final) :-
    s3(Rest-Final).


% Examples: 
% s3([a,b,c]-[]).       % true
% s3([k,a,b,c,d]-[]).   % true
% s3([a,b,k,a,b,c,d,c,k,a,b,c,d]-[]).  % true

% s3([a,c,b]-[]).       % false
% s3([k,a,b,c]-[]).     % false
% s3([a,b,x,c]-[]).     % false

