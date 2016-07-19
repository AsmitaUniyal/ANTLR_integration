grammar Insert;

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
    : 'insert' 'into' statement;

statement
    : table_clause 'values' ( '(' attribute ')')
    | table_clause ( '(' attribute2 ')') 'values' ('(' attribute ')');

table_clause
    : folder_name '.' table_name;

attribute
    : (STRING ',' | INTEGER ',')* (STRING | INTEGER);

attribute2
    : (column_name ',')* column_name;

column_name
    : ID;

folder_name
    : ID;

table_name
    : ID;

STRING: '"' ('a'..'z'|'A'..'Z'|'_'|' '|'0'..'9')+ '"';

INTEGER: '0'..'9'+;

ID : ('a'..'z'|'A'..'Z'|'_')
    ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* ;

NEWLINE:'\r'? '\n' ;

WHITESPACE: (' '|'\t'|'\r'|'\n')+ {skip();};

