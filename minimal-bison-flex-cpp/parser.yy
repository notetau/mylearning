%language "c++"
%skeleton "lalr1.cc"
%define "parser_class_name" "MyParser"
%locations
%defines "parser.h"
%output "parser.cpp"

%code requires {
class MyLexer;
#define YYSTYPE int
}

%code provides {
int yylex(yy::MyParser::semantic_type* val,
          yy::MyParser::location_type* loc,
          MyLexer* lexer);
}

%{
#include <iostream>

#define DUMP_PARSE(val,loc) std::cout << "[value=" << val << " {" << loc << "}]" <<std::endl;
%}

%lex-param   { MyLexer* scanner } /* add a argument on yylex() */
%parse-param { MyLexer* scanner } /* add a arguemnt on constructor */

%token T_NUMBER

%left '-' '+'
%left '*' '/'

%%

input : /* empty */
      | expr { DUMP_PARSE($$, yylloc); }
      ;

expr : expr '+' expr { $$ = $1 + $3; DUMP_PARSE($$, yylloc); }
     | expr '-' expr { $$ = $1 - $3; DUMP_PARSE($$, yylloc); }
     | expr '*' expr { $$ = $1 * $3; DUMP_PARSE($$, yylloc); }
     | expr '/' expr { $$ = $1 / $3; DUMP_PARSE($$, yylloc); }
     | '(' expr ')'  { $$ = $2;      DUMP_PARSE($$, yylloc); }
     | T_NUMBER
     ;

%%

// implement error() (member-function)
void yy::MyParser::error(const location_type& loc, const std::string& msg)
{
    std::cout << "*** error occur: (" << msg << ") ***" << std::endl
              << "at (line,col)" << loc << std::endl;

}
