%{
#define LIST            { strncat(buf,yytext,sizeof(buf)-strlen(buf)-1);}
#define token(t)        { LIST; if(Opt_Token) printf("<%s>\n",#t);}
#define tokenString(t,s){ LIST; if(Opt_Token) printf("<%s:%s>\n",t,s);}
#define MAX_LINE_LENGTH 257
#define MAX_ID_LENGTH 257
int Opt_Source = 1;
int Opt_Token = 1;
int Opt_Statistic = 1;
int linenum=1;
int cnt=0;
int f=0;
int i=0;
int count[100005]={0};
char buf[MAX_LINE_LENGTH];
char str[MAX_LINE_LENGTH];
struct str_cnt{
     char s[MAX_ID_LENGTH];
     int count;
}cont[100005];
%}

nzdigit [1-9]
digit [0-9]
letter [a-zA-Z_]
float [0-9]+\.[0-9]+
integer [0]|([1-9][0-9]*)
space [ \t]+
ID ({letter})({digit}|{letter})*

%x checkstr
%x comment
%x comment2
%x pragma
%x pragma2
%x pragma3
%x pragma4
%x pragma5

%%

"+" {    token("+"); return ADD;}
"-" {    token("-"); return SUB;}
"*" {    token("*"); return MUL;}
"/" {    token("/"); return DIV;}
"%" {    token("%"); return MOD;}
"=" {    token("="); return ET;}
"<" {    token("<"); return LT;}
"<=" {   token("<="); return LE;}
"!=" {   token("!="); return NE;}
">" {    token(">"); return GT;}
">=" {   token(">="); return GE;}
"==" {   token("=="); return EQ;}
"&&" {   token("&&"); return AND;}
"||" {   token("||"); return OR;}
"!" {	 token("!"); return NOT;}
";" {    tokenString("delim",";"); return SEMICOLON;}
"," {    tokenString("delim",","); return COMMA;}
"(" {    tokenString("delim","("); return L_PARAN;}
")" {    tokenString("delim",")"); return R_PARAN;}
"[" {    tokenString("delim","["); return L_BRACKED;}
"]" {    tokenString("delim","]"); return R_BRACKED;}
"{" {    tokenString("delim","{"); return L_CURLY;}
"}" {    tokenString("delim","}"); return R_CURLY;}
"while" {tokenString("KW","while"); return WHILE;}
"do" {   tokenString("KW","do");return DO;}
"if" {   tokenString("KW","if");return IF;}
"else" { tokenString("KW","else");return ELSE;}
"true" { tokenString("KW","true");return TRUE;}
"false" {tokenString("KW","false");return FALSE;}
"for" {  tokenString("KW","for");return FALSE;}
"int" {  tokenString("KW","int");return INT;}
"print" {tokenString("KW","print");return PRINT;}
"const" {tokenString("KW","const");return CONST;}
"read" { tokenString("KW","read");return READ;}
"boolean" {tokenString("KW","boolean");return BOOLEAN;}
"bool" { tokenString("KW","bool");return BOOL;}
"void" { tokenString("KW","void");return VOID;}
"float" {tokenString("KW","float");return FLOAT;}
"double" {tokenString("KW","double");return DOUBLE;}
"string" {tokenString("KW","string");return STRING;}
"continue" {tokenString("KW","continue");return CONTINUE;}
"break" {   tokenString("KW","break");return BREAK;}
"return" {  tokenString("KW","return");return RETURN;}

({float}) {tokenString("float",yytext);return FLOAT_CON;}
({integer}) {tokenString("integer",yytext);return INT_CON;}
({float}|{digit}{digit}*)[eE][-+]?[0]*{integer} {tokenString("scientific",yytext);return SCI_INT_CON;}

{space} {LIST; }

{ID} {
	tokenString("id",yytext);

	if(Opt_Statistic){
		f=0;
		for(i=1;i<=cnt;i++){
			if(!(strcmp(cont[i].s,yytext))){
				f=1;
				cont[i].count++;
				break;
			}
		}
		if(!f){
			strcpy(cont[++cnt].s,yytext);
			cont[cnt].count=1;
		}
	}
	return ID;
}

