grammar Delete;

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
   : 'delete' from_statement ;

from_statement
   : 'from' table_clause
   | 'from' table_clause 'where' condition;

condition
    : column_name RELOP value (LOGICOP column_name RELOP value)*;

table_clause
   : folder_name '.' table_name ;

value
    : STRING | INTEGER;

column_name
   : ID;

table_name
   : ID;

folder_name
   : ID;

LOGICOP: 'and' | 'or' ;

ID : ('a'..'z'|'A'..'Z'|'_')
    ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* ;

STRING: ('"' ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|' ')+ '"');


INTEGER: '0'..'9'+;

NEWLINE:'\r'? '\n' ;

WHITESPACE: (' '|'\t'|'\r'|'\n')+ {skip();};

RELOP
    : '<' | '>' | '=' | '!=' | '<=' | '>=' ;

