  1|      mov R0, #0 
  2|      mov R1, #0 
  3|      MOV R3 , #1 
  4|      PUSH { R0 , R1, R3 , R4 } 
  5|///// input output of codemaker'name
  6|      MOV R0, #namemaker
  7|      MOV R1, #codemaker
  8|      BL codeinout
  9|      BL printname
 10|      B start
 11|continue:               ///// input output of codebreaker'name
 12|      mov r0 , #0
 13|      mov r1, #0
 14|      PUSH { R0 , R1 , R3 } 
 15|      MOV R0, #namebreaker
 16|      MOV R1, #codebreaker 
 17|      BL codeinout
 18|      BL printname2
 19|      PUSH {R0}
 20|      MOV R0, #number 
 21|      BL nbinput
 22|      BL nboutput
 23|      B endgame
 24|codeinout:
 25|      STR R0, .WriteString
 26|      STR R1, .ReadString
 27|      RET 
 28|printname:              // print name codemaker 
 29|      MOV R3, #readnamemaker
 30|      STR R3, .WriteString
 31|      STR R1, .WriteString
 32|      MOV R4, #newline
 33|      STR R4, .WriteString
 34|      STR R1, .WriteString
 35|      POP { R0 , R1 , R3 , R4 }
 36|      RET
 37|printname2:             //print name codebreaker 
 38|      MOV R3, #readnamebreaker
 39|      STR R3, .WriteString
 40|      STR R1, .WriteString
 41|      POP { R0 , R1 , R3}
 42|      RET
 43|nbinput: 
 44|      STR R0, .WriteString
 45|      LDR R0, .InputNum
 46|      RET
 47|nboutput:
 48|      MOV R3, #readnumber
 49|      STR R3, .WriteString
 50|      STR R0, .WriteUnsignedNum
 51|      POP { R0 }
 52|      RET
 53|start:
 54|      MOV R2, #arrayCharacter
 55|      LDR R1, arrayLength
 56|      mov R7 , #0
 57|      mov R8, #0
 58|      BL getcode
 59|      BL secret
 60|      B continue
 61|getcode:
 62|      PUSH { R3, R5, R6 ,R7, R8 ,LR }
 63|      mov r3, #secretcode1
 64|      str r3, .WriteString
 65|loop:
 66|      mov r4 , #code2
 67|      str r4, .ReadString
 68|      mov R7 , #0
 69|      mov R8, #0
 70|      BL reset
 71|loop2:
 72|      LDRB R6, [R4 + R7 ]
 73|      CMP R6, #0
 74|      BEQ loop
 75|      LDR R5 , [ R2 + R8 ]
 76|      CMP R5, R6
 77|      BEQ jump
 78|      BNE check
 79|jump:
 80|      BL reset
 81|      add R7 , R7 , #1
 82|      cmp R7, #4
 83|      BEQ character5
 84|      BLT loop2
 85|character5:             // checking condition for character 5 
 86|      ldrb R6, [R4 + #4]
 87|      cmp R6, #0
 88|      BEQ end
 89|      BGT loop
 90|check: 
 91|      add R8, R8, #4
 92|      cmp R8 , #24
 93|      BEQ loop
 94|      BLT loop2
 95|end:
 96|      POP { R3, R5, R6 ,R7, R8 ,LR } // return back to the getcode function 
 97|      RET
 98|secret:                 // move the codesecrect entered into the array 
 99|      PUSH { R4 , R5 , R6 , R7 , R8 }
100|      MOV R5, #0 
101|      MOV R6 , #0 
102|      MOV R7 , #secretcode
103|array1: 
104|      LDRB R8 , [ R4 + R5] 
105|      STR R8 , [ R7 + R6 ] 
106|      ADD R6 , R6 , #4 
107|      ADD R5, R5 , #1 
108|      CMP R5 , #4
109|      BLT array1 
110|      POP { R4 , R5 , R6 , R7 , R8 }
111|      RET
112|reset:
113|      MOV R8 ,#0
114|      RET
115|endgame:
116|      HALT
117|arrayLength: 6
118|arrayCharacter: 98
119|      99
120|      103
121|      112
122|      114
123|      121
124|codesecretLength: 4     //// array for secret code
125|secretcode: 0
126|      0
127|      0
128|      0
129|code2: .BLOCK 128
130|secretcode1: .ASCIZ "\t, please enter a 4-chracter secret code: "
131|namebreaker: .ASCIZ "\n What is codebreaker name\n"
132|namemaker: .ASCIZ "\n What is codemaker name\n"
133|number: .ASCIZ "\n What number you want to enter\n"
134|readnamebreaker: .ASCIZ "\n Codebreaker is:\n "
135|readnamemaker: .ASCIZ "\n Codemaker is: "
136|readnumber: .ASCIZ "\n Maximum number of guesses:\n "
137|newline: .ASCIZ "\n "
138|codemaker: .BLOCK 128
139|codebreaker: .BLOCK 128
