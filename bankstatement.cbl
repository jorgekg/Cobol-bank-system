      ******************************************************************
      * Author:Felipe e Jorge
      * Date:
      * Purpose:Gravar um log de extrato bancário
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-STATEMENT.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
                    SELECT STATEMENT-IN ASSIGN TO 'input/statement.data'
                    ORGANIZATION IS INDEXED
                    ACCESS IS RANDOM.

       DATA DIVISION.

       FILE SECTION.


       WORKING-STORAGE SECTION.
       01 WS-MOVEMENT.
           05 WS-VALUE PIC 9(10)V9(2).
           05 WS-OBSERVATION PIC A(255).
           05 WS-DATE PIC A(8).
       01 WS-EOF PIC A(1) VALUE 'N'.


       PROCEDURE DIVISION.
       STATEMENT-SHOW-PROCEDURE.
           OPEN INPUT STATEMENT-IN.
               PERFORM UNTIL WS-EOF = 'Y'
               READ STATEMENT-IN INTO WS-MOVEMENT
                    AT END MOVE 'Y' TO WS-EOF
               END-PERFORM.
           DISPLAY WS-MOVEMENT.
           STOP RUN.
       END PROGRAM BANK-STATEMENT.
