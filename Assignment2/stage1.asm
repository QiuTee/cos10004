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
 18|      B end
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
 43|      POP { R0 }
 44|      RET
 45|end:
 46|      HALT
 47|namebreaker: .ASCIZ "\n What is codebreaker name\n"
 48|namemaker: .ASCIZ "\n What is codemaker name\n"
 49|number: .ASCIZ "\n What number you want to enter\n"
 50|readnamebreaker: .ASCIZ "\n Codebreaker is:\n "
 51|readnamemaker: .ASCIZ "\n Codemaker is: \n"
 52|readnumber: .ASCIZ "\n Maximum number of guesses:\n "
 53|codemaker: .BLOCK 128
 54|codebreaker: .BLOCK 128