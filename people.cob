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
               05 PEOPLE-IN-BIRTH PIC A(8).
               05 PEOPLE-IN-CITY PIC A(255).
               05 PEOPLE-IN-NEIGHBORHOOD PIC A(255).
               05 PEOPLE-IN-STREET PIC A(255).
               05 PEOPLE-IN-NUMBER PIC 9(10).
               05 PEOPLE-IN-CEP PIC 9(10).
               05 PEOPLE-IN-SIGNATURE PIC A(10).

           WORKING-STORAGE SECTION.
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
                   IF WS-INPUT-SIGNATURE = WS-PEOPLE-IN-SIGNATURE THEN
                     CALL 'PEOPLESAVE' USING BY CONTENT WS-PEOPLE-IN
                   END-IF
                   END-READ
               END-PERFORM.
           CLOSE PEOPLE-IN.
           DISPLAY 'Operacao para a sessao: 'WS-INPUT-SIGNATURE.
           goback.
