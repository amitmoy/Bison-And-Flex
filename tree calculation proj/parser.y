%code {
#include <stdio.h>

int yylex();
extern void yyerror (const char *s);
}


%union {
	int ival;
	
	struct { 
		int size;
		int level;
		int val;
	} tree_val;
	
	struct { 
		int odd;
		int even;
		int size;
		int level;
	} treelist_val;
}

%token <ival> NUMBER
%token SUM_EVEN SUM_ODD SIZE IGNORE

%nterm <treelist_val> treelist
%nterm <tree_val> tree
%nterm s

%%
s:	 tree { printf("the tree value is %d",$1.val); } ;

tree:	SUM_EVEN '(' treelist ')' { $$.val = $3.even; $$.size = $3.size + 1; } |
		SUM_ODD '(' treelist ')' { $$.val = $3.odd; $$.size = $3.size + 1; } |
		SIZE '(' treelist ')' { $$.size = $3.size + 1; $$.val = $3.size + 1;  } |
		IGNORE '(' treelist ')' { $$.val = 0; $$.size = $3.size + 1; } |
		NUMBER { $$.val = $1; $$.size = 1; } ;

treelist:	treelist tree { 
	if($2.val % 2 == 0){
		$$.even = $2.val + $1.even;
		$$.odd = $1.odd;
	} else {
		$$.even = $1.even;
		$$.odd = $1.odd + $2.val;
	}

	$$.size = $1.size + $2.size; } ;

treelist:  tree { 
	if($1.val % 2 == 0){
		$$.even = $1.val;
		$$.odd = 0;
	} else {
		$$.even = 0;
		$$.odd = $1.val;
	}

	$$.size = $1.size; } ;
%%

int main(int argc, char**argv)
{

    extern FILE *yyin;
    if (argc != 2) {
       fprintf (stderr, "Usage: %s <input-file-name>\n", argv[0]);
	   return 1;
    }
    yyin = fopen (argv [1], "r");
    if (yyin == NULL) {
        fprintf (stderr, "failed to open %s\n", argv[1]);
	    return 2;
    }
  
    yyparse ();

    fclose (yyin);
    return 0;
}

void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
