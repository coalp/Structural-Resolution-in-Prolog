# Structural Resolution in Prolog

This is an implementation of structural resolution written in Prolog in the form of a meta-interpreter. 
It helps to understand the inductive behaviour of structural resolution. 

## How to use

### System Requirement

To run this program you need to install [SWI-Prolog](http://www.swi-prolog.org/). 
The version of SWI-Prolog used to develop this program is Version 7.2.3 for Windows PC. 

### Input Data Requirement 

You need some Prolog programs at hand, as input to the structural resolution meta-interpreter. 
They should be normal Prolog programs that are commonly seen in Prolog text books or tutorials. Particularly, the input program should:

* Contain no cut (`!`),
* Contain no [meta-call predicate](http://www.swi-prolog.org/pldoc/man?section=metacall) such as `call` and negation operator `\+`, and
* Not be encapsulated in modules.  

### Running the code

The code for meta-interpreter is not encapsulated in a module. You can copy your input program files into the same directory as the source 
code of the meta-interpreter.     

(To be continued)
