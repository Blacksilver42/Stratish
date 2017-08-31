// Stratenblitz ARG character maker.
// Copyright (c) Connor "Blacksilver" [REDACTED], 2017


int mode; 
final String[] TABS = {"Draw","Place"};
final int MODES = TABS.length; // number of modes
PImage glyphs[] = new PImage[6+14];
int sideMenuY=0;
final int MAX_SIDEMENUSCROLL = -(glyphs.length-6)*120+80;
final int MIN_SIDEMENUSCROLL = 0;



void setup(){
  size(900,820);
  mode=1;
  loadImgs();
}

void keyPressed(){
  if(key>=int('1') && key<=int('9')){ // Don't ask how this works.
    mode = key-int('1');              // Or this. You don't want to know.
    
    if(mode >= MODES){ // mode went out of bounds.
      mode=0;
      println("No.");
    } else {
      System.out.printf("mode %d - %s\n",mode,TABS[mode]);
    }
  }
  
  if(key == 'i') sideMenuY+=5;
  if(key == 'k') sideMenuY+=5;
}

void mouseWheel(MouseEvent event){
  int e = event.getCount();
  sideMenuY -= e*10;
  sideMenuY = max(sideMenuY,MAX_SIDEMENUSCROLL);
  sideMenuY = min(sideMenuY,MIN_SIDEMENUSCROLL);
}


void draw(){
  //if(frameCount%60==0) sideMenu_DBG();
  
  clear();
  background(128);
  switch(mode){
    case 0:
      M_drawing();
      break;
    case 1:
      M_placing();
      break;
    default:
      textAlign(CENTER,CENTER);
      text("Invalid mode!",width/2,height/2);
  }
  drawTopTabs();
}