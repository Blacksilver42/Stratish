void M_placing() {
  drawSideMenu();
  drawGrid();
}

void drawSideMenu() {
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

void sideMenu_DBG(){
  System.out.printf("sideMenuY = %d (%d ~ %d)\n",sideMenuY,MAX_SIDEMENUSCROLL,MIN_SIDEMENUSCROLL);
}

void drawGrid(){
  stroke(2);
  
  for(int i=1;i<8;i++){
    line(i*100,20,i*100,height); // Vertical
    line(0,i*100+20,width-100,i*100+19); // Horizontal
  }
}

void sideMenu_click(){
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