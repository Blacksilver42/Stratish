import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Stratish extends PApplet {

// Stratenblitz ARG character maker.
// Copyright (c) Connor "Blacksilver" [REDACTED], 2017



final String[] TABS = {"Draw", "Place"}; // Tab names
final int NMODES = TABS.length;         // number of modes


int mode;                               // What are we doing?
PImage glyphs[] = new PImage[6+14];     // 6 vowels + 14 consonants
int sideMenuY=0;                        // Scroll amount of the side menu in place-mode.
int[][] grid = new int[8][8];           // Characters on the placing-grid
int doExport = 0;




public void setup() {
  
  mode=1;
  loadImgs();
  initGrid();
}

public void keyPressed() {
  if (key>=PApplet.parseInt('1') && key<=PApplet.parseInt('9')) { // Don't ask how this works.
    mode = key-PApplet.parseInt('1');              // Or this. You don't want to know.

    if (mode >= NMODES) { // mode went out of bounds.
      mode=0;
      println("No.");
    } else {
      System.out.printf("mode %d - %s\n", mode, TABS[mode]);
    }
  }

  if (key == 'i') sideMenuY+=5;
  if (key == 'k') sideMenuY+=5;
  if (key == 'e') doExport = 1;
}

public void mouseWheel(MouseEvent event) {
  // Danger: sideMenuY gets more negative as you scroll down.
  int e = event.getCount();
  sideMenuY -= e*10;
  sideMenuY = max(sideMenuY, MAX_SIDEMENUSCROLL);
  sideMenuY = min(sideMenuY, MIN_SIDEMENUSCROLL);
}

public void mousePressed() {
  System.out.printf("Click (%d,%d)\n", mouseX, mouseY);
  if (mouseY<20) {
    tab_click();
    return;
  }

  if (mouseX>width-100) {
    sideMenu_click();
    return;
  }

  if (mode==1) { // Placing
    placeOnGrid();
  }
}


public void draw() {
  clear();
  background(128);
  
  // Are we exporting?
  if(doExport == 1){
    export();
    doExport = 0;
    return;
  }
  
  switch(mode) {
  case 0:
    M_drawing();
    break;
  case 1:
    M_placing();
    break;
  default:
    textAlign(CENTER, CENTER);
    text("Invalid mode!", width/2, height/2);
  }
  
  // We do this last so it's on top of everything else.
  drawTopTabs();
}
// Everything and anything click-related
// (except mousePressed, it has to be in the main file)

public void tab_click() {
  // We're in the tab area...
  int tab = mouseX/100;
  //println(tab);
  if (tab < TABS.length)
    mode = tab;
}

public void sideMenu_click()
/* Handles clicks in the side menu.
 * Called by mousePressed if mouseX > (width-100)
 */
{
  // If you're already holding something, drop it and return.
  if(holding >= 0){
    holding = -1;
    return;
  }
  
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

public void drawHolding() {
  //Draw the glyph you're holding (if any)
  if (holding>=0) {
    image(glyphs[holding], mouseX, mouseY);
  }
}

public void placeOnGrid(){
  int x,y;
  // We don't need to double-check that the mouse is on the grid area;
  // mousePressed does that for us.
  
  x = mouseX/100;
  y = (mouseY-20)/100;
  
  grid[x][y] = holding;
  holding = -1;
}
// functions for the drawing mode (0)


public void M_drawing() {
  textAlign(CENTER, CENTER);
  text("Working on placing with existing letters first.\nPress 2.", height/2, width/2);
}
final int MAX_SIDEMENUSCROLL = -(glyphs.length-6)*120+80; // Max scroll of the side menu
final int MIN_SIDEMENUSCROLL = 0;                         // Min
int holding = -1; // what Glyph are we holding?


public void M_placing()
/* Mode's main function hence starts with `M_`
 * Called every frame if mode==1
 */
{
  drawSideMenu();
  drawGrid();
  drawHolding();
}


public void drawSideMenu()
/* Draws the side menu
 * Called by M_placing every frame while mode==0.
 */
{
  pushMatrix();

  fill(255);
  rect(width-100, 20, 100, height-20);
  translate(width-100, sideMenuY+20);
  int i;
  for (i=0; i<glyphs.length; i++) {
    image(glyphs[i], 0, i*120, 100, 100);
  }

  popMatrix();
}

public void drawGrid()
/* Wrapper for drawGridLines then drawGridGlyphs
 * called every frame while mode==1.
 */
{
  drawGridLines();
  drawGridGlyphs();
}

public void drawGridLines()
/* Draw the lines for big grid in the center of the screen.
 * Called every frame while mode==1.
 */
{
  for (int i=1; i<8; i++) {
    line(i*100, 20, i*100, height); // Vertical
    line(0, i*100+20, width-100, i*100+19); // Horizontal
  }
}

public void drawGridGlyphs()
/* Draw the glyphs on the grid.
 * Called by drawGrid.
 */
{
  pushMatrix();
  translate(0, 20);

  int i, j;
  for (i=0; i<8; i++) {
    for (j=0; j<8; j++) {
      if (grid[i][j] >= 0) {
        image(glyphs[grid[i][j]], i*100, j*100);
      }
    }
  }

  popMatrix();
}

public void initGrid()
/* Initializes the entire grid array to -1.
 * Called by setup.
 */
{
  int i, j;
  for (i=0; i<8; i++)
    for (j=0; j<8; j++)
      grid[i][j] = -1;
}
// Utility functions...


public void drawTopTabs()
/* draws tabs at top; called every frame.
 */
{
  int i, x;

  fill(255, 255, 255);
  rect(0, 0, width, 20);
  fill(0);
  textAlign(RIGHT, BOTTOM);

  textAlign(LEFT, BOTTOM);
  for (i=0; i<NMODES; i++) {
    x = i*100;
    if (mode == i) {
      fill(0xffBADA55);
    } else {
      fill(128, 128, 128);
    }
    rect(x, 0, 100, 20);
    fill(0);
    text(TABS[i], x+10, 15);
  }
  
  
  text(String.format("Holding glyph %d. Press [e] to export.",holding),300,15);
  
}


public void loadImgs()
/* Load in the glyphs. 
 * They're named "Bold_01" through "Bold_06"; "Thin_01" through "Thin_14",
 * so we can be cheeky and use sprintf.
 */
{
  int i;
  for (i=1; i<=6; i++) {
    glyphs[i-1] = loadImage(String.format("Bold_%02d.png", i));
  }
  for (i=1; i<=14; i++) {
    glyphs[i+5] = loadImage(String.format("Thin_%02d.png", i));
  }
}

public void export(){
  println("======= Exporting... =======");
  println("> Setting background to white...");
  background(255);
  println("> Drawing glyphs...");
  int i,j,n=0;
  
  for(i=0;i<8;i++){
    for(j=0;j<8;j++){
      if(grid[i][j] >=0){
        image(glyphs[grid[i][j]],i*100,j*100);
        n++;
      }
    }
  }
  println("> Drew",n,"glyphs.");
  println("> Saving...");
  save("Export.png");
}
  public void settings() {  size(900, 820); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Stratish" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
