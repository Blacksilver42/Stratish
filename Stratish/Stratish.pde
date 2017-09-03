// Stratenblitz ARG character maker.
// Copyright (c) Connor "Blacksilver" [REDACTED], 2017



final String[] TABS = {"Draw","Place"}; // Tab names
final int NMODES = TABS.length;         // number of modes


int mode;                               // What are we doing?
PImage glyphs[] = new PImage[6+14];     // 6 vowels + 14 consonants
int sideMenuY=0;                        // Scroll amount of the side menu in place-mode.
int[][] grid = new int[8][8];           // Characters on the placing-grid
int holding;





void setup(){
  size(900,820);
  mode=1;
  loadImgs();
  initGrid();
}

void keyPressed(){
  if(key>=int('1') && key<=int('9')){ // Don't ask how this works.
    mode = key-int('1');              // Or this. You don't want to know.
    
    if(mode >= NMODES){ // mode went out of bounds.
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
  // Danger: sideMenuY gets more negative as you scroll down.
  int e = event.getCount();
  sideMenuY -= e*10;
  sideMenuY = max(sideMenuY,MAX_SIDEMENUSCROLL);
  sideMenuY = min(sideMenuY,MIN_SIDEMENUSCROLL);
}

void mousePressed(){
  System.out.printf("Click (%d,%d)\n",mouseX,mouseY);
  if(mouseY<20){
    // We're in the tab area...
    int tab = mouseX/100;
    //println(tab);
    if(tab < TABS.length)
      mode = tab;
    else 
      return;
  }
  
  if(mouseX>width-100)
    sideMenu_click();
}


void draw(){
  //if(frameCount%60==0) sideMenu_DBG();
  //pushMatrix();
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
  //popMatrix();
  drawTopTabs();
}