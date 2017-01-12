# Structural Resolution in Prolog

This is an implementation of structural resolution written in Prolog in the form of a meta-interpreter. 
It helps to understand the inductive behaviour of structural resolution. A report about this implementation is [here](http://www.macs.hw.ac.uk/~yl55/CoALP_Report_Dec16.pdf).

## How to use

### System Requirement

To run this program you need to install [SWI-Prolog](http://www.swi-prolog.org/). 
The version of SWI-Prolog used to develop this program is Version 7.2.3 for Windows PC. 

### Input Data Requirement 

You need some Prolog programs at hand, as input to the *structural resolution meta-interpreter*. 
They should be normal Prolog programs that are commonly seen in Prolog text books or tutorials. Particularly, the input program should:

* Contain no cut (`!`),
* Contain no [meta-call predicate](http://www.swi-prolog.org/pldoc/man?section=metacall) such as `call` and negation operator `\+`, and
* Not be encapsulated in modules.  

The input file for term-matching vanilla and matching first vanilla 

### Understanding Files in This Repository

* [term_matching_vanilla.pl](term_matching_vanilla.pl) is meta-interpreter for term matching resolution, i.e. SLD resolution where the search rule only selects a clause if its head subsumes the select goal predicate.
* [matching_first_vanilla](matching_first_vanilla.pl) is meta-interpreter for SLD resolution with the search rule that clauses whose head subsumes the selected goal is chosen in precedence to those whose head unifies with but does not subsume the selected goal predicate.
* [vanilla_for_structural_resolution](vanilla_for_structural_resolution.pl) is meta-interpreter for structural resolution.

* [test input programs](test input programs/) provides many input Prolog programs that were used to test the structural resolution meta-interpreter.

### Running the code

The code for meta-interpreter is not encapsulated in a module. You can copy your input program files into the same directory as the source code of the meta-interpreter. In the folder [test input programs](test input programs/)    

(To be continued)
