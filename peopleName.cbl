       IDENTIFICATION DIVISION.
       PROGRAM-ID. PEOPLENAME.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
             FILE-CONTROL.
             SELECT EXISTS-RW ASSIGN TO 'output/name.data'.
             SELECT IN-PUT ASSIGN TO 'input/name.data'.
             SELECT PEOPLE-RW ASSIGN TO 'storage/people.data'
             ORGANIZATION IS INDEXED
             ACCESS IS RANDOM
             RECORD KEY IS PEOPLE-RW-CPF
             FILE STATUS IS FS.


       DATA DIVISION.
           FILE SECTION.
           FD EXISTS-RW.
           01 EXISTS-RW-FILE.
               05 EXISTS-RW-NAME PIC A(255).

           FD IN-PUT.
           01 IN-PUT-FILE.
               05 IN-INPUT-CPF PIC A(11).

           FD PEOPLE-RW.
           01 PEOPLE-RW-FILE.
               05 PEOPLE-RW-NAME PIC A(255).
               05 PEOPLE-RW-CPF PIC A(11).
               05 PEOPLE-RW-TELEFONE PIC A(10).
               05 PEOPLE-RW-SENHA PIC A(8).



           WORKING-STORAGE SECTION.
           01 WS-INPUT.
               05 WS-INPUT-CPF PIC A(11).

           01 WS-PEOPLE-FILE-IN.
               05 WS-PEOPLE-FILE-IN-NAME PIC A(255).
               05 WS-PEOPLE-FILE-IN-CPF PIC A(11).
               05 WS-PEOPLE-FILE-IN-TELEFONE PIC A(10).
               05 WS-PEOPLE-FILE-IN-SENHA PIC A(8).
           01 WS-EOF PIC A(1).
           01 WS-Nome PIC A(255).
           01 WS-CPF PIC A(11).
           01 FS PIC 9(10) USAGE NATIONAL.


       PROCEDURE DIVISION.
           OPEN INPUT IN-PUT.
               PERFORM UNTIL WS-EOF='Y'
                   READ IN-PUT INTO WS-INPUT
                   AT END MOVE 'Y' TO WS-EOF
                       not at end
                       MOVE WS-INPUT-CPF TO WS-CPF
                   END-READ
               END-PERFORM.
           CLOSE IN-PUT.
           DISPLAY WS-CPF
           OPEN I-O PEOPLE-RW
               MOVE WS-CPF TO PEOPLE-RW-CPF
               READ PEOPLE-RW into WS-PEOPLE-FILE-IN
                   KEY IS PEOPLE-RW-CPF
                   INVALID KEY MOVE "" TO WS-Nome
                  NOT INVALID KEY MOVE WS-PEOPLE-FILE-IN-NAME TO WS-Nome
               END-READ
           CLOSE PEOPLE-RW.
           DISPLAY WS-Nome
           OPEN EXTEND EXISTS-RW.
               MOVE WS-Nome TO EXISTS-RW-NAME
               WRITE EXISTS-RW-FILE
               END-WRITE.
           CLOSE EXISTS-RW.
           goback.
