/*--Open Fullscreen--


                                                                    ==========================
//                                                                  |    Game  of   Life     |
//                                                                  ==========================

- Juan Camilo Cardenas Zabala
- 11/04/2021

  References:
* https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_085_The_Game_of_Life/Processing/CC_085_The_Game_of_Life/CC_085_The_Game_of_Life.pde
* https://www.youtube.com/watch?v=FWSR_7kZuYg | Coding Challenge #85: The Game of Life
* https://www.youtube.com/watch?v=tENSCEO-LEc | 7.3: The Game of Life - The Nature of Code
* https://natureofcode.com/book/chapter-7-cellular-automata/#chapter07_section6 Daniel Shiffman, THE NATURE OF THE CODE
* https://en.wikipedia.org/wiki/Conway's_Game_of_Life#Examples_of_patterns

  How to play:
  1. First of all, you will have to decide the initial seed of the game. This game has three different seeds,
a random seed with alive or dead cells, a seed with different patterns that i built (block, tub, blinker, beacon and glider)
and a seed where you decide which cell is dead or alive. 

 * random seed = 1
 * pattern seed = 2
 * custom seed = 3

  2. When you decide the seed you want to have, execute the program, click once on the black screen and press 1, 2 or 3. After pressing 
     the button 1 or 2, press ENTER and the game will start. If you pressed 3, inmediately after you pressed the button you can start drawing
     on the black screen with LEFT button of the mouse. Once you finished drawing press ENTER to start the game.
     
  3. If you want to pause the game, press P on your keyboard. If you want to resume the game, press ENTER.
  
  4. If you want the game to go faster, press " + " button on your keyboard. If you want to slow the game down,
  press " - " button.
  
  5. Enjoy this beautiful cellular automaton devised by John Conway. Find more information on this page 
  https://en.wikipedia.org/wiki/Conway's_Game_of_Life.
  
*/

int rows=80,columns=50;
int[][]grid= new int[rows][columns];
int [][]hand_grid=new int[rows][columns];
boolean start=false,menu=true;
int frames=15;
char option,seed;

void setup(){
  size(800,500);
}

void draw(){
  background(0);
  if (menu==true){
    option=key;
  }seed=option;

  switch (seed){
  case '1':{RandomGrid();menu=false;}
  case '2':{Patterns();menu=false;}
  case '3':{Handmade_Grid();menu=false;}
  }
  
  if(start==true){
    Game_Of_Life();
  }
  Speed();
  Pause();
}
  
/* This function checks the rules and gives a representation of 
the next generation   */
void Game_Of_Life(){
  frameRate(frames);
  GameSpace();
  
int[][]nextG= new int[rows][columns];
//rules
  for (int i=0;i<rows;i++){
    for (int j=0;j<columns;j++){
      Rules(nextG,NeighbourCount(grid,i,j),i,j);
    }
  }
  grid=nextG;
}

//This function allows you to pause and resume the game 
void Pause(){
  if(key=='p'){
    while(keyCode!=ENTER){
      noLoop();
      if(keyCode==ENTER){
       loop();
      }
    }
  }
}

//This function controls the speed. To increase use '+', to decrease use '-'.
void Speed(){
  if(frames>3){
    if(key=='-' && frames>3){
      frames-=1;
    }
  }
  if(frames>0 && frames <60){
    if(key=='+'){
      frames+=1;
    }
  }
}

//This function creates a random seed.
void RandomGrid(){
  if(start==false){
    for (int i=0;i<rows;i++){
      for (int j=0;j<columns;j++){      
          grid[i][j]=floor(random(2));      
      }
    }
  }
  for (int i=0;i<rows;i++){
      for (int j=0;j<columns;j++){
        int x=i*10;
        int y=j*10;
        if (grid[i][j]==1){fill(255);
        }else{fill(0);}
          rect(x,y,10,10);
      }  
  }
  if(keyCode==ENTER){
      start=true;
    }
}

