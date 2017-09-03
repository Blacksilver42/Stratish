// Everything and anything click-related
// (except mousePressed, it has to be in the main file)

void tab_click() {
  // We're in the tab area...
  int tab = mouseX/100;
  //println(tab);
  if (tab < TABS.length)
    mode = tab;
}

void sideMenu_click()
/* Handles clicks in the side menu.
 * Called by mousePressed if mouseX > (width-100)
 */
{
  pushMatrix();
  translate(width-100, sideMenuY);

  //Convert the mouse click to make life easier:
  int x, y;
  x = (mouseX - width) + 100;
  y = mouseY - 20 - sideMenuY;

  // Now, what did you click on?
  holding = y/120;


  System.out.printf("Converted mouse click (%d,%d). Glyph %d\n", x, y, holding);
  popMatrix();
}

void drawHolding() {
  //Draw the glyph you're holding (if any)
  if (holding>=0) {
    image(glyphs[holding], mouseX, mouseY);
  }
}

void placeOnGrid(){
  int x,y;
  // We don't need to double-check that the mouse is on the grid area;
  // mousePressed does that for us.
  
  x = mouseX/100;
  y = (mouseY+20)/100;
  
  grid[x][y] = holding;
  holding = -1;
}