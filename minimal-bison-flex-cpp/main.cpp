#include <iostream>

#include "parser.h"
#include "mylexer.h"

int main()
{
	MyLexer lexer(&std::cin, &std::cout);
	yy::MyParser parser(&lexer);
	parser.parse();
	return 0;
}
