grammar Select;

options {
        output = AST;
        }

@parser::header {package mypackage.poly;
import javax.swing.JOptionPane;
}
@lexer::header {package mypackage.poly;
import javax.swing.JOptionPane;
}
 @lexer::members
 {
     @Override
    public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
  String hdr = getErrorHeader(e);
        String msg = getErrorMessage(e, tokenNames);
        throw new RuntimeException(hdr + ":" + msg);
    }
}
@parser::members
 {
     @Override
    public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
  String hdr = getErrorHeader(e);
        String msg = getErrorMessage(e, tokenNames);
        throw new RuntimeException(hdr + ":" + msg);
    }
}
@rulecatch {
catch (Exception e) {
JOptionPane.showMessageDialog(null,e.toString());
System.exit(0);
}
}

root
   : 'select' statement ;

statement
    : '*' from_statement
    | column_clause from_statement;

column_clause
   : column_name (',' column_name)*;

from_statement
   : 'from' table_clause
    |'from' table_clause 'where' condition ;

table_clause
   : folder_name '.' table_name ;

condition
    : (column_name RELOP expression LOGICOP)* (column_name RELOP expression);


expression
    :STRING | NUMBER;

column_name
   : ID;

table_name
   : ID;

folder_name
   : ID;

RELOP
    : '<' | '>' | '=' | '!=' | '<=' | '>=' ;

LOGICOP
    : 'and' | 'or';

ID : ('a'..'z'|'A'..'Z'|'_')
    ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* ;

STRING: ('"' ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|' ')+ '"');

NUMBER: ('0'..'9')+;

NEWLINE:'\r'? '\n' ;

WHITESPACE: (' '|'\t'|'\r'|'\n')+ {skip();};