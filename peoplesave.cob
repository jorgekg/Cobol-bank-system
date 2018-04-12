       IDENTIFICATION DIVISION.
       PROGRAM-ID. PEOPLESAVE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT PEOPLE ASSIGN TO 'storage/people.data'.

       DATA DIVISION.
           FILE SECTION.
           FD PEOPLE.
           01 PEOPLE-FILE.
               05 PEOPLE-ID PIC 9(10).
               05 PEOPLE-NAME PIC A(255).
               05 PEOPLE-BIRTH PIC A(8).
               05 PEOPLE-CITY PIC A(255).
               05 PEOPLE-NEIGHBORHOOD PIC A(255).
               05 PEOPLE-STREET PIC A(255).
               05 PEOPLE-NUMBER PIC 9(10).
               05 PEOPLE-CEP PIC 9(10).
               05 PEOPLE-SIGNATURE PIC A(10).

           WORKING-STORAGE SECTION.
           01 WS-EOF PIC A(1).
           01 WS-EXSIST PIC A(1) value 'N'.

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
           MOVE WS-PEOPLE-IN TO PEOPLE-FILE.
           IF WS-EXSIST = 'N' THEN
               OPEN EXTEND PEOPLE
                   WRITE PEOPLE-FILE
                   END-WRITE
               CLOSE PEOPLE
           END-IF
           DISPLAY 'Cliente salvo com sucesso: 'WS-PEOPLE-IN-ID.
           goback.
