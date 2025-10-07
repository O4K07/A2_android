int PressedRow = -1,PressedCol = -1;
int size,top;
int[][] board = new int[9][9];
int[][] truth_value = new int[9][9];

void loadfile(String[] fileLines) {
    for(int i = 0; i < 9; i++) {
                       
        String line = fileLines[i];
        
        for(int j = 0; j < 9; j++) {
            char digit = line.charAt(j);
            int num = int(digit)-48;
            board[i][j] = num;
            if(num != 0) truth_value[i][j] = 2;
            else truth_value[i][j] = 1;
        }
    }
}


void draw_grid() {
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
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (board[i][j] != 0 && truth_value[i][j]==2) {
                fill(0);
                text(board[i][j], j*size + size/2, i*size + size/2);
            }            
            if (board[i][j] != 0 && truth_value[i][j]==1) {
                fill(0);
                text(board[i][j], j*size + size/2, i*size + size/2);
            }else if(truth_value[i][j]==0 && board[i][j] != 0){               
                fill(255,0,0);
                text(board[i][j], j*size + size/2, i*size + size/2);
                
            }
        }
    }
}
void mousePressed() {
    if (mouseX >= 0 && mouseX < 9 * size && mouseY >= 0 && mouseY < 9 * size) {
        PressedCol = mouseX / size;
        PressedRow = mouseY / size;
    } 
    else if (PressedRow != -1 && PressedCol != -1) {
        if (mouseX > 3 * size && mouseX < 6 * size && mouseY > top && mouseY < top + 3 * size) {
            int col = (mouseX - 3 * size) / size;
            int row = (mouseY - top) / size;
            int num = row * 3 + col + 1;
            is_valid(PressedRow,PressedCol,num);
            if(truth_value[PressedRow][PressedCol] != 2){
                board[PressedRow][PressedCol] = num;
            }
        }
    }
}
void highlight() {
  if (PressedRow != -1 && PressedCol != -1) {
    fill(0, 230, 0);
    rect(PressedCol * size, PressedRow * size, size, size);
  }
}
void draw_numpad() {
    stroke(0);
    strokeWeight(2);
    for (int i=0; i<=3; i++) {
        int x = size*3+(i*size);
        line(x, top, x, top + 3*size);
    }

    for (int j=0; j<=3; j++) {
        int y = top + j*size;
        line(size*3, y, size*6, y);
    }

    fill(0);
    textSize(size*0.5);
    int num = 1;
    for (int r=0; r<3; r++) {
        for (int c=0; c<3; c++) {
            int x = size*(3+c) + size/2;
            int y = top + r*size + size/2;
            text(num, x, y);
            num++;
        }
    }
}
void is_valid(int row, int col, int num) {
    if(truth_value[PressedRow][PressedCol] != 2){
        truth_value[PressedRow][PressedCol] = 1;
        
        for (int j = 0; j < 9; j++) {
            if (board[row][j] == num && j != PressedCol) {
                truth_value[row][col] = 0;
            }
        }
    
        for (int i = 0; i < 9; i++) {
            if (board[i][col] == num && i != PressedRow) {
                 truth_value[row][col] = 0;
            }
        }
    
        int boxRow = row - row % 3;
        int boxCol = col - col % 3;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              if (board[boxRow + i][boxCol + j] == num) {
                truth_value[row][col] = 0;
              }
            }
        }
  }
}
void setup() {
    fullScreen();
    loadfile(loadStrings("broad.txt"));
    size = width/9;
    top = size*9+400;
    draw_grid();
    textAlign(CENTER, CENTER);
    textSize(width/20);
}
void draw(){
     background(255);
     draw_grid();
     highlight();
     draw_numbers();
     draw_numpad();
}
