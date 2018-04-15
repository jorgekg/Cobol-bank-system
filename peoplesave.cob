       IDENTIFICATION DIVISION.
       PROGRAM-ID. PEOPLESAVE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
             FILE-CONTROL.
             SELECT PEOPLE-RW ASSIGN TO 'storage/people.data'
             ORGANIZATION IS INDEXED
             ACCESS IS RANDOM
             RECORD KEY IS PEOPLE-RW-ID
             FILE STATUS IS FS.

       DATA DIVISION.
           FILE SECTION.
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
           01 WS-PEOPLE-FILE-IN.
               05 WS-PEOPLE-FILE-IN-ID PIC 9(10).
               05 WS-PEOPLE-FILE-IN-NAME PIC A(255).
               05 WS-PEOPLE-FILE-IN-BIRTH PIC A(8).
               05 WS-PEOPLE-FILE-IN-CITY PIC A(255).
               05 WS-PEOPLE-FILE-IN-NEIGHBORHOOD PIC A(255).
               05 WS-PEOPLE-FILE-IN-STREET PIC A(255).
               05 WS-PEOPLE-FILE-IN-NUMBER PIC 9(10).
               05 WS-PEOPLE-FILE-IN-CEP PIC 9(10).
               05 WS-PEOPLE-FILE-IN-SIGNATURE PIC A(10).
           01 WS-EOF PIC A(1).
           01 WS-EXSIST PIC A(1).
           01 FS PIC 9(10) USAGE NATIONAL.

           LINKAGE SECTION.
           01 WS-PEOPLE-IN.
               05 WS-PEOPLE-IN-ID PIC 9(10).
               05 WS-PEOPLE-IN-NAME PIC A(255).
               05 WS-PEOPLE-IN-BIRTH PIC A(8).
               05 WS-PEOPLE-IN-CITY PIC A(255).
               05 WS-PEOPLE-IN-NEIGHBORHOOD PIC A(255).
               05 WS-PEOPLE-IN-STREET PIC A(255).
               05 WS-PEOPLE-IN-NUMBER PIC 9(10).
               05 WS-PEOPLE-IN-CEP PIC 9(10).
               05 WS-PEOPLE-IN-SIGNATURE PIC A(10).


       PROCEDURE DIVISION USING WS-PEOPLE-IN.
           OPEN I-O PEOPLE-RW
               MOVE WS-PEOPLE-IN-ID TO PEOPLE-RW-ID
               READ PEOPLE-RW
                   KEY IS PEOPLE-RW-ID
                   INVALID KEY
                   WRITE PEOPLE-RW-FILE
                   END-WRITE
                   DISPLAY 'GRAVAR'
                   NOT INVALID KEY
                   MOVE WS-PEOPLE-IN-NAME TO PEOPLE-RW-NAME
                   REWRITE PEOPLE-RW-FILE
                   END-REWRITE
                   DISPLAY 'ATUALIZAR'
               END-READ
               DISPLAY PEOPLE-RW-FILE

           CLOSE PEOPLE-RW.
           goback.
