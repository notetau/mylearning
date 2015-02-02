%option c++
%option batch
%option noyywrap
%option yyclass="MyLexer"
%option outfile="lexer.cpp"

%{
#include "parser.h"

#define Token yy::MyParser::token

#include "mylexer.h"

#define YY_USER_ACTION { printf("->"); yylloc->columns(yyleng); }
%}

DIGIT [0-9]
INTEGER {DIGIT}+

BLANK [ \t]
%%
%{
	yylloc->step();
%}
{BLANK}+ { yylloc->step(); }
[\n]+    { yylloc->lines(yyleng); yylloc->step(); }

{INTEGER} {
	// typeof(yylval) == yy::MyParser::semantic_type*
	*yylval = atoi(yytext);
	printf("%d", *yylval);
	return Token::T_NUMBER;
}

")" { printf(")"); return ')'; }
"(" { printf("("); return '('; }

"*" { printf("*"); return '*'; }
"/" { printf("/"); return '/'; }
"+" { printf("+"); return '+'; }
"-" { printf("-"); return '-'; }

%%

// glue function between bison & flex
int yylex(yy::MyParser::semantic_type* val,
          yy::MyParser::location_type* loc,
          MyLexer* lexer)
{
	lexer->set_yylval(val);
	lexer->set_yylloc(loc);
	return lexer->yylex();
}
