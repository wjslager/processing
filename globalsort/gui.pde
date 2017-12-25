void startupScreen() {
  background(0);
  textAlign(CENTER);
  textSize(16);
  text("(Press any key to) load an image", width*0.5, height*0.2);
  text("github.com/wjslager", width*0.5, height*0.3);
  text("Hide help: TAB", width*0.5, height*0.5);
  text("'r' = reload image", width*0.5, height*0.6);
  text("'s' = save image as png", width*0.5, height*0.7);
  text("'i' = inverse sorting", width*0.5, height*0.8);
}

void gui() {
  textAlign(RIGHT, TOP);
  textSize(12);

  noStroke();
  fill(0, 150);
  rect(width-245, 5, 240, 100);
  fill(255);
  text("[wheel] / [up] / [down] amount: "+threshold, width-10, 10);
  text("[i] inversed sorting: "+inverse, width-10, 25);
  text("[1] / [2] / [3] sorting mode: "+sortMode, width-10, 40);
  text("[s] save as png", width-10, 55);
  text("[TAB] hide this menu", width-10, 70);
  
  textAlign(LEFT, BOTTOM);
  fill(200);
  text("github.com/wjslager", width-240, 100);
}