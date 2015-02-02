#pragma once

#ifndef __FLEX_LEXER_H
#include <FlexLexer.h>
#endif

#include "parser.h"

class MyLexer : public yyFlexLexer {
public:
	MyLexer(FLEX_STD istream* arg_yyin = 0, FLEX_STD ostream* arg_yyout = 0)
		: yyFlexLexer(arg_yyin, arg_yyout)
	{}
	virtual ~MyLexer() {}

	virtual int yylex();

	void set_yylval(yy::MyParser::semantic_type* yylval) { this->yylval = yylval; }
	void set_yylloc(yy::MyParser::location_type* yylloc) { this->yylloc = yylloc; }

private:
	yy::MyParser::semantic_type* yylval;
	yy::MyParser::location_type* yylloc;
};
