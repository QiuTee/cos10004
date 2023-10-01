      mov R0, #0
      mov R10, #0 
      MOV R3 , #1 
      mov r4 , #0
      mov r5 , #0 
      PUSH { R0 , R10, R3 , R4 , R5 } 
///// input output of codemaker'name
      MOV R0, #namemaker
      MOV R10, #codemaker
      BL codeinout
      BL printname
      B start
continue: 
      mov r0, #4        ///// input output of codebreaker'name
      mov r10, #0
      mov r1, #0 
      PUSH { R0 , R3 }
      MOV R0, #namebreaker
      MOV R10, #codebreaker 
      BL codeinout
      BL printname2
      PUSH {R3 }
      MOV R9, #number
      BL nbinput
      BL nboutput
      BL getcode1
      BL query
      B endgame
codeinout:
      STR R0, .WriteString
      STR R10, .ReadString
      PUSH { R10 } 
      RET 
printname:              // print name codemaker 
      MOV R3, #readnamemaker
      STR R3, .WriteString
      STR R10, .WriteString
      MOV R4, #newline
      STR R4, .WriteString
      STR R10, .WriteString
      mov r5, #secretcode1
      str r5, .WriteString
      POP { R0 , R10 , R3 , R4, R5}
      RET
printname2:             //print name codebreaker 
      MOV R3, #readnamebreaker
      STR R3, .WriteString
      STR R10, .WriteString
      POP { R10 }
      POP { R0 , R3 }
      RET
nbinput: 
      STR R9, .WriteString
      LDR R9, .InputNum
      PUSH { R9 } 
      RET
nboutput:
      MOV R3, #readnumber
      STR R3, .WriteString
      STR R9, .WriteUnsignedNum
      POP {R9}
      POP { R3 }
      RET
start:
      MOV R2, #arrayCharacter
      LDR R1, arrayLength
      mov R7 , #0
      mov R8, #0
      BL getcode
      BL secret
      B continue
getcode:
      mov r11 ,#0 
      PUSH { R3, R5, R6 ,R7, R8 ,LR }
loop:                   // allow user enter cod and stor it into R4 
      mov r4 , #code2
      str r4, .ReadString
      mov R7 , #0
      mov R8, #0
      BL reset          // reset R8 to 0 every time check the code from the beginning
loop2:                  //checking condition 
      LDRB R6, [R4 + R7 ] // take each bit form memory space to compare
      CMP R6, #0
      BEQ loop
      LDR R5 , [ R2 + R8 ]
      CMP R5, R6
      BEQ jump
      BNE check
jump:
      BL reset
      add R7 , R7 , #1
      cmp R7, #4
      BEQ character5
      BLT loop2
