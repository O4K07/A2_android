int PressedRow = -1,PressedCol = -1;
int size,top;//cell size and top of numpad
int[][] board = new int[9][9];
int[][] truth_value = new int[9][9];//2D array for check input numbers or loaded numbers
String errorMessage = null;//message show when error

//load numbers from textfile
void load_sudoku(String filename) {
    int len = filename.length();
    
    //check file format
    if(!filename.substring(len - 4).equals(".txt")){
        errorMessage = "Format error";
        return;
    }
    
    String[] fileLines = loadStrings(filename);
    
    for(int i = 0; i < 9; i++) {

        String line = fileLines[i];

        for(int j = 0; j < 9; j++) {
            char digit = line.charAt(j);
            int num = int(digit)-48;
            
            //check index in file
            if(num<0 || num>9){
                errorMessage = "Index error";
                return;
            }
            board[i][j] = num;
            if(num != 0) truth_value[i][j] = 2;//2 for loaded numbers
            else truth_value[i][j] = 1;//1 for cell that you can input number
        }
    }
    
}


void draw_table() {
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
void draw_num() {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            //fill grey in loaded cell
            if (board[i][j] != 0 && truth_value[i][j]==2) {
                fill(230,230,230);
                rect(j*size, i*size, size, size);
                fill(0);
                text(board[i][j], j*size + size/2, i*size + size/2);

            }
            //void cell
            else if (board[i][j] != 0 && truth_value[i][j]==1) {
                fill(0);
                text(board[i][j], j*size + size/2, i*size + size/2);
            }
            //red number when incorrect
            else if(truth_value[i][j]==0 && board[i][j] != 0){               
                fill(255,0,0);
                text(board[i][j], j*size + size/2, i*size + size/2);

            }
        }
    }
}
void mousePressed() {
    //check that you press in board so pressedRow/Colum cant out side board
    if (mouseX >= 0 && mouseX < 9 * size && mouseY >= 0 && mouseY < 9 * size) {
        PressedCol = mouseX / size;
        PressedRow = mouseY / size;
    } 
    
    //check if you have pressed
    else if (PressedRow != -1 && PressedCol != -1) {
        //check that you press on numpad
        if (mouseX > 3 * size && mouseX < 6 * size && mouseY > top && mouseY < top + 4 * size) {
            int col = (mouseX - 3 * size) / size;
            int row = (mouseY - top) / size;
            int num = row * 3 + col + 1;
            
            //delete botton
            if (num == 11 && truth_value[PressedRow][PressedCol] != 2) {
                board[PressedRow][PressedCol] = 0;
                
                truth_value[PressedRow][PressedCol] = 1;  
            }
            //1-9 botton
            if (num >= 1 && num <= 9) {
                checkNum(PressedRow, PressedCol, num);//check is it correct
            }
            //place inputed number on board if it not loaded number and not more than 9
            if(truth_value[PressedRow][PressedCol] != 2 && num <= 9){
                board[PressedRow][PressedCol] = num;
            }
        }
    }
}
//highlight pressed cell
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
        line(x, top, x, top + 4*size);
    }

    for (int j=0; j<=4; j++) {
        int y = top + j*size;
        line(size*3, y, size*6, y);
    }

    fill(0);
    textSize(size*0.5);
    int num = 1;
    for (int r=0; r<4; r++) {
        for (int c=0; c<3; c++) {
            int x = size*(3+c) + size/2;
            int y = top + r*size + size/2;
            if (num <= 9) {
                text(num, x, y);
            } else if (num == 11) { 
                text("X", x, y);
            }
            num++;
        }
    }
}
void checkNum(int row, int col, int num) {
    //check it not loaded number
    if(truth_value[PressedRow][PressedCol] != 2){
        truth_value[PressedRow][PressedCol] = 1;
        
        //check column
        for (int j = 0; j < 9; j++) {
            if (board[row][j] == num && j != PressedCol) {
                truth_value[row][col] = 0;
            }
        }
        
        //check row
        for (int i = 0; i < 9; i++) {
            if (board[i][col] == num && i != PressedRow) {
                 truth_value[row][col] = 0;
            }
        }
        
        //check in box
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
void endgame(){
    fill(200,0,0);
    textAlign(CENTER);
    textSize(100);
    text("End!",width/2,height/2);
    return;   

}
void setup() {
    fullScreen();
    load_sudoku("board.txt");
    size = width/9;
    top = size*9+400;
    draw_table();
    textAlign(CENTER, CENTER);
    textSize(width/20);
}
void draw(){
     background(255);
     //show if it have error
     if(errorMessage != null){
        fill(200,0,0);
        textAlign(CENTER);
        textSize(100);
        text(errorMessage,width/2,height/2);
        return;
     }
     draw_table();
     highlight();
     draw_num();
     draw_numpad();
     
     int count = 0;
     int fixed_count = 0;
     for(int i=0;i<9;i++){
        for(int j=0;j<9;j++){
            if(board[i][j] != 0 && truth_value[i][j] == 1){
                count += 1;
            }
            if(truth_value[i][j] == 2){
                fixed_count += 1;
            }
        }
     }
      
    int total = count + fixed_count;
    if(total == 81){
        endgame();
    }
}
