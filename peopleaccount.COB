      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PEOPLEACCOUNT.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
             FILE-CONTROL.
             SELECT ACCOUNT-IN ASSIGN TO 'input/accout.data'.
             SELECT ACCOUNT ASSIGN TO 'storage/accout.data'
             ORGANIZATION IS INDEXED
             ACCESS IS RANDOM
             RECORD KEY IS ACCOUNT-ID
             FILE STATUS IS FS.


       DATA DIVISION.
           FILE SECTION.
           FD ACCOUNT.
           01 ACCOUNT-FILE.
               05 ACCOUNT-ID PIC 9(10).

           FD ACCOUNT-IN.
           01 ACCOUNT-IN-FILE.
               05 ACCOUNT-IN-ID PIC 9(10).
               05 ACCOUNT-IN-OPERATION PIC 9(5).
               05 ACCOUNT-IN-SIGNATURE PIC A(10).

       WORKING-STORAGE SECTION.
           01 WS-EOF PIC A(1).
           01 WS-EXSIST PIC A(1) value 'N'.
           01 FS PIC 9(10) USAGE NATIONAL.

       LINKAGE SECTION.
           01 WS-INPUT.
               05 WS-INPUT-OPERATION-ID PIC 9(5).
               05 WS-INPUT-SIGNATURE PIC A(10).

       PROCEDURE DIVISION.
           OPEN INPUT ACCOUNT-IN
               PERFORM UNTIL WS-EOF='Y'
                   READ ACCOUNT-IN
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END
                       IF WS-INPUT-SIGNATURE = ACCOUNT-IN-SIGNATURE THEN
                           MOVE ACCOUNT-IN-ID TO ACCOUNT-ID
                           OPEN I-O ACCOUNT
                               READ ACCOUNT
                                   KEY IS ACCOUNT-ID
                                   INVALID KEY
                                   WRITE ACCOUNT-IN-FILE
                                   END-WRITE
                                   NOT INVALID KEY
                                   IF ACCOUNT-IN-OPERATION = 1 THEN
                                       DISPLAY 'SALDO'
                                   END-IF
                                   IF ACCOUNT-IN-OPERATION = 2 THEN
                                       DISPLAY 'SAQUE'
                                   END-IF
                                   IF ACCOUNT-IN-OPERATION = 3 THEN
                                       DISPLAY 'DEPOSITO'
                                   END-IF
                                   IF ACCOUNT-IN-OPERATION = 4 THEN
                                       DISPLAY 'EMPRESTIMO'
                                   END-IF
                               END-READ
                           CLOSE ACCOUNT
                       END-IF
                   END-READ
               END-PERFORM.
           CLOSE ACCOUNT.
