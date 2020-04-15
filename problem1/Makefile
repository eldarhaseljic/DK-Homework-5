all: request

request.tab.c request.tab.h:	request.y
	bison -d  request.y

lex.yy.c: request.l request.tab.h
	flex request.l

request: lex.yy.c request.tab.c request.tab.h
	gcc -o problem1 request.tab.c lex.yy.c -lfl

clean:
	rm problem1 request.tab.c lex.yy.c request.tab.h
