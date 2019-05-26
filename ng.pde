import ddf.minim.*;
Minim minim;
AudioPlayer screamPlayer;




PFont font;

PImage bg1,bg2,bg3,bg4,bg5,house,bg6,scream;
PImage startNormal, startHovered;
PImage interview, distance,view,caution,red;
PImage people01,people02,people03;
PImage mcRun;

String surprise = "!";
String murmur = "\\!#@$#%^$/ ";

float [] bgX;
float speed=2;
float timer,mcMove=0,jump=0;
float count=0;
float screamX = -200;
int gameTimer;

int maxDistance=40,remainDistance;
int viewPoint = 100;
String distanceString, viewString;

final int GAME_START = 0, GAME_RUN = 1, GAME_TEACH = 2, GAME_WIN = 3;
int gameState = 0;


final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 400;
final int START_BUTTON_Y = 360;

boolean upState = false;
boolean downState = false;


int bgWSize=960,bgHSize=540;

void setup() {
  
  minim = new Minim(this);
  screamPlayer = minim.loadFile("sound/scream.wav");
  
  
  size(960, 540, P2D);
  bg1 = loadImage("img/backGround_01.png");
  bg2 = loadImage("img/backGround_02.png");
  bg3 = loadImage("img/backGround_03.png");
  bg4 = loadImage("img/backGround_04.png");
  bg5 = loadImage("img/backGround_05.png");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  mcRun = loadImage("img/mc-01.png");
  house = loadImage("img/house.png");
  bg6 = loadImage("img/backGround_06.png");
  people01 = loadImage("img/people1_2.png");
  people02 = loadImage("img/people2_3.PNG");
  people03 = loadImage("img/people3_2.png");
  scream = loadImage("img/scream.PNG");
  interview = loadImage("img/interview.png");
  distance = loadImage("img/distance.png");
  view = loadImage("img/copper 1.png");
  caution = loadImage("img/caution.png");
  red = loadImage("img/red 0.png");
  
  font = createFont("font/font.ttf", 56);
  textFont(font);
  
  bgX = new float[5];
  for(int i=0 ; i<=4 ; i++ ){
    bgX[i] = bgWSize*i;
  }
  
  remainDistance = maxDistance;
  
}

void draw() {
  
  switch (gameState) {

    case GAME_START: // Start Screen
    
    background(0);
    rect(320,180,320,160);
    
    if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }

    break;
    
    case GAME_TEACH: // Teaching
    
    
    //First scream
    gameTimer++;
    
    image(bg6, bgX[0], 0);
    image(house,250, 40);
    image(people01, 40, 358+62+jump);
    image(people02, 200, 358+jump);
    image(people03, 100, 358-62+jump);
    fill(30,80);
    rect(0,0,width,height);
    if(gameTimer>3*60){
      screamPlayer.play();
      //image(scream,screamX,0);
      count++;
      if(count<10)jump-=3;
      if(count>=10)jump+=3;
      if(count>=20)jump=0;

      people01 = loadImage("img/people1_3.PNG");
      people03 = loadImage("img/people3_3.PNG");      
    }
    if(gameTimer>5*60){
           screamX = -1100;
           surprise = "";
    }
    if(gameTimer>5.5*60){
      people02 = loadImage("img/people2_1.png");

    }


    break;
    
    
    case GAME_RUN: //Game Run
    

    
      //backround
    image(bg1, bgX[0], 0);
    image(bg2, bgX[1], 0);
    image(bg3, bgX[2], 0);
    image(bg4, bgX[3], 0);
    image(bg5, bgX[4], 0);
    
     noStroke();
     fill(255,180);
     rect(5,15,950,80);
     image(interview,10, -10);
     image(caution,390, 19);
     image(red,380, 11);
     image(distance,500, 10);
     image(view,650, 0);
     
     
     fill(0);
     distanceString = str(remainDistance) + "/" + str(maxDistance);
     viewString = str(viewPoint);
     textSize(30);
     text(distanceString,580,65);
     text(viewString,900,63);
     
     
    
    
    for(int i=0 ; i<=4 ; i++){
      bgX[i]-=speed;
      if(bgX[i]<=width*-1)bgX[i]=bgWSize*4-1;
    }
    
    //maincharacter
    image(mcRun, 40, 358+mcMove);
    if(timer==10)mcRun = loadImage("img/mc-02.png");
    if(timer==20)mcRun = loadImage("img/mc-03.png");
    if(timer==30)mcRun = loadImage("img/mc-04.png");
    if(timer==40)mcRun = loadImage("img/mc-05.png");
    if(timer==50)mcRun = loadImage("img/mc-06.png");
    if(timer==60)mcRun = loadImage("img/mc-07.png");
    if(timer==70)mcRun = loadImage("img/mc-08.png");
    if(timer>=80){
      mcRun = loadImage("img/mc-01.png");
      timer=0;
      remainDistance--;
    }
      timer+=speed/2;
      
    //maincharacter control
      if(mcMove>-62){
        if(upState)mcMove-=62;upState = false;
      }
      if(mcMove<62){
        if(downState)mcMove+=62;downState = false;
      }

    break;
    
  }
  




}





void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
      upState = true;
      break;
      case DOWN:
      downState = true;
      break;
      case RIGHT:
      speed=10;
      break;
    }
  }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case UP:
      upState = false;
      break;
      
      case DOWN:
      downState = false;
      break;
      
      case RIGHT:
      speed=2;
      break;
    }
  }
}
