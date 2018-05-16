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
               05 PEOPLE-RW-CPF PIC A(10).
               05 PEOPLE-RW-TELEFONE PIC A(10).
               05 PEOPLE-RW-SENHA PIC A(8).

           WORKING-STORAGE SECTION.
           01 WS-PEOPLE-FILE-IN.
               05 WS-PEOPLE-FILE-IN-ID PIC 9(10).
               05 WS-PEOPLE-FILE-IN-NAME PIC A(255).
               05 WS-PEOPLE-FILE-IN-CPF PIC A(10).
               05 WS-PEOPLE-FILE-IN-TELEFONE PIC A(10).
               05 WS-PEOPLE-FILE-IN-SENHA PIC A(8).
           01 WS-EOF PIC A(1).
           01 WS-EXSIST PIC A(1).
           01 FS PIC 9(10) USAGE NATIONAL.

           LINKAGE SECTION.
           01 WS-PEOPLE-IN.
               05 WS-PEOPLE-IN-ID PIC 9(10).
               05 WS-PEOPLE-IN-NAME PIC A(255).
               05 WS-PEOPLE-IN-CPF PIC A(10).
               05 WS-PEOPLE-IN-TELEFONE PIC A(10).
               05 WS-PEOPLE-IN-SENHA PIC A(8).


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
