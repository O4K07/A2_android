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
}
