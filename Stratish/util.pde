// Utility functions...


void drawTopTabs()
/* draws tabs at top; called every frame.
 */
{
  int i,x;
  
  fill(255,255,255);
  rect(0,0,width,20);
  fill(0);
  textAlign(RIGHT,BOTTOM);
  
  textAlign(LEFT,BOTTOM);
  for(i=0;i<NMODES;i++){
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
/* Load in the glyphs. 
 * They're named "Bold_01" through "Bold_06"; "Thin_01" through "Thin_14",
 * so we can be cheeky and use sprintf.
 */
{
  int i;
  for(i=1;i<=6;i++){
    glyphs[i-1] = loadImage(String.format("Bold_%02d.png",i));
  }
  for(i=1;i<=14;i++){
    glyphs[i+5] = loadImage(String.format("Thin_%02d.png",i));
  }  
}