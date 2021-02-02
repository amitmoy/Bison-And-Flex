objects = parser.tab.o lex.yy.o  

treecalc: $(objects)
	gcc -o treecalc $(objects)

parser.tab.o : parser.tab.c parser.tab.h
	gcc -c parser.tab.c


lex.yy.o : lex.yy.c parser.tab.h
	gcc -c lex.yy.c

parser.tab.c: parser.y
	win_bison -d parser.y

parser.tab.h : parser.y
	win_bison -d parser.y
	
lex.yy.c : tree.lex
	win_flex tree.lex
	
clean :
	rm $(objects) treecalc
