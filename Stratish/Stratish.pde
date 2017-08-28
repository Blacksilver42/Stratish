// Stratenblitz ARG character maker.

int mode; 
final String[] TABS = {"Draw","Place","test"};

final int MODES = 3; // number of modes

void setup(){
  size(800,820);
  mode=0;
}

void keyPressed(){
  if(key>=int('1') && key<=int('9')){ // Don't ask how this works.
    mode = key-int('1');
    if(mode >= MODES){ // mode went out of bounds.
      mode=0;
      println("No.");
    } else {
      System.out.printf("mode %d - %s\n",mode,TABS[mode]);
    }
  }
}


void draw(){
  clear();
  background(128);
  drawTopTabs();
}