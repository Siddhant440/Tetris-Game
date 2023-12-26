import 'dart:ui';

int rowLen = 10;
int colLen = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetro {
  L,
  I,
  J,
  O,
  S,
  Z,
  T,
}

const Map <Tetro, Color>  tetroColor ={
  Tetro.L: Color(0xFF800080), // Dark purple for L block
  Tetro.Z: Color(0xFF800000), // Dark red for J block
  Tetro.J: Color(0xFF808000), // Dark yellow for O block
  Tetro.S: Color(0xFF000080), // Dark blue for S block
  Tetro.T: Color(0xFF008000), // Dark green for T block
  Tetro.O: Color(0xFFFFA000), // Dark orange for Z block
  Tetro.I: Color(0xFF8B4513), // Dark brown for I block
};