grammar Update;

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
   : 'update' table_clause 'set' column_clause ;

table_clause
   : folder_name '.' table_name ;

column_clause
   : column_name | column_name statement ;

column_name
   : column '=' value (',' column '=' value)*;

statement
    : 'where' (column RELOP value LOGICOP)* (column RELOP value);

table_name
   : ID;

folder_name
   : ID;

column
    : ID;

value
    : STRING | NUMBER ;

RELOP
    : '<' | '>' | '=' | '!=' | '<=' | '>=' ;

LOGICOP
    : 'and' | 'or';

ID : ('a'..'z'|'A'..'Z'|'_')
    ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* ;

STRING: ('"' ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|' ')+ '"');

NUMBER: ('0'..'9')+;

WHITESPACE: (' '|'\t'|'\r'|'\n')+ {skip();};
