final int START=0;
final int PLAY=1;
final int END=2;

PImage start1;
PImage start2;
PImage end1;
PImage end2;
PImage bg1;
PImage bg2;
PImage enemy;
PImage fighter;
PImage hp;
PImage treasure;

int Up,Down,Left,Right;
int bgX=0;
int fighterX,fighterY;
int treasureX,treasureY;
float enemyX,enemyY;
int hpX;
int speed=4;
int enemySpeed=4;
int state;

void setup () {
  size(640, 480) ;
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png"); 
  
  state=START;
}

void draw() {
  
switch(state){  
  
  case START:
    if(mouseX>=205&&mouseX<=455&&mouseY>=375&&mouseY<=415){
    image(start1,0,0);
    if(mousePressed){
//reset treasure position      
      treasureX=floor(random(0,600));
      treasureY=floor(random(0,440));
//reset enemy position      
      enemyX=-60;
      enemyY=floor(random(0,430));
//reset fighter position      
      fighterX=520;
      fighterY=240;
      hpX=floor(random(21,100));
      state=PLAY;
      }
    }else
    image(start2,0,0);
  break;
  
  
  case PLAY:  
    background(0);
    image(bg1,bgX%1280-640,0);
    image(bg2,(bgX+640)%1280-640,0);
    
    image(fighter,fighterX,fighterY);
    image(treasure,treasureX,treasureY);
    image(enemy,enemyX,enemyY);
  //hp
    fill(#ff0000);
    stroke(#ff0000);
    rect(20,18,hpX*2,20);
    image(hp,15,15);
    
    fill(#ffffff);
    textAlign(RIGHT, BOTTOM);
    text(hpX+" /100",224,45);
    bgX++;
  
  //judge treasure eaten
    if(fighterX-treasureX<=40&&fighterX-treasureX>=-50&&fighterY-treasureY<=40&&fighterY-treasureY>=-50){
      treasureX=floor(random(0,600));
      treasureY=floor(random(0,440));
      hpX=hpX+10;
      if(hpX>=100)
        hpX=100;
    }
  //judge enemy hit
    if(fighterX-enemyX<=55&&fighterX-enemyX>=-50&&fighterY-enemyY<=55&&fighterY-enemyY>=-50){
      enemyX=-60;
      enemyY=floor(random(0,430));
      hpX=hpX-20;
      if(hpX<=0){
        hpX=0;
        state=END;
      }
    }
  //enemy move
    enemyX=(60+(enemyX+enemySpeed))%700-60; 
    enemyY=enemyY-(enemyY-fighterY)*(random(2,4)/150);
  //enemy loop 
    if(enemyX>=638)
      enemyY=floor(random(0,430));
  //fighter move    
    fighterX=fighterX-int(fighterX>0)*Left*speed+int(fighterX<590)*Right*speed;
    fighterY=fighterY-int(fighterY>0)*Up*speed+int(fighterY<430)*Down*speed;
  break;
  
  
  case END:
  if(mouseX>=205&&mouseX<=436&&mouseY>=305&&mouseY<=350){
    image(end1,0,0);
    if(mousePressed)
      state=START;
    }else
      image(end2,0,0);
  break;
  }
}
void keyPressed(){
if(key==CODED){
  
    switch(keyCode){
    case UP:
    Up=1;
    break;
    case DOWN:
    Down=1;
    break;
    case LEFT:
    Left=1;
    break;
    case RIGHT:
    Right=1;
    break;
    }
  
}
}
void keyReleased(){
if(key==CODED){
  switch(keyCode){
  case UP:
  Up=0;
  break;
  case DOWN:
  Down=0;
  break;
  case LEFT:
  Left=0;
  break;
  case RIGHT:
  Right=0;
  break;
  }
}
}
