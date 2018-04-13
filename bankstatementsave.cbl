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
                SELECT STATEMENT-OUT ASSIGN TO 'output/statement.data'
                ORGANIZATION IS SEQUENTIAL.
                SELECT MOVEMENT-IN ASSIGN TO 'input/movement.data'
                ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD STATEMENT-OUT.
       01 ACCOUNT-OUT-MOVEMENT.
           05 ACCOUNT-OUT-VALUE PIC 9(10)V9(2).
           05 ACCOUNT-OUT-OBSERVATION PIC A(255).
           05 ACCOUNT-OUT-DATE PIC A(8).

       WORKING-STORAGE SECTION.
       01 WS-EOF PIC A(1).
       01 WS-EXISTS PIC A(1).

       LINKAGE SECTION.
       01 WS-OUT-ACCOUNT.
           05 WS-OUT-VALUE PIC 9(10)V9(2).
           05 WS-OUT-OBSERVATION PIC A(255).
           05 WS-OUT-DATE PIC A(8).

       PROCEDURE DIVISION USING WS-OUT-ACCOUNT.
       READ-MOVEMENT-PROCEDURE.
            OPEN INPUT MOVEMENT-IN.
               PERFORM UNTIL WS-EOF = 'Y'
               READ MOVEMENT-IN INTO WS-OUT-ACCOUNT
                    AT END MOVE 'Y' TO WS-EOF
               END-PERFORM.
       WRITE-MOVEMENT-PROCEDURE.
                    DISPLAY 'AQUI'.
           MOVE WS-OUT-ACCOUNT TO ACCOUNT-OUT-MOVEMENT.
           IF WS-EXISTS = 'N' THEN
               OPEN EXTEND STATEMENT-OUT
                   WRITE ACCOUNT-OUT-MOVEMENT
                   END-WRITE
               CLOSE STATEMENT-OUT
           END-IF.
          DISPLAY 'Movimento salvo com sucesso: 'ACCOUNT-OUT-OBSERVATION.
       goback.
