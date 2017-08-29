// Utility functions...


void drawTopTabs()
// draws tabs at top; called every frame.
// also draws the mode selection instructions.
{
  int i,x;
  
  fill(255,255,255);
  rect(0,0,width,20);
  textAlign(BOTTOM,LEFT);
  fill(0);
  text("1-9 to set mode",710,15);
  
  for(i=0;i<MODES;i++){
    x = i*100;
    if(mode == i) {
      fill(#BADA55);
    } else {
      fill(128,128,128);
    }
    rect(x,0,100,20);
    fill(0);
    text(TABS[i],x+10,15);
    
  }
}