//This function creates some pre-configured figures on the grid.
void Patterns(){
  if(start==false){
   //block
    int a=rows/2;
    int b=columns/4;
    grid[a][b]=1;
    grid[a+1][b]=1;
    grid[a+1][b+1]=1;
    grid[a][b+1]=1;
    
   //tub
    int c=a+20;
    int d=b+17;
    grid[c][d]=1;
    grid[c+1][d-1]=1;
    grid[c+1][d+1]=1;
    grid[c+2][d]=1;
    
   //blinker
    int e=c+10;
    int f=d+15;
    grid[e][f]=1;
    grid[e+1][f]=1;
    grid[e+2][f]=1;
    
   //beacon
    int g=c-30;
    int h=d+15;
    grid[g][h]=1;
    grid[g][h+1]=1;
    grid[g+1][h]=1;
    grid[g+2][h+3]=1;
    grid[g+3][h+3]=1;
    grid[g+3][h+2]=1;
    
   //Glider
    int i=5;
    int j=5;
    grid[i][j]=1;
    grid[i+1][j+1]=1;
    grid[i+1][j+2]=1;
    grid[i+2][j]=1;
    grid[i+2][j+1]=1;
  }
  for (int i=0;i<rows;i++){
      for (int j=0;j<columns;j++){
        int x=i*10;
        int y=j*10;
        if (grid[i][j]==1){fill(255);
        }else{fill(0);}
          rect(x,y,10,10);
      }  
  }
  if(keyCode==ENTER){
      start=true;
    }
}

//This function allows you to make your own grid.
void Handmade_Grid(){
  if (mousePressed == true && start==false){
      hand_grid[int(mouseX)/10][int(mouseY)/10]=1;
      grid=hand_grid;
    }
    for (int i=0;i<rows;i++){
      for (int j=0;j<columns;j++){
        int x=i*10;
        int y=j*10;
        if (hand_grid[i][j]==1){fill(255);
        }else{fill(0);}
          rect(x,y,10,10);
      }
    }    
    if(keyCode==ENTER){
      start=true;
    }
}

//Function for implementing the game rules
void Rules(int x[][],int sum,int i, int j){

  if ((grid[i][j] == 0) && (sum == 3)) {
    x[i][j] = 1;
  }
  if ((grid[i][j] == 1) && (sum == 2 || sum == 3)) {
    x[i][j] = 1;
  }
  if ((grid[i][j] == 1) && (sum < 2 || sum > 3)) {
    x[i][j] = 0;
  } 
      
}

//Function for giving the border cells a dead state
//void Borders(){
//  for(int i=0;i<rows;i++){grid[i][0]=0;}
//  for(int j=0;j<columns;j++){grid[0][j]=0;}
//  for(int i=0;i<rows;i++){grid[i][columns-1]=0;}
//  for(int j=0;j<columns;j++){grid[rows-1][j]=0;}
//}

//Function for showing game space
void GameSpace(){
for (int i=0;i<rows;i++){
    for (int j=0;j<columns;j++){
      int x=i*10;
      int y=j*10;
      if (grid[i][j]==1){fill(255);
      }else{fill(0);}
      rect(x,y,10,10);
    }
  }
}

