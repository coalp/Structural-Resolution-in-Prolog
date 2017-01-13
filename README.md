# Structural Resolution in Prolog

This repository hosts an implementation of structural resolution written in Prolog in the form of a meta-interpreter. A report about this implementation is [here](http://www.macs.hw.ac.uk/~yl55/CoALP_Report_Dec16.pdf), which presents comparative study of search strategies for term-matching and unification based resolution in Prolog. 

### Understanding Files in This Repository

* [term_matching_vanilla.pl](term_matching_vanilla.pl) is meta-interpreter for term matching resolution, i.e. SLD resolution where the search rule only selects a clause if its head subsumes the selected goal predicate. 
* [matching_first_vanilla.pl](matching_first_vanilla.pl) is meta-interpreter for SLD resolution with the search rule that clauses whose head subsumes the selected goal is chosen in precedence to those whose head unifies with but does not subsume the selected goal predicate.
* [vanilla_for_structural_resolution.pl](vanilla_for_structural_resolution.pl) is meta-interpreter for structural resolution.
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

When you use your own input programs, you should copy your own input program files into the same directory as the source code of the meta-interpreters. [Here](http://www.swi-prolog.org/pldoc/man?section=quickstart) is SWI-Prolog's guide to load source files. 

We see example run of meta-interpreters using input files provided in this repository.

#### Example Run 1: Vanilla for Structural Resolution

We use [numeral.pl](numeral.pl) in this example.

1. Load `numeral.pl` and `vanilla_for_structural_resolution.pl` to SWI-Prolog interactve interpreter. For instance, you may double click to open `vanilla_for_structural_resolution.pl` then type `?- [numeral].` to load the `numeral.pl` file.

2. The entry predicate for the meta-interpreter is `clause_tree/1`, which you invoke with a goal that is related to the object (input) program as its argument. For instance: the query `?-clause_tree(numeral(X)).` will generate peano numbers. 

#### Example Run 2: Vanilla for Structural Resolution

We use the structural resolution interpreter to generate sentences of the formal language a^n b^{2m} c^{2m} d^n. The file [a_nb_2mc_2md_n.pl](a_nb_2mc_2md_n.pl) is a working Prolog program that does this work. For example, simply double click to open `a_nb_2mc_2md_n.pl` on your PC, the SWI-Prolog interpreter would start. Then you give the query `?- s(A).`
and the answers would be:

    A = [] ;    
    A = [a, d] ;    
    A = [b, b, c, c] ;   
    A = [a, a, d, d] ;    
    A = [a, b, b, c, c, d];    
    ...

The program works by generating a natural number N, then enumerating through all pairs (A,B) such that A+B=N. For each pair (A,B) there is a list of characters `a...a b...b c...c d...d` that contains a and d for exactly A times and  b and c for B times.

You could try to solve the goal`?- s(A).` by structural resolution. To do this you put both [a_nb_2mc_2md_n.pl](a_nb_2mc_2md_n.pl) and   
[vanilla_for_structural_resolution.pl](vanilla_for_structural_resolution.pl) in the same directory on your PC, load them both to SWI-Prolog, and pose the query`?-clause_tree(s(X)).` 

#### Example Run 3: Term-Matching Vanilla

It is written in continuation style so it requires that 
(To be continued)
