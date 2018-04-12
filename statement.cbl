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
                    SELECT STATEMENT-IN ASSIGN TO 'statement.data'
                    ORGANIZATION IS SEQUENTIAL.
                    SELECT STATEMENT-OUT ASSIGN TO 'statement.data'
                    ORGANIZATION IS SEQUENTIAL.


       DATA DIVISION.

       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 WS-MOVEMENT.
           05 WS-VALUE PIC 9(10)V9(2).
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            STOP RUN.
       END PROGRAM BANK-STATEMENT.
