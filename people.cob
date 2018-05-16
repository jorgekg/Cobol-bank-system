       IDENTIFICATION DIVISION.
       PROGRAM-ID. PEOPLE.

       ENVIRONMENT DIVISION.
          INPUT-OUTPUT SECTION.
             FILE-CONTROL.
             SELECT PEOPLE-IN ASSIGN TO 'input/people.data'.

       DATA DIVISION.
           FILE SECTION.
           FD PEOPLE-IN.
           01 PEOPLE-IN-FILE.
               05 PEOPLE-IN-ID PIC 9(10).
               05 PEOPLE-IN-NAME PIC A(255).
               05 PEOPLE-IN-CPF PIC A(10).
               05 PEOPLE-IN-TELEFONE PIC A(10).
               05 PEOPLE-IN-SENHA PIC A(8).

           WORKING-STORAGE SECTION.
           01 WS-PEOPLE-IN.
               05 WS-PEOPLE-IN-ID PIC 9(10).
               05 WS-PEOPLE-IN-NAME PIC A(255).
               05 WS-PEOPLE-IN-CPF PIC A(10).
               05 WS-PEOPLE-IN-TELEFONE PIC A(10).
               05 WS-PEOPLE-IN-SENHA PIC A(8).
           01 WS-EOF PIC A(1).

           LINKAGE SECTION.
           01 WS-INPUT.
               05 WS-INPUT-OPERATION-ID PIC 9(5).
               05 WS-INPUT-SIGNATURE PIC A(10).

       PROCEDURE DIVISION USING WS-INPUT.
           OPEN INPUT PEOPLE-IN.
           PERFORM UNTIL WS-EOF='Y'
               READ PEOPLE-IN INTO WS-PEOPLE-IN
               AT END MOVE 'Y' TO WS-EOF
                   not at end
                       CALL 'PEOPLESAVE' USING BY CONTENT WS-PEOPLE-IN
                   END-READ
               END-PERFORM.
           CLOSE PEOPLE-IN.
           goback.