"\"" {
    LIST;
    BEGIN(checkstr);
}
<checkstr>"\"" {
    tokenString("string",str);
    return STRING;
    memset(str,0,sizeof(str));
    BEGIN(INITIAL);
}
<checkstr>[\\][\"] {
    LIST;
    strncat(str,"\"",sizeof(str)-strlen(str)-1);
}
<checkstr>[\\]{2} {
    LIST;
    strncat(str,"\\",sizeof(str)-strlen(str)-1);
}
<checkstr>\n {
    fprintf(stderr,"Error at line %d: %s\n",linenum,yytext);
    exit(1);    
}
<checkstr>. {
    LIST;
    strncat(str,yytext,sizeof(str)-strlen(str)-1);
}

"/*" {
    LIST;
    BEGIN(comment);
}
<comment>"*/" {
    LIST;
    BEGIN(INITIAL);
}
<comment>\n {
    LIST;
    if(Opt_Source)
        printf("%d:%s\n",linenum++,buf);
    buf[0]='\0';
}
<comment>. {
    LIST;
}
"//" {
    LIST;
    BEGIN(comment2);
}
<comment2>\n {
    LIST;
    if(Opt_Source)
        printf("%d:%s\n",linenum++,buf);
    buf[0]='\0';
    BEGIN(INITIAL);
}
<comment2>. {
    LIST;
}
^"#pragma"[\t ]+	{
		LIST;
		BEGIN(pragma);
}

<pragma>"source"[\t ]+ {
		LIST;
		BEGIN(pragma2);
}
<pragma>"token"[\t ]+ {
		LIST;
		BEGIN(pragma3);
}
<pragma>"statistic"[\t ]+ {
		LIST;
		BEGIN(pragma4);
}
<pragma>\n {
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}
<pragma>. {
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}

<pragma2>"on"[\t ]* {
	LIST;
	Opt_Source = 1;
	BEGIN(pragma5);
}
<pragma2>"off"[\t ]* {
	LIST;
	Opt_Source = 0;
	BEGIN(pragma5);
}
<pragma2>\n  { 
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}
<pragma2>. { // Unrecognized character
    fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
    exit(1);
}


<pragma3>"on"[\t ]* {
	LIST;
	Opt_Token = 1;
	BEGIN(pragma5);
}
<pragma3>"off"[\t ]* {
	LIST;
	Opt_Token = 0;
	BEGIN(pragma5);
}
<pragma3>\n  { 
	fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
	exit(1);
}
<pragma3>. { 
	fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
	exit(1);
}


<pragma4>"on"[\t ]* {
	LIST;
	Opt_Statistic = 1;
	BEGIN(pragma5);
}
<pragma4>"off"[\t ]* {
	LIST;
	Opt_Statistic = 0;
	BEGIN(pragma5);
}
<pragma4>\n  { 
	fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
	exit(1);
}
<pragma4>. { 
	fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
	exit(1);
}

<pragma5>"/*"  {
	LIST; 
	BEGIN(comment); 
}
<pragma5>"//" {
	LIST;
	BEGIN(comment2);
}
<pragma5>\n  { 
	LIST;
	if (Opt_Source)
	printf("%d:%s\n", linenum++, buf);
	buf[0] = '\0';
	BEGIN(INITIAL);
}
<pragma5>.  { 
	fprintf(stderr, "Error at line %d: %s\n", linenum, yytext);
	exit(1);
}
\n {
    LIST;
    if(Opt_Source)
        printf("%d:%s\n",linenum++,buf);
    buf[0]='\0';
}

. {
    fprintf(stderr,"Error at line %d: %s\n",linenum,yytext);
    exit(1);    
}
%%

/*int main(int argc,char **argv){
    if(argc>=2){
        yyin=fopen(argv[1],"r");
        if(NULL==yyin){
            fprintf(stderr,"Cannot open: %s",argv[1]);
            exit(-1);
        }
    }
    else{
        yyin=stdin;
    }
	yylex();
    if(Opt_Statistic){
	printf("frequencies of identifiers:\n");
	for(i=1;i<=cnt;i++){
		printf("%s %d\n",cont[i].s,cont[i].count);
	}
    }
    exit(0);
}*/