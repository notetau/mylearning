
# minimal bison flex code with c++

## compile

```sh
bison --defines=parser.hpp --output=parser.cpp parser.yy
flex --outfile=lexer.cpp lexer.ll
g++ lexer.cpp parser.cpp main.cpp -o calc
```

## test on

- bison (GNU Bison) 2.5
- flex 2.5.35
- g++ (Debian 4.7.2-5) 4.7.2

