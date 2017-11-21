void keyReleased() {
  if (img == null) {
    // Do nothing
  } else if (key=='r') {
    reloadImage();
  } else if (key=='s') {
    // Write to file: original_name_jpeg-HHMMSS-globalsorted.png
    imgSavePath = imgPath+"-"+hour()+minute()+second()+"-globalsorted.png";
    img.save(imgSavePath);
    println("Saved image to: ", imgSavePath);
  } else if (key=='i') {
    inverse =! inverse;
    reloadImage();
  } else if (key==TAB) {
    showHelp =! showHelp;
  };
}

void mouseWheel(MouseEvent event) {
  threshold += event.getCount() * 3;
  threshold = constrain(threshold, 0, 255);
  println("Threshold = "+threshold);
}

void loadFile(File selection) {
  if (selection == null) {
    // File loading dialog has been closed
    exit();
  } else {
    imgPath = selection.getAbsolutePath();
    img = loadImage(imgPath);
    surface.setSize(img.width, img.height);
  };
}

void reloadImage() {
  img = loadImage(imgPath);
  println("Loading "+imgPath);
}

void startupScreen() {
  background(0);
  textAlign(CENTER);
  textSize(16);
  text("(Press any key to) load an image", width*0.5, height*0.2);
  text("github.com/wjslager", width*0.5, height*0.3);
  text("controls:", width*0.5, height*0.5);
  text("'r' = reload image", width*0.5, height*0.6);
  text("'s' = save image as png", width*0.5, height*0.7);
  text("'i' = inverse sorting", width*0.5, height*0.8);
}

void gui(boolean mode) {
  textSize(16);
  textAlign(CENTER);
  if (mode) {
    text("dikke friet", width*0.5, height*0.5);
  } else {
    text("pasta", width*0.5, height*0.5);
  };
};