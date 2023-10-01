  1|      mov R0, #0 
  2|      mov R1, #0 
  3|      MOV R3 , #1 
  4|      PUSH { R0 , R1, R3 } 
  5|      MOV R0, #namemaker
  6|      MOV R1, #codemaker
  7|      BL codeinout
  8|      BL printname
  9|      PUSH { R0 , R1 , R3 } 
 10|      MOV R0, #namebreaker
 11|      MOV R1, #codebreaker 
 12|      BL codeinout
 13|      BL printname2
 14|      PUSH {R0}
 15|      MOV R0, #number 
 16|      BL nbinput
 17|      BL nboutput
 18|      B start
 19|codeinout:
 20|      STR R0, .WriteString
 21|      STR R1, .ReadString
 22|      RET 
 23|printname: 
 24|      MOV R3, #readnamemaker
 25|      STR R3, .WriteString
 26|      STR R1, .WriteString
 27|      POP { R0 , R1 , R3}
 28|      RET
 29|printname2: 
 30|      MOV R3, #readnamebreaker
 31|      STR R3, .WriteString
 32|      STR R1, .WriteString
 33|      POP { R0 , R1 , R3}
 34|      RET
 35|nbinput: 
 36|      STR R0, .WriteString
 37|      LDR R0, .InputNum
 38|      RET
 39|nboutput:
 40|      MOV R3, #readnumber
 41|      STR R3, .WriteString
 42|      STR R0, .WriteUnsignedNum
 43|      mov r12, #newline
 44|      str r12 , .WriteString
 45|      POP { R0 }
 46|      RET
 47|start:
 48|      MOV R2, #arrayCharacter
 49|      LDR R1, arrayLength
 50|      mov R7 , #0
 51|      mov R8, #0
 52|      BL getcode
 53|      BL pusharray 
 54|      B endgame         // endgame
 55|getcode:
 56|      PUSH { R3, R5, R6 ,R7, R8 ,LR }
 57|      mov r3, #code1
 58|      str r3, .WriteString
 59|loop:                   // allow user enter code and store it into r4 
 60|      mov r4 , #code2
 61|      str r4, .ReadString
 62|      mov R7 , #0
 63|      mov R8, #0
 64|      BL reset          // reset R8 to 0 every time check the code from the beginning
 65|loop2: 
 66|      LDRB R6, [R4 + R7 ] // take each bit form memory space to compare 
 67|      CMP R6, #0
 68|      BEQ loop
 69|      LDR R5 , [ R2 + R8 ]
 70|      CMP R5, R6
 71|      BEQ jump
 72|      BNE check
 73|jump:                   // increase 1 
 74|      BL reset
 75|      add R7 , R7 , #1
 76|      cmp R7, #4
 77|      BEQ character5
 78|      BLT loop2
 79|character5:
 80|      ldrb R6, [R4 + #4]
 81|      cmp R6, #0
 82|      BEQ end
 83|      BGT loop
 84|check:
 85|      add R8, R8, #4
 86|      cmp R8 , #24
 87|      BEQ loop
 88|      BLT loop2
 89|end:
 90|      POP { R3, R5, R6 ,R7, R8 ,LR }
 91|      RET
 92|pusharray:
 93|      PUSH { R4 , R5 , R6 , R8 }
 94|      MOV R5, #0
 95|      MOV R6 , #0
 96|      MOV R7 , #arrayData1
 97|      PUSH { R7 }
 98|array1:
 99|      LDRB R8 , [ R4 + R5]
100|      STR R8 , [ R7 + R6 ]
101|      ADD R6 , R6 , #4
102|      ADD R5, R5 , #1
103|      CMP R5 , #4
104|      BLT array1
105|      POP { R7 }
106|      POP { R4 , R5 , R6 , R8 }
107|      RET
108|reset:
109|      MOV R8 ,#0
110|      RET
111|endgame:
112|      HALT
113|      .ALIGN 128
114|arrayLength: 6
115|arrayCharacter: 98      // b
116|      99                //c
117|      103               //g
118|      112               //p
119|      114               //r
120|      121               // y
121|arraydataLength: 4
122|arrayData1: 0
123|      0
124|      0
125|      0
126|code2: .BLOCK 128
127|code1: .ASCIZ "Enter code: "
128|namebreaker: .ASCIZ "\n What is codebreaker name\n"
129|namemaker: .ASCIZ "\n What is codemaker name\n"
130|number: .ASCIZ "\n What number you want to enter\n"
131|readnamebreaker: .ASCIZ "\n Codebreaker is:\n "
132|readnamemaker: .ASCIZ "\n Codemaker is: \n"
133|readnumber: .ASCIZ "\n Maximum number of guesses: "
134|codemaker: .BLOCK 128
135|codebreaker: .BLOCK 128
136|newline: .ASCIZ "\n  "
