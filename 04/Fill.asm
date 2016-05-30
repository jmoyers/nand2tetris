// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

(INIT)
  // 1 bit per pixel, (256 x 512) / 16 = 8192 - apparently the only way to use
  // literals is to set an address and then take the value out of the addr reg
  @8192
  D=A
  @screen_size
  M=D

(MAIN_LOOP)
  // Check the keyboard buffer
  @KBD
  D=M
  
  // If the value is non-zero, a key is depressed, so draw black
  @FILL_BLACK
  D;JNE

  // If the value is zero, no key is deperessed, so clear the screen
  @FILL_WHITE
  D;JEQ

  @MAIN_LOOP
  0;JMP

(FILL_BLACK)
  @color
  M=-1
  @DRAW
  0;JMP

(FILL_WHITE)
  @color
  M=0

(DRAW)
  // Initialize screen location to beginning of screen buffer
  @SCREEN
  D=A

  @screen_location
  M=D

(DRAW_LOOP)
  // Dump color into register
  @color
  D=M

  // Set the current screen location to color in register
  @screen_location
  A=M
  M=D

  // Increment screen location pointer
  @screen_location
  M=M+1
  D=M

  // (screen_location - screen) < screen_size, keep drawing
  @SCREEN
  D=D-A

  @screen_size
  D=M-D

  @DRAW_LOOP
  D;JGT

  // Return to main loop if we've exceeded screen size
  @MAIN_LOOP
  0;JMP
