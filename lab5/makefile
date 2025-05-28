
.PHONY: clean

__start__: compiler
	./compiler

compiler: parser.tab.c lex.yy.c main.o
	g++ -std=c++2a parser.tab.c lex.yy.c main.o -o compiler

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l
	flex lexer.l

main.o: main.cpp
	g++ -std=c++2a -c main.cpp

clean:
	rm -f *.o *.c *.h *.output lex.yy.c parser.tab.c parser.tab.h compiler
