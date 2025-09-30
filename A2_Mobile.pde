int PressedRow = -1,PressedCol = -1;
int[][] board = {
    {5,3,0, 0,7,0, 0,0,0},
    {6,0,0, 1,9,5, 0,0,0},
    {0,9,8, 0,0,0, 0,6,0},

    {8,0,0, 0,6,0, 0,0,3},
    {4,0,0, 8,0,3, 0,0,1},
    {7,0,0, 0,2,0, 0,0,6},

    {0,6,0, 0,0,0, 2,8,0},
    {0,0,0, 4,1,9, 0,0,5},
    {0,0,0, 0,8,0, 0,7,9}
};

void draw_grid() {
    int size = width/9;
    for(int i = 0;i <= 9;i++) {
        int x = i*size;
        if (i%3 == 0) {
            strokeWeight(4);
        }
        else {
            strokeWeight(1);
        }
        line(x, 0, x, 9*size);
    }
    for(int j = 0;j <= 9;j++) {
        int y = j*size;
        if (j%3 == 0) {
            strokeWeight(4);
        }
        else {
            strokeWeight(1);
        }
        line(0, y, 9*size, y);
    }
}
void draw_numbers() {
    int size = width/9;
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (board[i][j] != 0) {
                fill(0);
                text(board[i][j], j*size + size/2, i*size + size/2);
            }
        }
    }
}
void pressed() {
    int size = width/9;
    int c = mouseX / size;
    int r = mouseY / size;
    if (r>=0 && r<9 && c>=0 && c<9) {
        PressedRow = r;
        PressedCol = c;
    }else{ 
        PressedRow = -1;
        PressedCol = -1;
     }    
}
void highlight() {
  int size = width/9;
  if (PressedRow != -1 && PressedCol != -1) {
    noFill();
    stroke(0, 150, 255);
    strokeWeight(4);
    rect(PressedCol * size, PressedRow * size, size, size);
  }
}
void setup() {
    fullScreen();
    draw_grid();
    textAlign(CENTER, CENTER);
    textSize(width/20);
}
void draw(){
     background(255);
     draw_grid();
     draw_numbers();
     pressed();
     highlight();
}
