/*************************************
Definite Clause Grammar Benchmark

To run the program : 

1) Using sicstus prolog run the following query:

?- consult('../CompilerWithEffects.pl').

2) in order to generate the non-optimized version of the program:

?- compile_effects('dcg_handler.pl',false,'dcg_handler_no_opt.pl').

Or, to generate the optimized version:

?- compile_effects('dcg_handler.pl',true,'dcg_handler_opt.pl').


3) The compiler generates the new file. Run the newly generated file with
   hProlog (recommended) or SWI-Prolog.

4) Add the following program clauses in order to generate the benchmarks :

*******

generate_ab(I,N,N):- I =< 0, !.
generate_ab(N,T,T2):- N1 is N-2, 
                      generate_ab(N1,[a,b|T],T2).



test(ListLength):-
	generate_ab(ListLength,[],List),
	statistics(runtime,[T1,_]),
	phrase_ab(List,[]),
	statistics(runtime,[T2,_]),
	Time is T2 - T1,
	write('Time is :- '), write(Time),nl.


*******

5) the Predicate test/1 is the benchmark testing predicate.
ListLength is the variable of the size of the input list. Run the benchmark
with the wanted list length. 
**************************************/




:- effect_list([c/1]).

ab.
ab:- c(a), c(b),ab.

phrase_ab(Lin,Lout):-
	handle
		ab
	with
		(c(I)-> Lin1 = [I|Lmid], continue(Lmid,Lout1))
	finally
		Lin1 = Lout1
	for 
		(Lin1 = Lin, Lout1 = Lout).