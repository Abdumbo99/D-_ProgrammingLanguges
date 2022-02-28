%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
%}
/*Basics Terminals*/
MAIN				main
RETURN				return
SPACE				[ ]
TAB 				\t
DIGIT				[0-9]
NUMBER				{DIGIT}+
FLOAT				[+-]?[0-9]*(\.)?[0-9]+
LETTER				[A-Za-z]
INT					int
double_type			double
float_type			float
char_type			char
short_type			short
long_type			long
STRING				string
WORD				({string_encloser}{OTHERS}*{string_encloser})
NULL_VAL			null
data_types			({INT}|{double_type}|{float_type}|{char_type}|{short_type}|{long_type}|{STRING})
PUBLIC				public
PRIVATE				private
PROTECTED			protected
FIELD_MOD			({PUBLIC}|{PRIVATE}|{PROTECTED})
CLASS				class
DEFINE				define
NEW					new
DELETE				delete
STATIC				static
CONSTANT			constant
LParen				[(]
RParen				[)]
scope_starter		[{]
scope_ender			[}]
UNDERSCORE			[_]
LSBracket			[[]
RSBracket			[]]
arithmetic_op		[+|\-|*|/|%]
string_encloser		["]
char_encloser		[']
larger_than			[>]
smaller_than		[<]
equality_op			[=]
NOT					[!]	
PERIOD				[.]
COMMA 				[,]		
AND					(([&][&])|and|AND)
OR					([|][|]|or|OR)
bool_op				({OR}|{AND})
true_bool			(true|TRUE)
false_bool			(false|FALSE)
INCREMENT			[+][+]
DECREMENT			[-][-]
UNARY				({INCREMENT}|{DECREMENT}|{NOT})

semi_colon			[;]+
boolean_val			({true_bool}|{false_bool})	

/*END OF TERMINALS*/

/*COMMENT*/
comment_sign		[#]

/*ASSIGN*/
assign_op			({equality_op}|([<][-])|({arithmetic_op}{equality_op}))

/*boolean-dependent */
equal_comparator		({equality_op}{equality_op})
non_equal_comparator	({NOT}{equality_op})

comparison_operators		({larger_than}|{smaller_than}|{equal_comparator}|{larger_than}{equality_op}|{smaller_than}{equality_op}|{non_equal_comparator})

WHILE				while
DO					do
FOR					for
IF					if
ELSE				else

/*in and out*/
IN			(input|cin|in|IN)
OUT			(PRINT|COUT|cout|print|log|display|printf|out|OUT)

/*D++*/
DRONE				(drone|DRONE)
PRIM_OBJ			{DRONE}

GET_ORIENTATION		(read_heading|get_orientation)
GET_ALTITUDE		(read_height|get_altitude)
GET_TEMP			(read_temperature)
ASCEND				(ASCEND|ascend)
DESCEND				(DESCEND|descend)
SPRAY				(spray|SPRAY)
SPRAY_MATERIAL		(water|pesticide)
LAUNCH				(LAUNCH|launch|initiate|start|begin)
TURN				(turn|TURN)
STOP				(STOP|stop|brake|halt)
DELOAD				(deload|release)
CONNECT_WIFI		(connect|connect_wifi|CONNECT|CONNECT_WIFI)
DISCONNECT_WIFI		(disconnect|disconnect_wifi|DISCONNECT|DISCONNECT_WIFI)
CHANGE_DIRECTION	(CHANGE_DIRECTION|change_direction)
PRIM_FUNC			({GET_ORIENTATION}|{GET_ALTITUDE}|{GET_TEMP}|{ASCEND}|{DESCEND}|{LAUNCH}|{STOP}|{DELOAD}|{CONNECT_WIFI}|{DISCONNECT_WIFI}|{CHANGE_DIRECTION})


FORWARD				(FORWARD|forward|front|ahead)
BACKWARD			(BACKWARD|backward|back|behind)
LEFT				(LEFT|left)
RIGHT				(RIGHT|right)
DIRECTION			({RIGHT}|{LEFT})
MOVE				(move|MOVE)
MOVE_DIRECTION		({FORWARD}|{BACKWARD})
/*Stay here or else*/
NL					[\n]	
ALPHNUMERIC			({LETTER}|{DIGIT})
IDENTIFIER			(({LETTER}|{UNDERSCORE})({ALPHNUMERIC}|{UNDERSCORE})*)			
OTHERS				.	

%%

{MAIN}					return MAIN;
{RETURN}				return RETURN;
{comment_sign}			return COMM;
{COMMA}					return COMMA;
{PERIOD}				return PERIOD;
{NUMBER} 				return NUMBER;
{FLOAT}					return FLOAT;
{SPACE}					;
{TAB}					;
{data_types}			return DATA_TYPE;
{NULL_VAL}				return NULL_VAL;

{FIELD_MOD}				return FIELD_MOD;
{CLASS}					return CLASS;
{DEFINE}				return DEFINE;
{NEW}					return NEW;
{DELETE}				return DELETE;
{CONSTANT}				return CONSTANT;
{LParen}				return LEFT_PAREN;
{RParen}				return RIGHT_PAREN;
{scope_starter}			return SCOPE_STARTER;
{scope_ender}			return SCOPE_ENDER;
{LSBracket}				return LSB;
{RSBracket}				return RSB;
{arithmetic_op}			return ARTH_OP;
{boolean_val}			return BOOL_VAL;
{WORD}					return WORD;
{comparison_operators}	return COMP_OP;
{WHILE}					return WHILE;
{DO}					return DO;
{FOR}					return FOR;
{IF}					return IF;
{ELSE}					return ELSE;
{IN}					return IN;
{OUT}					return OUT;

{assign_op}				return ASSIGN_OPERATOR;

{bool_op}				return BOOL_OP;
{UNARY}					return UNARY;

{semi_colon}			return STMT_END;

{PRIM_OBJ}				return PRIM_OBJ;
{PRIM_FUNC}				return PRIM_FUNC;
{SPRAY}					return SPRAY;
{SPRAY_MATERIAL}		return SPRAY_MATERIAL;
{TURN}					return TURN;
{DIRECTION}				return DIRECTION;
{MOVE}					return MOVE;
{MOVE_DIRECTION}		return MOVE_DIRECTION;
{IDENTIFIER}			return IDENTIFIER;
{NL}					{extern int lineno; lineno++;};
{OTHERS}				return OTHERS;


%%

int yywrap(void){
	return 1;
}




