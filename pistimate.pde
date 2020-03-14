/***************
 * PI-stimator *
 ***************/
//last updated 03/14/2020
import java.math.*;
float sampleSize = 1000;
int[] xPoints = new int[(int)sampleSize];
int[] yPoints = new int[(int)sampleSize];
float estimate = 0;
float PIsquared;
int index = 0;
float coprimes = 0;
char gameState = 's';
boolean newCalc = true;

void setup() {
  size (800, 800);
  colorMode(HSB,360,100,100);
  background(0,0,0);
  //noLoop();
}

void draw(){
   switch(gameState){
    case 'r':
      RunCalc();
      break;
    case 'd':
      EndScreen();
      break;
    case 's':
      StartScreen();
      break;
  }
}

void RunCalc(){
  background(0,0,100);
  if(newCalc){
    index=0;
    coprimes=0;
    newCalc=false;
  }
  
  if(index<sampleSize){
    fill(0,0,0);
    textSize(12);
    text(index, 660, 754);
    text(mouseX, 660, 767);
    text(mouseY, 660, 780);
    xPoints[index] = mouseX;
    yPoints[index] = mouseY;
    index++;
  }
  
  if(index==sampleSize){
    for(int i=0; i<sampleSize; i++){
      if(isCoprime(xPoints[i],yPoints[i])){
         coprimes++; 
      }
    }
    //calculate Pi! from coprimes.
    PIsquared = 6*(sampleSize/coprimes);
    estimate = sqrt(PIsquared);
    gameState = 'd';
  }
}

boolean isCoprime(int x, int y){
  while(x!=y){
    if (x>y){
      x-=y;
    } else {
      y-=x;
    }
  }
  if(y==1){
    return true;
  } else {
    return false;
  }
}

void StartScreen(){
  background(0,0,100);
  
  fill(0,0,0);
  stroke(0,0,0);
  rect(325,450,150,50);
  
  textSize(40);
  text("PI-Stimator!", 290, 250);
  textSize(20);
  text("Move your cursor on the sketch to generate " +(int)sampleSize, 170, 310);
  text("random pairs of numbers to estimate Pi!", 200, 340);
  
  textSize(12);
  text("Made by Alexandre S.", 660, 780);
  
  textSize(25);
  fill(0,0,100);
  text("Calculate", 348, 485); 
}

void EndScreen(){
  background(0,0,100);
  
  fill(0,0,0);
  stroke(0,0,0);
  rect(325,450,150,50);
  
  textSize(40);
  text("Your π estimate is:", 230, 250);
  text(estimate, 310, 300);
  textSize(20);
  text("This estimate is "+(estimate/PI)*100+"% acurrate.", 235, 360);
  
  textSize(12);
  text("Made by Alexandre S.", 660, 780);
  
  textSize(25);
  fill(0,0,100);
  text("Recalculate", 333, 485); 
}

void mouseClicked() {
  if(gameState == 'r'){
    // does nothing
  } else {
    if(mouseX > 325 && mouseX < 475){
      if(mouseY > 450 && mouseY < 500){
        gameState = 'r';
        newCalc = true;
      }
    }
  }
}
