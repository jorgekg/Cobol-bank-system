      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK-STATEMENT-SAVE.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
              FILE-CONTROL.
              SELECT STATEMENT-OUTPUT ASSIGN TO 'output/statement.data'.
              SELECT STATEMENT-OUT ASSIGN TO 'storage/statement.data'
              ORGANIZATION IS INDEXED
              ACCESS IS RANDOM
              RECORD KEY ACCOUNT-ID
              FILE STATUS IS FS.

       DATA DIVISION.
       FILE SECTION.
       FD STATEMENT-OUT.
       01 ACCOUNT-OUT-MOVEMENT.
           05 ACCOUNT-OUT-VALUE PIC 9(10)V9(2).
           05 ACCOUNT-ID PIC 9(10).



       FD STATEMENT-OUTPUT.
       01 OUT-ACCOUNT-FILE.
           05 OUT-ACCOUNT-DS PIC A(3).
           05 OUT-ACCOUNT-VALUE PIC 9(10)V9(2).

       WORKING-STORAGE SECTION.
       01 WS-EOF PIC A(1).
       01 WS-EXISTS PIC A(1).
       01 FS PIC A(1).
       01 WS-VALUE PIC 9(10)V9(2).

       LINKAGE SECTION.
       01 WS-ACCOUNT.
           05 WS-OPERATION-ID PIC A(5).
           05 WS-ACCOUNT-ID PIC 9(10).
           05 WS-MOVEMENT-VALUE PIC 9(10).


       PROCEDURE DIVISION USING WS-ACCOUNT.
      *>  1 -> SALDO
      *>  2 -> SAQUE
      *>  3 -> DEPOSITO
      *>  4 -> EMPRESTIMO
           IF WS-OPERATION-ID = 1 THEN
                OPEN I-O STATEMENT-OUT
                MOVE WS-ACCOUNT-ID TO ACCOUNT-ID
                READ STATEMENT-OUT
                         KEY IS ACCOUNT-ID
                         INVALID KEY
                         MOVE 0 TO OUT-ACCOUNT-VALUE
                         WRITE OUT-ACCOUNT-FILE
                         END-WRITE
                         NOT INVALID KEY
                         MOVE ACCOUNT-OUT-VALUE TO OUT-ACCOUNT-VALUE
                         WRITE OUT-ACCOUNT-FILE
                         END-WRITE
                END-READ
                CLOSE STATEMENT-OUT
           ELSE IF WS-OPERATION-ID = 2 THEN
                OPEN I-O STATEMENT-OUT
                MOVE WS-ACCOUNT-ID TO ACCOUNT-ID
                READ STATEMENT-OUT
                    KEY IS ACCOUNT-ID
                    INVALID KEY
                    MOVE 0 TO ACCOUNT-OUT-VALUE
                    WRITE ACCOUNT-OUT-MOVEMENT
                    END-WRITE
                    MOVE 'NAN' TO OUT-ACCOUNT-DS
                    WRITE OUT-ACCOUNT-FILE
                    END-WRITE
                    NOT INVALID KEY
                    IF ACCOUNT-OUT-VALUE < WS-MOVEMENT-VALUE THEN
                         MOVE 'NAN' TO OUT-ACCOUNT-DS
                         WRITE OUT-ACCOUNT-FILE
                    ELSE
                       SUBTRACT WS-MOVEMENT-VALUE FROM ACCOUNT-OUT-VALUE
                       REWRITE ACCOUNT-OUT-MOVEMENT
                       END-REWRITE
                    END-IF

           ELSE IF (WS-OPERATION-ID = 3) THEN
                OPEN I-O STATEMENT-OUT
                MOVE WS-ACCOUNT-ID TO ACCOUNT-ID
                READ STATEMENT-OUT
                    KEY IS ACCOUNT-ID
                    INVALID KEY
                    MOVE WS-MOVEMENT-VALUE TO ACCOUNT-OUT-VALUE
                    WRITE OUT-ACCOUNT-FILE
                    END-WRITE
                    NOT INVALID KEY
                    MOVE WS-MOVEMENT-VALUE TO ACCOUNT-OUT-VALUE
                    REWRITE ACCOUNT-OUT-MOVEMENT
                    END-REWRITE
           ELSE IF WS-OPERATION-ID = 4 THEN
                DISPLAY 'AGUARDANDO IMPLEMENTAÇÃO'
           END-IF.

       goback.
