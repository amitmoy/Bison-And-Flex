בכדי לקמפל את התוכנית ניתן לבצע זאת באמצעות makefile בכדי לקבל את קובץ ההרצה treecalc.
או לבצע את השורות הבאות אחת אחרי השניה.
win_bison -d parser.y
flex tree.lex
gcc -c parser.tab.c
gcc -c lex.yy.c
gcc-o treecalc parser.tab.o lex.yy.o
באמצעות כמובן קומפיילר gcc או אחר לשפת c.

התוכנית מקבלת קובץ קלט בשורת הcommandline המתאר עץ כמפורט בשאלה ומחזירה את ערכו. דוג' להרצה:
treecalc treetest.txt
