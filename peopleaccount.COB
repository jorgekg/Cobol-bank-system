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
             SELECT PEOPLE-RW ASSIGN TO 'storage/people.data'
             ORGANIZATION IS INDEXED
             ACCESS IS RANDOM
             RECORD KEY IS PEOPLE-RW-ID
             FILE STATUS IS FS.
             SELECT ACCOUNT-IN ASSIGN TO 'input/account.data'.
             SELECT ACCOUNT ASSIGN TO 'storage/account.data'
             ORGANIZATION IS INDEXED
             ACCESS IS RANDOM
             RECORD KEY IS ACCOUNT-ID
             FILE STATUS IS FS.


       DATA DIVISION.
           FILE SECTION.
           FD ACCOUNT.
           01 ACCOUNT-FILE.
               05 ACCOUNT-ID PIC 9(10).
               05 ACCOUNT-PEOPLE-ID PIC 9(10).

           FD ACCOUNT-IN.
           01 ACCOUNT-IN-FILE.
               05 ACCOUNT-IN-ID PIC 9(10).
               05 ACCOUNT-IN-PEOPLE-ID PIC 9(10).
               05 ACCOUNT-IN-OPERATION PIC 9(5).
               05 ACCOUNT-IN-SIGNATURE PIC A(10).

           FD PEOPLE-RW.
           01 PEOPLE-RW-FILE.
               05 PEOPLE-RW-ID PIC 9(10).
               05 PEOPLE-RW-NAME PIC A(255).
               05 PEOPLE-RW-BIRTH PIC A(8).
               05 PEOPLE-RW-CITY PIC A(255).
               05 PEOPLE-RW-NEIGHBORHOOD PIC A(255).
               05 PEOPLE-RW-STREET PIC A(255).
               05 PEOPLE-RW-NUMBER PIC 9(10).
               05 PEOPLE-RW-CEP PIC 9(10).
               05 PEOPLE-RW-SIGNATURE PIC A(10).

       WORKING-STORAGE SECTION.
           01 WS-EOF PIC A(1).
           01 WS-EXSIST PIC A(1) value 'N'.
           01 FS PIC 9(10) USAGE NATIONAL.
           01 WS-PEOPLE-EXISTS PIC A(1).

           LINKAGE SECTION.
           01 WS-INPUT.
               05 WS-INPUT-OPERATION-ID PIC 9(5).
               05 WS-INPUT-SIGNATURE PIC A(10).

       PROCEDURE DIVISION USING WS-INPUT.
           OPEN INPUT ACCOUNT-IN
               PERFORM UNTIL WS-EOF='Y'
                   READ ACCOUNT-IN
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END
                       IF WS-INPUT-SIGNATURE = ACCOUNT-IN-SIGNATURE THEN
                          MOVE ACCOUNT-IN-ID TO ACCOUNT-ID
                          MOVE ACCOUNT-IN-PEOPLE-ID TO ACCOUNT-PEOPLE-ID
                          OPEN I-O PEOPLE-RW
                               DISPLAY ACCOUNT-IN-PEOPLE-ID
                               MOVE ACCOUNT-IN-PEOPLE-ID TO PEOPLE-RW-ID
                               READ PEOPLE-RW
                                   KEY IS PEOPLE-RW-ID
                                   INVALID KEY
                                   MOVE 'N' TO WS-PEOPLE-EXISTS
                                   NOT INVALID KEY
                                   MOVE 'Y' TO WS-PEOPLE-EXISTS
                               END-READ
                          CLOSE PEOPLE-RW
                          IF WS-PEOPLE-EXISTS = 'Y' THEN
                              OPEN I-O ACCOUNT
                                   READ ACCOUNT
                                       KEY IS ACCOUNT-ID
                                       INVALID KEY
                                       WRITE ACCOUNT-FILE
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
                          ELSE
                           DISPLAY 'PESSOA NÃO ENCONTRADA'
                          END-IF
                       END-IF
                   END-READ
               END-PERFORM.
           CLOSE ACCOUNT-IN.
