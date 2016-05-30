// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

  // accumulate result of the addition
  @acc
  M=0

  // counter for how many times we'll add r0 to accumulator
  @counter
  M=0

(LOOP)
  // if counter == r1, end
  @counter
  D=M
  @R1
  D=D-M
  @STOP
  D;JEQ

  // counter++;
  @counter
  M=M+1

  // acc = acc + r0
  @acc
  D=M;
  @R0
  D=D+M
  @acc
  M=D

  @LOOP
  0;JMP
  
(STOP)
  @acc
  D=M
  @R2
  M=D

(END)
  @END
  0;JMP
