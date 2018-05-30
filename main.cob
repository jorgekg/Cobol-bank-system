       IDENTIFICATION DIVISION.
       PROGRAM-ID. SISTEMBANK.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT IN-PUT ASSIGN TO 'input/operation.data'.
           SELECT OUT-PUT ASSIGN TO 'output/operation.data'.

       DATA DIVISION.
           FILE SECTION.
           FD IN-PUT.
           01 IN-PUT-FILE.
               05 DATA-INPUT-OPERATION-ID PIC 9(5).

           FD OUT-PUT.
           01 OUT-PUT-FILE.
               05 DATA-OUTPUT-STATUS PIC A(3).
               05 DATA-OUTPUT-SERVICE PIC A(3).

           WORKING-STORAGE SECTION.
           01 WS-INPUT.
               05 WS-INPUT-OPERATION-ID PIC 9(5).

           01 WS-EOF PIC A(1).

       PROCEDURE DIVISION.
           OPEN INPUT IN-PUT.
               PERFORM UNTIL WS-EOF='Y'
                   READ IN-PUT INTO WS-INPUT
                       AT END MOVE 'Y' TO WS-EOF
                       not at end
                       IF WS-INPUT-OPERATION-ID = 1 THEN
                           DISPLAY "CADASTRO DE CLIENTE"
                           CALL 'PEOPLE' USING BY CONTENT WS-INPUT
                       END-IF
                       IF WS-INPUT-OPERATION-ID = 2 THEN
                          CALL 'PEOPLEACCOUNT' USING BY CONTENT WS-INPUT
                       END-IF
                       IF WS-INPUT-OPERATION-ID = 3 THEN
                           CALL "PEOPLEGET"
                       END-IF
                       IF WS-INPUT-OPERATION-ID = 4 THEN
                           DISPLAY "VALIDAR LOGIN E SENHA"
                       END-IF
                       IF WS-INPUT-OPERATION-ID = 5 THEN
                           CALL "PEOPLENAME"
                       END-IF
                   END-READ
               END-PERFORM.
           CLOSE IN-PUT.
           STOP RUN.
