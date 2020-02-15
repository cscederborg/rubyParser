# Ruby Programming Assignment: 3Point Grammar Lexical and Syntax Analysis

## Motivation
Ruby has been a popular language. It was created to be a real object-oriented language scripting language, the author did not like how Perl and Python handled objects so he decided to create a new language.
This project consists in the development of the front end of a compiler. By programming the Lexical Analyzer (Scanner) and Syntax Analyzer (Parser) for the 3Point grammar you will gain further understanding of the lexical analysis and the production of tokens needed for the Syntax Analyzer (Parser), and how to consume those tokens by the Parser to verify that the syntax is correct.


## Description
Write a program in Ruby that takes a program written in 3Point, and outputs:
1. If the program has lexical or syntax errors, the error that was found. Use panic version of error handling.
1. If the program is OK, depending on a command line flag the program will produce:
   1.	If the flag is -s the program will output a function call in Scheme that is going to be called by a program in Scheme that will calculate properties of those three points.
   1. If the flag is -p the program will output a series of queries about those three points.

The program should run like this:
```
prompt>ruby parser.rb input.txt -s
; Processing Input File input.txt
; Lexical and Syntax analysis passed
(calculate-triangle (make-point 2 3) (make-point 1 4) (make-point 3 4))
prompt>
```

## Grammar

```
START     --> POINT_DEF; POINT_DEF; POINT_DEF.
POINT_DEF --> ID = point(NUM, NUM)
ID        --> LETTER+
NUM       --> DIGIT+ {.DIGIT+}
LETTER    --> a | b | c | d | e | f | g | ... | z
DIGIT     --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | ... | 9

```

The tokens of this grammar are:
```
POINT
ID
NUM
SEMICOLON
COMMA
PERIOD
LPAREN
RPAREN
EQUAL
```

Given the following program written in this language:
```
a = point(2, 3);
b = point(1, 1);
c = point(1, 3);
```
The tokens that it would generate are:
1. `ID  a`
1. `EQUAL`
1. `POINT`
1. `LPAREN`
1. `NUM 2`
1. `COMMA`
1. `NUM 3`
1. `RPAREN`
1. `SEMICOLON`
1. `ID  b`
1. `EQUAL`
1. `POINT`
1. `LPAREN`
1. `NUM 1`
1. `COMMA`
1. `NUM 1`
1. `RPAREN`
1. `SEMICOLON`
1. `ID  c`
1. `EQUAL`
1. `POINT`
1. `LPAREN`
1. `NUM 1`
1. `COMMA`
1. `NUM 3`
1. `RPAREN`
1. `PERIOD`

Notice that the ID and NUM tokens have their lexeme associated. Also notice that in the language the elements do not need to be separated by space.

## How to run the program

### Scheme Output
To generate scheme output you will add the `-s` flag at the end of the command:
```
prompt> ruby parser.rb input.txt -s
; processing input file input.txt
; Lexical and Syntax analysis passed
(calculate-triangle (make-point 2 3) (make-point 1 1) (make-point 1 3))
```

### Prolog Output
To generate scheme output you will add the `-p` flag at the end of the command:
```
prompt> ruby parser.rb input.txt -p
/* processing input file input.txt
   Lexical and Syntax analysis passed */
query(line(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(triangle(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(vertical(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(horizontal(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(equilateral(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(isosceles(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(right(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(scalene(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(acute(point2d(2,3), point2d(1,1), point2d(1, 3)))
query(obtuse(point2d(2,3), point2d(1,1), point2d(1, 3)))
writeln(T) :- write(T), nl.
main:- forall(query(Q), Q-> (writeln(‘yes’)) ; (writeln(‘no’))),
      halt.

```

Later we will redirect the output to Scheme and Prolog programs respectively.

## Assignment Requirements
- Good programming practices
  - Indentation
  - Meaningful identifier naming
  - Consistent variable naming convention
- This activity is strictly individual

## Delivery
You will use this repository and commit and push to it. Remember to push your last version before the deadline.
What files should be in your repository:
- `parser.rb` Source code in Ruby for your lexical and syntax analysis
- `test1.cpl`, `test2.cpl`, `test3.cpl`, `test4.cpl`, the test files provided for you to test. Notice that `test3.cpl` has a lexical error and `test4.cpl` has a syntax error.

## Assessment and Grading
Assessment will consider the following factors in the grading of this assignment:
-	Good programming practices
-	Your program will be tested with the four test programs that were provided and some others that will be made to test, some with lexical errors, some with syntax errors, some without any errors.
-	Adherence to instructions
-	Correct function of the program
-	No runtime errors
-	Late deliveries will have a zero mark
-	Plagiarism will have a double zero mark (in addition to losing 10% of your final grade, the person that plagiarizes will lose an additional 10% of their final grade), besides there will be a report filed in the students’ academic record.

## Extra Challenge

Create an additional file with a decorated (Tokens with Lexemes on the Leafs) parse tree. The file should be named like the input file but with the extension `.pt` (stands for parse tree), for instance if the input file is `test1.cpl` the parse tree should be in file `test1.pt`.
