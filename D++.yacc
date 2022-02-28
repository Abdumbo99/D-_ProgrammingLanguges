%{
#include <stdio.h>
#include <stdlib.h>


int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token MAIN
%token RETURN
%token COMM
%token COMMA
%token PERIOD
%token NUMBER
%token WORD
%token FLOAT
%token SPACE
%token TAB
%token DATA_TYPE
%token NULL_VAL
%token FIELD_MOD
%token CLASS
%token DEFINE
%token NEW
%token DELETE
%token CONSTANT
%token LEFT_PAREN
%token RIGHT_PAREN
%token SCOPE_STARTER
%token SCOPE_ENDER
%token LSB
%token RSB
%token ARTH_OP
%token BOOL_VAL
%token STRING
%token COMP_OP
%token WHILE
%token DO
%token FOR
%token IF
%token ELSE
%token IN
%token OUT
%token ASSIGN_OPERATOR
%token BOOL_OP
%token UNARY
%token STMT_END
%token IDENTIFIER
%token NL
%token PRIM_OBJ
%token PRIM_FUNC
%token SPRAY
%token SPRAY_MATERIAL
%token TURN
%token DIRECTION
%token MOVE
%token MOVE_DIRECTION
%token OTHERS


//start variable
%start program
//associaticvity rules
%left ARTH_OP BOOL_OP UNARY COMP_OP
%right ASSIGN_OPERATOR  


%%

program:
		main
		
main:
		MAIN block
		|MAIN SCOPE_STARTER stmts return_stmt SCOPE_ENDER 
		
stmts:
		stmt
		|stmts stmt
		
stmt: 
		expr STMT_END
		|var_dec
		|iter
		|cond_stmt
		|fun_dec
		|class_dec
		|comm
		|fun_call
		|obj_dec
		|obj_del
		|prim_stmt
		
block:
		SCOPE_STARTER stmts SCOPE_ENDER 	
expr:
		assign_exp
		|out_exp
		|in_exp
		
expr:
		SCOPE_STARTER stmts SCOPE_ENDER

var_dec:
		DATA_TYPE IDENTIFIER STMT_END
			
assign_exp:
		int_assign
		|flt_assign
		|str_assign
		|obj_assign
		|NULL_VAL_assign

		
int_assign:
		DATA_TYPE IDENTIFIER ASSIGN_OPERATOR NUMBER
		|IDENTIFIER ASSIGN_OPERATOR NUMBER
		|IDENTIFIER UNARY
		|UNARY IDENTIFIER
flt_assign:
		DATA_TYPE IDENTIFIER ASSIGN_OPERATOR FLOAT
		|IDENTIFIER ASSIGN_OPERATOR FLOAT
		
str_assign:
		DATA_TYPE IDENTIFIER ASSIGN_OPERATOR WORD
		|IDENTIFIER ASSIGN_OPERATOR WORD
		
obj_assign:
		IDENTIFIER IDENTIFIER ASSIGN_OPERATOR IDENTIFIER
		|IDENTIFIER ASSIGN_OPERATOR IDENTIFIER
		
NULL_VAL_assign:
		IDENTIFIER IDENTIFIER ASSIGN_OPERATOR NULL_VAL
		|IDENTIFIER ASSIGN_OPERATOR NULL_VAL

iter:
	while_loop
	|do_while_loop
	|for_loop
	
	
while_loop:
		WHILE LEFT_PAREN logic_exprs RIGHT_PAREN block		
		
do_while_loop:
		DO block WHILE LEFT_PAREN logic_exprs RIGHT_PAREN STMT_END
		
for_loop:
		FOR LEFT_PAREN for_expr RIGHT_PAREN block

for_expr:
		assign_exp STMT_END logic_exprs STMT_END int_assign

cond_stmt:
		if_stmt 
		|if_stmt else_stmt

if_stmt:
		IF LEFT_PAREN logic_exprs RIGHT_PAREN block
		
else_stmt:
		ELSE if_stmt 
		|else_stmt ELSE if_stmt  
		|ELSE SCOPE_STARTER stmts SCOPE_ENDER

logic_exprs:
		logic_expr
		|logic_exprs BOOL_OP logic_expr
		
logic_expr: 
		NUMBER COMP_OP NUMBER
		|IDENTIFIER COMP_OP NUMBER
		|NUMBER COMP_OP IDENTIFIER
		|IDENTIFIER COMP_OP IDENTIFIER
		|IDENTIFIER BOOL_OP IDENTIFIER

fun_dec:
		DEFINE DATA_TYPE IDENTIFIER LEFT_PAREN arg_types RIGHT_PAREN SCOPE_STARTER stmts return_stmt SCOPE_ENDER 
		
class_dec:
		CLASS IDENTIFIER block STMT_END
		|FIELD_MOD CLASS IDENTIFIER block STMT_END

comm:
		COMM comment_body COMM

		
comment_body:

		WORD
		|NUMBER 
		|IDENTIFIER 
		|OTHERS
		|comment_body WORD 		 
		|comment_body NUMBER 
		|comment_body IDENTIFIER  
		|comment_body OTHERS 

fun_call:
		nonstatic_fun_call
		|static_fun_call
		
nonstatic_fun_call:
		IDENTIFIER PERIOD IDENTIFIER LEFT_PAREN args RIGHT_PAREN STMT_END

static_fun_call:
		IDENTIFIER LEFT_PAREN args RIGHT_PAREN STMT_END	

obj_dec:
		IDENTIFIER IDENTIFIER LEFT_PAREN args RIGHT_PAREN STMT_END
		|IDENTIFIER IDENTIFIER ASSIGN_OPERATOR NEW IDENTIFIER LEFT_PAREN args RIGHT_PAREN STMT_END	

obj_del:
		DELETE IDENTIFIER STMT_END
			
arg:
		
		|NUMBER 
		|FLOAT
		|WORD
		|BOOL_VAL
		|NULL_VAL
		|IDENTIFIER

args:
		args COMMA arg
		|arg

arg_type:

		|DATA_TYPE
		|DATA_TYPE IDENTIFIER
		|IDENTIFIER IDENTIFIER 


arg_types:
		arg_types COMMA arg_type
		|arg_type
		
return_stmt:
		RETURN returnable STMT_END

returnable:
		NUMBER 
		|FLOAT
		|WORD
		|BOOL_VAL
		|NULL_VAL
		|IDENTIFIER	
	
out_exp:
		OUT LEFT_PAREN WORD RIGHT_PAREN
		|OUT LEFT_PAREN IDENTIFIER RIGHT_PAREN

in_exp:
		IN LEFT_PAREN IDENTIFIER RIGHT_PAREN

prim_stmt:
		prim_obj
		|prim_call

prim_obj:
		PRIM_OBJ IDENTIFIER LEFT_PAREN args RIGHT_PAREN STMT_END
		|PRIM_OBJ IDENTIFIER ASSIGN_OPERATOR NEW PRIM_OBJ LEFT_PAREN args RIGHT_PAREN STMT_END
		|PRIM_OBJ IDENTIFIER ASSIGN_OPERATOR NULL_VAL STMT_END
		
prim_call:
		PRIM_FUNC STMT_END
		|SPRAY LEFT_PAREN SPRAY_MATERIAL RIGHT_PAREN STMT_END
		|TURN LEFT_PAREN DIRECTION RIGHT_PAREN STMT_END 
		|MOVE LEFT_PAREN MOVE_DIRECTION RIGHT_PAREN STMT_END  

%%
int lineno=0;
void yyerror(char *s) {
	fprintf(stdout, "Line:  %d, has : %s\n", lineno,s);
}
int main(void){

int parseResult = yyparse();
if(parseResult ==0 ){
		printf("PROGRAM PARSING SUCCESSFUL!\n");
}
 return parseResult;
}



































