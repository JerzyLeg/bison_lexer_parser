#include <iostream>
using namespace std;

extern int yyparse();
extern void yyrestart(FILE*);

int main() {
    cout << "Declare variables (Ctrl+D to stop):" << endl;
    yyparse();
    return 0;
}