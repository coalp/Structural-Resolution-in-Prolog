# Structural Resolution in Prolog

This repository hosts an implementation of structural resolution written in Prolog in the form of a meta-interpreter. A report about this implementation is [here](http://www.macs.hw.ac.uk/~yl55/CoALP_Report_Dec16.pdf), which presents comparative study of search strategies for term-matching and unification based resolution in Prolog. 
### Understanding Files in This Repository

* [term_matching_vanilla.pl](term_matching_vanilla.pl) is meta-interpreter for term matching resolution, i.e. SLD resolution where the search rule only selects a clause if its head subsumes the selected goal predicate. 
* [matching_first_vanilla.pl](matching_first_vanilla.pl) is meta-interpreter for SLD resolution with the search rule that clauses whose head subsumes the selected goal is chosen in precedence to those whose head unifies with but does not subsume the selected goal predicate.
* [vanilla_for_structural_resolution.pl](vanilla_for_structural_resolution.pl) is meta-interpreter for structural resolution. It comes from modifying the matching-first vanilla, which in turn comes from modifying term-matching vanilla. 
* [numeral.pl](numeral.pl) and [a_nb_2mc_2md_n.pl](a_nb_2mc_2md_n.pl) are provided as two example object programs for the structural resolution meta-interpreter. More details on using these two examples come later in this document. 

## How to use

### System Requirement
To run this program you need to install [SWI-Prolog](http://www.swi-prolog.org/). 
The version of SWI-Prolog used to develop this program is Version 7.2.3. 

### Getting the Code

You could download the source code as a zip file to your own computer, decompress it and you are good to go. 
### Input Data Requirement 

In case you want to use your own SWI-Prolog programs, besides the two example programs that we provide here, as input to the *structural resolution meta-interpreter*, please note that your input programs should:

* Contain no cut (`!`),
* Contain no [meta-call predicate](http://www.swi-prolog.org/pldoc/man?section=metacall) such as `call` and negation operator `\+`, and
* Not be encapsulated in modules.  

The reason for the above requirement are explained in the [report](http://www.macs.hw.ac.uk/~yl55/CoALP_Report_Dec16.pdf), and is also understandable judging from the source code of the meta-interpreters. 

### Running the code

When you use your own input programs, you should copy them into the same directory as the source code of the meta-interpreters. [Here](http://www.swi-prolog.org/pldoc/man?section=quickstart) is SWI-Prolog's guide to load source files. 

We see example run of meta-interpreters using input files provided in this repository. Before you start, make sure you have met the system requirement mentioned earlier and have got a local copy of the repository on your own computer. 

#### Example 1: Vanilla for Structural Resolution

We use [numeral.pl](numeral.pl) in this example.

1. Load `numeral.pl` and `vanilla_for_structural_resolution.pl` to SWI-Prolog interactve interpreter. For instance, you open `vanilla_for_structural_resolution.pl` with SWI-Prolog then type `?- [numeral].` to load the `numeral.pl` file.  

2. The entry predicate for the meta-interpreter is `clause_tree/1`, which you invoke with a goal that is related to the object (input) program as its argument. For instance: the query `?-clause_tree(numeral(X)).` will generate peano numbers. 

#### Example 2: Vanilla for Structural Resolution

We consider [a_nb_2mc_2md_n.pl](a_nb_2mc_2md_n.pl), which is a Prolog program that generates sentences of the formal language a^n b^{2m} c^{2m} d^n.  Repeatedly, it generates a natural number N, then enumerates through all pairs (A,B) such that A+B=N. For each pair (A,B)    there is a list of characters `a...a b...b c...c d...d` that contains a and d for exactly A times and  b and c for B times.

For example, simply double click to   open `a_nb_2mc_2md_n.pl` on your computer, the SWI-Prolog interpreter would start. Then you give the query `?- s(A).`
and the answers would be:

    A = [] ;    
    A = [a, d] ;    
    A = [b, b, c, c] ;   
    A = [a, a, d, d] ;    
    A = [a, b, b, c, c, d];    
    ...
   
Now we solve the goal`?- s(A).` by structural resolution. To do this you put both [a_nb_2mc_2md_n.pl](a_nb_2mc_2md_n.pl) and   
[vanilla_for_structural_resolution.pl](vanilla_for_structural_resolution.pl) in the same directory on your computer, load them both to SWI-Prolog, for instance, by double clicking to open `vanilla_for_structural_resolution.pl` then typing `?- [a_nb_2mc_2md_n].` to load the `a_nb_2mc_2md_n.pl` file. You pose the query`?-clause_tree(s(A)).` 

#### Example 3: Term-Matching Vanilla

It is written in continuation style so it requires that input programs are written in special form. See [term_matching_vanilla.pl](term_matching_vanilla.pl) for example input (object) programs. 

Two example input programs for term-matching vanilla are provided in the same file as the meta-interpreter. To run the meta-interpreter over these two examples, simply double click `term_matching_vanilla.pl` on your computer, the SWI-Prolog interpreter will start, and you try the queries

        ?- solve(related(abraham,issac).
        ?- solve(related(abraham,X).
        ?- solve(member(1,[1,2,3])).
        ?- solve(member(a,[a,b,c])).
        

#### Example 4: Matching First Vanilla

It is written in continuation style so it requires that input programs are written in special form. See [matching_first_vanilla.pl](matching_first_vanilla.pl) for an example input (object) program. 

One example input program for matching-first vanilla is provided in the same file as the meta-interpreter. To run the meta-interpreter over that example, simply double click `matching_first_vanilla.pl` on your computer, the SWI-Prolog interpreter will start, and you try the queries
        
        ?- solve(travel(dundee. X)).
        ?- solve(travel(X,london)).