character5:             // checking condition for character 5 
      ldrb R6, [R4 + #4]
      cmp R6, #0
      BEQ end
      BGT loop
check: 
      add R8, R8, #4
      cmp R8 , #24
      BEQ loop
      BLT loop2
end:
      POP { R3, R5, R6 ,R7, R8 ,LR } // return back to the getcode function 
      RET
secret:                 // move the codesecrect entered into the array 
      PUSH { R4 , R5 , R0 , R8 }
      MOV R5, #0 
      MOV R0 , #0 
      MOV R11 , #secretcode
      PUSH { R11 }
array1: 
      LDRB R8 , [ R4 + R5] 
      STR R8 , [ R11 + R0 ] 
      ADD R0 , R0 , #4 
      ADD R5, R5 , #1 
      CMP R5 , #4
      BLT array1 
      POP { R11 }
      POP { R4 , R5 , R0 , R8 }
      RET
getcode1:
      mov R11 , #0
      PUSH { R2, R3, R5, R6 ,R7, R8 , R12 , LR }
loop9:
      mov r1, #querycode1
      str r1, .WriteString
loop3:
      mov r4 , #code2
      str r4, .ReadString
      mov R7 , #0
      mov R8, #0
      BL reset
loop4:                  //checking condition 
      LDRB R6, [R4 + R7 ]
      CMP R6, #0
      BEQ loop
      LDR R5 , [ R2 + R8 ]
      CMP R5, R6
      BEQ jump1
      BNE check1
jump1:
      BL reset
      add R7 , R7 , #1
      cmp R7, #4
      BEQ character51
      BLT loop4
character51:            // checking condition for character 5 
      ldrb R6, [R4 + #4]
      cmp R6, #0
      BEQ loopsub 
      BGT loop3
loopsub:                // sub 1 for when enter code for codebreaker'name
      BL query
      BL drawpixel
      str r4, .WriteString
      mov r12 , #newline
      str r12 , .WriteString
      BL comparecodes
      cmp r0 , #4       /// if R0 = 4 it will print you win 
      beq loo1
      bne loo
loo1:                   ///// print you win and gameover before endgame STAGE 5b 
      str r12 , .WriteString
      str r10 , .WriteString
      mov r12, #youwin
      str r12 , .WriteString
      mov R12, #gameover
      str R12, .WriteString 
      b end1
loo:
      sub r9, r9 , #1 
      mov r12 , #newline
      str r12 , .WriteString
      str r10 , .WriteString
      mov r12, #queryop
      str r12, .WriteString
      str r9 , .WriteUnsignedNum
      cmp r9, #0        // if R9 = 0 end game and print you lose 
      BEQ end10
      BGT loop9 
check1: 
      add R8, R8, #4
      cmp R8 , #24
      BEQ loop3
      BLT loop4
end10:                  ///// print you lose and gameover before endgame STAGE 5b
      mov r12 , #newline 
      str r12 , .WriteString
      str r10 , .WriteString
      mov r12, #youlose
      str r12 , .WriteString
      mov R12, #gameover
      str R12, .WriteString
      b end1
end1:
      POP { R2, R3, R5, R6 ,R7, R8 , R12 , LR } // return back to the getcode function 
      RET
/// STAGE 5A
comparecodes: 
      PUSH { R2 , R4, R6 , R7 , R8 , R9 , R10 , R12 }
      mov R5 , #secretcode
      mov r0 , #0 
      mov r1 , #0
      PUSH { R5 , R3 } 
      mov R4 , #0 
compare:                //check condition for case 1 
      LDR R6, [ R5 + R4 ]
      LDR R7, [R3 + R4 ] 
      cmp R6, R7
      BEQ plus
      BNE cmp1 
cmp1: 
      add R4 , R4 , #4 
      cmp R4 , #16 
      beq cmp2 
      blt compare 
plus: 
      add r0 , r0 , #1 
      b cmp1 
cmp2:                   // compare for stage 2 
      sub r4, r4 , #16 
      mov r10 , #0
cmp3:                   // check condition for case 2
      LDR r9, [ r5 + r4 ] 
      LDR r2 , [ r3 + r10 ]
      cmp r9 , r2 
      beq cmp9
      bne cmp4 
cmp9: 
      add r1 , r1 , #1 
cmp4:
      add r4 , r4 , #4 
      cmp r4 , #16 
      beq cmp5
      blt cmp3
cmp5: 
      sub R4 , R4 , #16 
      add r10 , r10 , #4 
      cmp r10 , #16 
      beq cmp6 
      blt cmp3 
cmp6: 
      sub r1 , r1 , r0 
      cmp r1 , #0 
      beq case3 
      bne backtoft
case3: 
      mov R12 , #0 
backtoft:
      mov R12 , #position
      str R12 , .WriteString
      str R0 , .WriteUnsignedNum
      mov R12, #colormatches
      str R12 , .WriteString
      str R1, .WriteUnsignedNum
      b endend
endend:
      POP { R5 , R3 }
      POP { R2 , R4 , R6 , R7 , R8 , R9 , R10 , R12 }
      RET 
query:                  // move the codequery entered into the array 
      PUSH { R4 , R5 , R6 , R8 }
      MOV R5, #0 
      MOV R6 , #0 
      MOV R3 , #querycode
      PUSH { R3 } 
array9:                 // put code into array of codebraker 
      LDRB R8 , [ R4 + R5] 
      STR R8 , [ R3 + R6 ] 
      ADD R6 , R6 , #4 
      ADD R5, R5 , #1 
      CMP R5 , #4
      BLT array9 
      POP { R3 } 
      POP { R4 , R5 , R6 , R8 }
      RET
drawpixel:              ////////STAGE 6 
      PUSH { R8 , R9 , R10, LR }
      mov r1, #0 
      mov r9 , #0 
      mov r10 , #0 
check10:
      ldr r8 , [ r3 + r10 ]
      B checkpixel
check2:
      add r10 , r10 , #4 
      add r11 , r11 , #8 
      cmp r10 , #16 
      beq enddraw
      blt check10
checkpixel:             // check color pixel
      cmp r8 , #98 
      beq printblue
      bne cyan
printblue: 
      mov r9, #.blue
      BL printpixel
      b check2
cyan:
      cmp r8 , #99 
      beq printcyan
      bne green
printcyan:
      mov r9, #.cyan
      BL printpixel
      b check2
green:
      cmp r8, #103 
      beq printgreen
      bne purple
printgreen:
      mov r9, #.green
      BL printpixel
      b check2
purple:
      cmp r8, #112
      beq printpurple
      bne red
printpurple:
      mov r9, #.purple
      BL printpixel
      B check2
red:
      cmp r8, #114
      beq printred
      bne yellow
printred:
      mov r9, #.red
      BL printpixel
      b check2 
      check2
yellow:
      cmp r8, #121
      beq printyellow
      bne enddraw
printyellow:
      mov r9, #.yellow
      BL printpixel
      B check2
printpixel:             // print pixel clour into screen
      PUSH { r1 , r11 } 
      MOV R1, #.PixelScreen
      STR R9, [R1+R11]
      POP {r1 , r11 }
      RET
enddraw:
      add r11 , r11 , #224
      POP { R8 , R9 , R10, LR }
      RET
reset:
      MOV R8 ,#0
      RET
endgame:
      HALT
      .ALIGN 128
arrayLength: 6
arrayCharacter: 98      //b
      99                //c 
      103               //g
      112               //p 
      114               //r
      121               //y 
codesecretLength: 4     //// array for secret code
secretcode: 0
      0
      0
      0
codequeryLength: 4      //// array for query code
querycode: 0
      0
      0
      0
code2: .BLOCK 128
secretcode1: .ASCIZ "\t, please enter a 4-chracter secret code: "
namebreaker: .ASCIZ "\n What is codebreaker name\n"
namemaker: .ASCIZ "\n What is codemaker name\n"
number: .ASCIZ "\n What number you want to enter\n"
readnamebreaker: .ASCIZ "\n Codebreaker is:\n "
readnamemaker: .ASCIZ "\n Codemaker is: "
readnumber: .ASCIZ "\n Maximum number of guesses:\n "
newline: .ASCIZ "\n "
codemaker: .BLOCK 128
codebreaker: .BLOCK 128
querycode1: .ASCIZ " \n Enter code: "
queryop: .ASCIZ "  , this is guess number: \t "
position: .ASCIZ "Position matches : " 
colormatches: .ASCIZ ", Colour matches : " 
youwin: .ASCIZ ", You WIN ! "
youlose: .ASCIZ ", You LOSE ! " 
gameover: .ASCIZ "Game over ! "
