// Utility functions...


void drawTopTabs()
// draws tabs at top; called every frame.
// also draws the mode selection instructions.
{
  int i,x;
  
  fill(255,255,255);
  rect(0,0,width,20);
  fill(0);
  textAlign(RIGHT,BOTTOM);
  text("1-9 to set mode",width-10,15);
  
  textAlign(LEFT,BOTTOM);
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


void loadImgs()
/* Load in the bold characters. 
 * They're named "Bold_01" through "Bold_06", so we can be cheeky and use sprintf.
 */
{
  int i;
  for(i=1;i<=6;i++){
    glyphs[i-1] = loadImage(String.format("Bold_%02d.png",i));
  }
}