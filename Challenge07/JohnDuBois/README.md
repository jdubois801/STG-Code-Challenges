To run the Scheme code, you will need a Scheme interpreter.  A nice one is available
online at http://repl.it/languages/Scheme/

The code can be run on your source data by invoking one of the validation functions like:

(validisbn10? "0345538986")

(validisbn13? "9780345538987")

The ISBN-10 and ISBN-13 generator functions can be invoked like:

(genisbn10)

(genisbn13)

* A note about the BIWA Scheme engine available at http://repl.it/languages/Scheme/. While a decent
pseudo-random number generator (from Donald Knuth) is included in the project source, the seed value
is fixed because the BIWA Scheme engine in that Javascript implementation doesn't make the system timer
or the environment immediately available. Generating a list of ISBN strings demonstrates that the 
pseudo-random generator works reasonably, but without a decent seed value it's kind of silly.  For example:

(list (genisbn10) (genisbn10) (genisbn10))

returns:  ("7585377169" "120253059X" "6589080526")

A different Scheme engine implementation with a decent library that provided access to the system environment
and system timer would be a better choice for the pseudo-random number generator seed.


