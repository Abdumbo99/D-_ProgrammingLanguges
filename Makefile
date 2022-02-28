parser: lex.yy.c y.tab.c
	gcc -o parser y.tab.c lex.yy.c
y.tab.c: D++.yacc
	yacc -d D++.yacc
lex.yy.c: D++.lex
	lex D++.lex

