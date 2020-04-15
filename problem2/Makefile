all: response

response.tab.c response.tab.h:	response.y
	bison -d  response.y

lex.yy.c: response.l response.tab.h
	flex response.l

response: lex.yy.c response.tab.c response.tab.h
	gcc -o problem2 response.tab.c lex.yy.c -lfl

clean:
	rm problem2 response.tab.c lex.yy.c response.tab.h
