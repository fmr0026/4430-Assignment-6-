:- use_module(library(lambda)).
 
peg :-
	peg(Moves),
	display(Moves).
 
% compute solution
peg(Moves) :-
	play([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Moves).
 
play(_, [_], Lst, Moves) :-
	reverse(Lst, Moves).
 
play(Free, Occupied, Lst, Moves) :-
	select(From, Occupied, Oc1),
	select(Over, Oc1, Oc2),
	select(To, Free, F1),
	move(From, Over, To),
	play([From, Over | F1], [To | Oc2], [move(From,Over,To) | Lst], Moves).
 
% allowed moves

move(From,2,To) :-
	member([From,To], [[1,4], [4,1]]).
move(From,3,To) :-
	member([From,To], [[1,6], [6,1]]).
move(From,4,To):-
	member([From,To], [[2,7], [7,2]]).
move(From,5,To):-
	member([From,To], [[2,9], [9,2]]).
move(From,5,To):-
	member([From,To], [[3,8], [8,3]]).
move(From,6,To):-
	member([From,To], [[3,10], [10,3]]).
move(From,5,To):-
	member([From,To], [[4,6], [6,4]]).
move(From,7,To):-
	member([From,To], [[4,11], [11,4]]).
move(From,8,To):-
	member([From,To], [[4,13], [13,4]]).
move(From,8,To):-
	member([From,To], [[5,12], [12,5]]).
move(From,9,To):-
	member([From,To], [[5,14], [14,5]]).
move(From,9,To):-
	member([From,To], [[6,13], [13,6]]).
move(From,10,To):-
	member([From,To], [[6,15], [15,6]]).
move(From,8,To):-
	member([From,To], [[9,7], [7,9]]).
move(From,9,To):-
	member([From,To], [[10,8], [8,10]]).
move(From,12,To):-
	member([From,To], [[11,13], [13,11]]).
move(From,13,To):-
	member([From,To], [[12,14], [14,12]]).
move(From,14,To):-
	member([From,To], [[15,13], [13,15]]).
 
 

% display solution

display(Sol) :-
	display(Sol, [1]).
 
display([], Free) :-
	numlist(1,15, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),  
	Lst, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	writeln(solved).
 
 
display([move(From, Over, To) | Tail], Free) :-
	numlist(1,15, Lst),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1),
		Lst,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	format('From ~w to ~w over ~w~n~n~n', [From, To, Over]),
	select(To, Free, F1),
	display(Tail,  [From, Over | F1]).
