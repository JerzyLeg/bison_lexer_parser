#include <cstdio>
#include <cstdlib>
extern FILE* yyin;
int yyparse();

int main() {
    yyin = fopen("in.txt", "r");
    if (!yyin) {
        perror("Cannot open input file");
        return 1;
    }
    yyparse();
    fclose(yyin);
    return 0;
}