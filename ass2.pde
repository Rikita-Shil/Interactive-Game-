void drawCharacter(int xPos){
  fill(#0E97CB);
  rect(xPos,180,80,20);
  fill(#EAD911);
  ellipse(xPos+20,180+5,10,20);
  ellipse(xPos+60,180+5,10,20);
}

void drawEnemy(int xPos){
  fill(#AFE056);
  circle(xPos,10,20);
  fill(#F24211);
  rect(xPos-10,5,20,5); 
}

void drawBullets(int xPos,int yPos){
  int verticalAdjustment = (180-yPos)/4;
  int centerOfCharacter = xPos+40;
  int startOfBullet = centerOfCharacter -10-verticalAdjustment;
  int endOfBullet = centerOfCharacter +10+verticalAdjustment;
  int increment = (endOfBullet -startOfBullet)/4;
  for(int i=startOfBullet;i<=endOfBullet;i=i+increment){
   circle(i,yPos,5);
  }
}



int enemyPositions[]= new int[]{0,0,-50,0,-80};
boolean shouldMoveForward[] = new boolean[]{true,true,true,true,true};
int enemySpeeds[] =new int[]{1,2,2,3,3};
int characterPosition = 360;
int bullets[]=new int[180];

void checkIfGameWon(){
  boolean isGameWon = true;
  for (int i=0;i< enemyPositions.length;i=i+1){
    if (enemyPositions[i]> -1000){
      isGameWon = false;
    }
  }
  if(isGameWon){
    fill(255);
    textSize(100);
    text( "GAME WON",200,100);
    noLoop();
  }
}

 
void checkIfGameLost(){
  boolean isGameLost = false;
  for (int i=0;i< enemyPositions.length;i=i+1){
    if (enemyPositions[i]<0 && enemyPositions[i]>-1000 && shouldMoveForward[i]==false ){
      isGameLost =true;
    }
  }
   if(isGameLost){
    fill(255);
    textSize(100);
    text( "GAME LOST",200,100);
    noLoop();
  }
}
 
void setup(){
  size(800,200);
  for (int i = 0;i< bullets.length;i=i+1){
    bullets[i]=-1;
  }
 }

void draw(){
  background(0); 
   // CHECK IF GAME WON
  checkIfGameWon();
  // CHECK IF GAME LOST
  checkIfGameLost();
  //  DRAW CHARACTER
  drawCharacter(characterPosition);
  // DRAW ENEMY
  for(int i=0;i<enemyPositions.length;i=i+1){
    drawEnemy(enemyPositions[i]);
   
    if (shouldMoveForward[i]){
      enemyPositions[i] = enemyPositions[i] + enemySpeeds[i];
    }
    else {
      enemyPositions[i] = enemyPositions[i] -enemySpeeds[i];
    }
    
    if (enemyPositions[i] > 800-10){
      shouldMoveForward[i] = false;
    }
  }
  // DRAW BULLETS
  for(int i=bullets.length-1;i>=0;i=i-1){
    if (bullets[i] != -1){
       drawBullets(bullets[i],(180-i)*1);
    }
    
    if (i==0){
      bullets[i]=-1;
    } else {
       bullets[i]=bullets[i-1];
    }
  }
  // CHECK IF ENEMY IS HIT
  for(int i = 160;i<180;i=i+1){
    int bulletXPosition = bullets[i];
    if (bulletXPosition != -1){
      int verticalAdjustment = i/4;
      int centerOfBullet = bulletXPosition + 40;
      int startOfBullet = centerOfBullet -10-verticalAdjustment;
      int endOfBullet = centerOfBullet +10+verticalAdjustment;
      
      for(int j=0;j<enemyPositions.length;j=j+1){
        if(enemyPositions[j] >= startOfBullet && enemyPositions[j] <= endOfBullet){
          enemyPositions[j] = -1000;
          shouldMoveForward[j] = false;
        }
      }
    }
  }
  
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == LEFT) {
      characterPosition = characterPosition - 50;
    } else if (keyCode == RIGHT) {
       characterPosition  = characterPosition + 50;
    } 
  }
  if (characterPosition < 0){
    characterPosition = 0;
  } else if (characterPosition > 720){
   characterPosition = 720;
  }
}

void mousePressed() {
  bullets[0]=characterPosition;
}
