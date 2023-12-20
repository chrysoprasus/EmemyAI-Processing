/*
* enemy AI that follows the player
*
* 
* @author: James Logan
* @version: 1
*/


//Player vars
PVector playerPos, playerVel;
int playerSize = 25;
color playerHit = color(0,255,0);
boolean playerDamaged = false;


//Ai vars
PVector aiPos, aiVel, aiDecPos, aiDecVel, posAttack;
int aiRadius = 200;
boolean detected = false;
color hit = color(255,0,0,9);
float easing = 0.02;

//Set up
void setup() {
  frameRate(60);
  size(960, 970);
  ellipseMode(RADIUS);
  
  //Setting up player vars 
  playerPos = new PVector(width*0.25, height*0.75);
  playerVel = new PVector(8,0);
  
  //Setting up AI vars
  aiPos = new PVector(width*0.1, height*0.5);
  aiVel = new PVector(2,0);
  aiDecPos = new PVector(aiPos.x,aiPos.y);
  posAttack = new PVector(playerPos.x,playerPos.y);
  
}


//Player movement
void keyTyped() {
  
   if (key == 'd') {
      playerPos.add(playerVel.copy());
  }
   if (key == 'a') {
      playerPos.sub(playerVel.copy());
  }
   if (key == 'w') {
     PVector temp = playerVel.copy();
     temp.rotate(-PI/2);
      playerPos.add(temp);
  }
     if (key == 's') {
     PVector temp = playerVel.copy();
     temp.rotate(PI/2);
      playerPos.add(temp);
  }
}

void draw() {
  background(50,50,50);
  
  //----------------update

  //-----------------check
  
  //Check if player and enemy are colliding
  if (dist(playerPos.x, playerPos.y, aiPos.x, aiPos.y) < playerSize + playerSize) {
    //colliding!
    playerDamaged = true;
  } else {
    //not colliding!
    playerDamaged = false;
  }  
  
  //Check if player is in detection box
  if (dist(playerPos.x, playerPos.y, aiDecPos.x, aiDecPos.y) < playerSize + aiRadius) {
    //colliding!
    detected = true;
  } else {
    //not colliding!
    detected = false;
  } 
  
  //if player is touched turn differnt colour
  if(playerDamaged == true){
    playerHit = color(255,0,0);
  }else{
    playerHit = color(0,255,0);
  }
  
  
  //if detected is true move AI to player
  if(detected == true){
    
    hit = color(0,255,0,9);
    
    
    //Move AI to player
    float targetX = playerPos.x;
    float dx = targetX - aiPos.x;
    float dx2 = targetX - aiDecPos.x;
    aiPos.x += dx * easing;
    aiDecPos.x += dx2 * easing; 
      
    float targetY = playerPos.y;
    float dy = targetY - aiPos.y;
    float d2y = targetY - aiDecPos.y;
    aiPos.y += dy * easing;
    aiDecPos.y += d2y * easing;
    
    //Draw AI
    fill(0,0,255);
    ellipse(aiPos.x, aiPos.y, playerSize, playerSize);
    
    //Draw AI Hit Detector
    fill(hit);
    ellipse(aiDecPos.x, aiDecPos.y, aiRadius, aiRadius);
    
    // if not hit set defult colour
  }else if(detected == false){
    hit = color(255,0,0,9); 
  }

  //-----------Draw
  
  //Draw player
  fill(playerHit);
  ellipse(playerPos.x, playerPos.y, playerSize, playerSize);
  
  //Draw AI
  fill(0,0,255);
  ellipse(aiPos.x, aiPos.y, playerSize, playerSize);  
  
  //Draw AI Hit Dector
  fill(hit);
  ellipse(aiDecPos.x, aiDecPos.y, aiRadius, aiRadius);
}
