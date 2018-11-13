
%{
#include <stdio.h>
#include <stdlib.h>
extern int linenum;             /* declared in lex.l */
extern FILE *yyin;              /* declared by lex */
extern char *yytext;            /* declared by lex */
extern char buf[256];           /* declared in lex.l */
%}

%token SEMICOLON    /* ; */
%token ID           /* identifier */
%token INT          /* keyword */
%token L_PARAN R_PARAN COMMA L_BRACKED R_BRACKED L_CURLY R_CURLY
%nonassoc ELSE
%token READ BOOLEAN WHILE DO IF TRUE FALSE FOR CONST 
%token PRINT BOOL VOID FLOAT DOUBLE STRING CONTINUE BREAK RETURN
%token INT_CON FLOAT_CON SCI_INT_CON 

%right ET
%left OR
%left AND
%right NOT
%left EQ NE GT GE LT LE
%left ADD SUB
%left MUL DIV MOD
%%

program : declaration_list funct_defi decl_and_def_list
        ;

decl_and_def_list : decl_and_def_list funct_decl
                  | decl_and_def_list var_decl
                  | decl_and_def_list const_decl
                  | decl_and_def_list funct_defi
                  |
                  ;
declaration_list : declaration_list const_decl
                 | declaration_list var_decl
                 | declaration_list funct_decl
                 |
                 ;
funct_defi : type ID L_PARAN argument_list R_PARAN compound
           | procedure_defi
           ;
procedure_defi : VOID ID L_PARAN argument_list R_PARAN compound
				;
statement : compound
          | simple
          | conditional
          | while
          | for
          | jump
          ;
compound : L_CURLY compound_content R_CURLY
         ;
simple : simple_content SEMICOLON
       ;
simple_content : variable_reference ET expression
               | PRINT expression
               | READ variable_reference
               | expression
               ;
expression : expression OR expression 
           | expression AND expression
           | NOT expression
           | expression LE expression
           | expression LT expression
           | expression GT expression
           | expression GE expression 
           | expression EQ expression
           | expression NE expression
           | expression ADD expression
           | expression SUB expression
           | expression MOD expression
           | expression MUL expression
           | expression DIV expression
           | L_PARAN expression R_PARAN %prec MUL
           | SUB expression %prec MUL
           | literal_constant
           | variable_reference
           | function_invocation
           ;

function_invocation : ID L_PARAN expression_list R_PARAN
                    ;
expression_list : nonEmptyExpressionList
                |
                ;
nonEmptyExpressionList : nonEmptyExpressionList COMMA expression
                       | expression
                       ;
variable_reference  : ID
                    | array_reference
                    ;
array_reference : ID array_reference_square
                ;

array_reference_square : array_reference square_expression
                       | square_expression
                       ;

square_expression : L_BRACKED expression R_BRACKED
                  ;

conditional : IF L_PARAN boolean_expression R_PARAN compound ELSE compound
            | IF L_PARAN boolean_expression R_PARAN compound
            ;
boolean_expression : expression
                   ;

while : WHILE L_PARAN boolean_expression R_PARAN compound
      | DO compound WHILE L_PARAN boolean_expression R_PARAN SEMICOLON
      ;

for : FOR L_PARAN initial_expression SEMICOLON control_expression SEMICOLON increment_expression R_PARAN compound
    ;
jump : RETURN expression SEMICOLON
     | BREAK SEMICOLON
     | CONTINUE SEMICOLON
     ;

initial_expression : ID ET expression
                   | expression
                   ;
control_expression : ID ET expression
                   | expression
                   ;

increment_expression : ID ET expression
                     | expression
                     ;

compound_content : compound_content const_decl
                 | compound_content var_decl
                 | compound_content statement
                 |
                 ;
const_decl : CONST type const_list SEMICOLON
           ;
const_list : const_list COMMA const
           | const
           ;
const : ID ET literal_constant
      ;
literal_constant : INT_CON
                 | FLOAT_CON
                 | SCI_INT_CON
                 | TRUE
                 | FALSE
                 ;

var_decl : type identifier_list SEMICOLON
         ;
type    : INT
        | FLOAT
        | STRING
        | BOOL
        | DOUBLE
        ; 
identifier_list : identifier_list COMMA identifier
                | identifier
                ;

identifier : identifier_no_initial
           | identifier_with_initial
           ;
identifier_no_initial : ID
                      | ID array
                      ;
identifier_with_initial : ID ET expression
                        | ID array ET initial_array
                        ;    
initial_array : L_CURLY expression_list R_CURLY
              ;
array : array L_BRACKED INT_CON R_BRACKED
      | L_BRACKED INT_CON R_BRACKED
      ;
funct_decl : type ID L_PARAN argument_list R_PARAN SEMICOLON
           | procedure_decl
           ;
procedure_decl : VOID ID L_PARAN argument_list R_PARAN SEMICOLON
               ;
argument_list : nonEmptyArgumentList
              |
              ;
nonEmptyArgumentList : nonEmptyArgumentList COMMA argument
                     | argument
                     ;
argument : type identifier_no_initial
         ;
%%
int yyerror( char *msg )
{
  fprintf( stderr, "\n|--------------------------------------------------------------------------\n" );
    fprintf( stderr, "| Error found in Line #%d: %s\n", linenum, buf );
    fprintf( stderr, "|\n" );
    fprintf( stderr, "| Unmatched token: %s\n", yytext );
  fprintf( stderr, "|--------------------------------------------------------------------------\n" );
  exit(-1);
}
int  main( int argc, char **argv )
{
    if( argc != 2 ) {
        fprintf(  stdout,  "Usage:  ./parser  [filename]\n"  );
        exit(0);
    }
    FILE *fp = fopen( argv[1], "r" );
    
    if( fp == NULL )  {
        fprintf( stdout, "Open  file  error\n" );
        exit(-1);
    }
    
    yyin = fp;
    yyparse();
    fprintf( stdout, "\n" );
    fprintf( stdout, "|--------------------------------|\n" );
    fprintf( stdout, "|  There is no syntactic error!  |\n" );
    fprintf( stdout, "|--------------------------------|\n" );
    exit(0);
}