//Function for counting number of living Neighbours
int NeighbourCount (int x[][],int i, int j){
  int sum=0;
  sum=0;
  
  //The rest of the grid
  if((i!=0 && j!=0)&&(i!=rows-1 && j!=columns-1)){
    if(x[i-1][j-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][j+1]==1){sum++;}
        else sum+=0;
          if(x[i][j-1]==1){sum++;}
          else sum+=0;
              if(x[i][j+1]==1){sum++;}
              else sum+=0;
                if(x[i+1][j-1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][j+1]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Top left corner
  if(i==0 && j==0){
    if(x[rows-1][columns-1]==1){sum++;}
    else sum+=0;
      if(x[rows-1][j]==1){sum++;}
      else sum+=0;
        if(x[rows-1][j+1]==1){sum++;}
        else sum+=0;
          if(x[i][columns-1]==1){sum++;}
          else sum+=0;
              if(x[i][j+1]==1){sum++;}
              else sum+=0;
                if(x[i+1][columns-1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][j+1]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Top border
  if(i==0 && (j>0 && j<columns-1)){
    if(x[rows-1][j-1]==1){sum++;}
    else sum+=0;
        if(x[rows-1][j]==1){sum++;}
        else sum+=0;
          if(x[rows-1][j+1]==1){sum++;}
          else sum+=0;
            if(x[i][j-1]==1){sum++;}
            else sum+=0;
                if(x[i][j+1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j-1]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][j]==1){sum++;}
                    else sum+=0;
                      if(x[i+1][j+1]==1){sum++;}
                      else sum+=0;
                        return sum;
  }
  //Top right corner
  if(i==0 && j==columns-1){
    if(x[rows-1][j-1]==1){sum++;}
    else sum+=0;
      if(x[rows-1][j]==1){sum++;}
      else sum+=0;
        if(x[rows-1][0]==1){sum++;}
        else sum+=0;
          if(x[i][j-1]==1){sum++;}
          else sum+=0;
              if(x[i][0]==1){sum++;}
              else sum+=0;
                if(x[i+1][j-1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][0]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Left border
  if((i>0 && i<rows-1) && j==0){
    if(x[i-1][columns-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][j+1]==1){sum++;}
        else sum+=0;
          if(x[i][columns-1]==1){sum++;}
          else sum+=0;
              if(x[i][j+1]==1){sum++;}
              else sum+=0;
                if(x[i+1][columns-1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][j+1]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Right border
  if((i>0 && i<rows-1) && j==columns-1){
    if(x[i-1][j-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][0]==1){sum++;}
        else sum+=0;
          if(x[i][j-1]==1){sum++;}
          else sum+=0;
              if(x[i][0]==1){sum++;}
              else sum+=0;
                if(x[i+1][j-1]==1){sum++;}
                else sum+=0;
                  if(x[i+1][j]==1){sum++;}
                  else sum+=0;
                    if(x[i+1][0]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Bottom left corner
  if(i==rows-1 && j==0){
    if(x[i-1][columns-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][j+1]==1){sum++;}
        else sum+=0;
          if(x[i][columns-1]==1){sum++;}
          else sum+=0;
              if(x[i][j+1]==1){sum++;}
              else sum+=0;
                if(x[0][columns-1]==1){sum++;}
                else sum+=0;
                  if(x[0][j]==1){sum++;}
                  else sum+=0;
                    if(x[0][j+1]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //Bottom border
  if(i==rows-1 && (j>0 && j<columns-1)){
    if(x[i-1][j-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][j+1]==1){sum++;}
        else sum+=0;
          if(x[i][j-1]==1){sum++;}
          else sum+=0;
              if(x[i][j+1]==1){sum++;}
              else sum+=0;
                if(x[0][j-1]==1){sum++;}
                else sum+=0;
                  if(x[0][j]==1){sum++;}
                  else sum+=0;
                    if(x[0][j+1]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  //bottom right corner
  if(i==rows-1 && j==columns-1){
    if(x[i-1][j-1]==1){sum++;}
    else sum+=0;
      if(x[i-1][j]==1){sum++;}
      else sum+=0;
        if(x[i-1][0]==1){sum++;}
        else sum+=0;
          if(x[i][j-1]==1){sum++;}
          else sum+=0;
              if(x[i][0]==1){sum++;}
              else sum+=0;
                if(x[0][columns-1]==1){sum++;}
                else sum+=0;
                  if(x[0][j]==1){sum++;}
                  else sum+=0;
                    if(x[0][0]==1){sum++;}
                    else sum+=0;
                      return sum;
  }
  return sum;
}
