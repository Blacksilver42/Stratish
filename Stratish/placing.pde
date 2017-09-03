final int MAX_SIDEMENUSCROLL = -(glyphs.length-6)*120+80; // Max scroll of the side menu
final int MIN_SIDEMENUSCROLL = 0;                         // Min



void M_placing()
/* Mode's main function hence starts with `M_`
 * Called every frame if mode==1
 */
{
  drawSideMenu();
  drawGrid();
}


void drawSideMenu()
/* Draws the side menu
 * Called by M_placing every frame while mode==0.
 */
{
  pushMatrix();
  
  fill(255);
  rect(width-100, 20, 100, height-20);
  translate(width-100,sideMenuY+20);
  int i;
  for(i=0;i<glyphs.length;i++){
    image(glyphs[i],0,i*120,100,100);
  }
  
  popMatrix();
}

void sideMenu_DBG()
/* Debug function for the side menu.
 * Not used.
 */
{
  System.out.printf("sideMenuY = %d (%d ~ %d)\n",sideMenuY,MAX_SIDEMENUSCROLL,MIN_SIDEMENUSCROLL);
}

void drawGrid()
/* Draw the big grid in the center of the screen
 * Called every frame while mode==1.
 */
{
  for(int i=1;i<8;i++){
    line(i*100,20,i*100,height); // Vertical
    line(0,i*100+20,width-100,i*100+19); // Horizontal
  }
}

void sideMenu_click()
/* Handles clicks in the side menu.
 * Called by mousePressed if mouseX > (width-100)
 */
{
  pushMatrix();
  translate(width-100,sideMenuY);
  int x,y;
  x = (mouseX - width) + 100;
  y = mouseY - 20;
  
  System.out.printf("Converted mouse click (%d,%d)\n",x,y);
  popMatrix();
}

void initGrid(){
  
}