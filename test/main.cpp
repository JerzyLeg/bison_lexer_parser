#include <cstdio>
#include <cstdlib>

extern FILE* yyin;
FILE* outfile = nullptr;
int yyparse();

int main() {
    yyin = fopen("in.txt", "r");
    if (!yyin) {
        perror("Cannot open input file");
        return 1;
    }

    outfile = fopen("out.txt", "w");
    if (!outfile) {
        perror("Cannot open output file");
        fclose(yyin);
        return 1;
    }

    yyparse();

    fclose(yyin);
    fclose(outfile);

    return 0;
}