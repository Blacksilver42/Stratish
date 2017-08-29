// Stratenblitz ARG character maker.

int mode; 
final String[] TABS = {"Draw","Place"};

final int MODES = TABS.length; // number of modes

void setup(){
  size(900,820);
  mode=1;
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
}


void draw(){
  clear();
  background(128);
  drawTopTabs();
  switch(mode){
    case 0:
      M_drawing();
      break;
    case 1:
      M_placing();
      break;
    default:
      textAlign(CENTER,CENTER);
      text("This mode isn't.",width/2,height/2);
  }
}