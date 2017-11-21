void keyReleased() {
  if (img == null) {
    // Do nothing
  } else if (key=='r') {
    reloadImage();
    println("Reloading image");
  } else if (key=='s') {
    // Write to file:
    // original_name_jpeg-HHMMSS-globalsorted.png
    imgSavePath = imgPath+"-"+hour()+minute()+second()+"-globalsorted.png";
    img.save(imgSavePath);
    println("Saved image to: ", imgSavePath);
  } else if (key=='i') {
    inverse =! inverse;
    reloadImage();
    println("Sorting inversed");
  };
}

void loadFile(File selection) {
  if (selection == null) {
    // File loading dialog has been closed
    exit();
  } else {
    imgPath = selection.getAbsolutePath();
    img = loadImage(imgPath);
    surface.setSize(img.width, img.height);
    //surface.setResizable(false);
    initGui();
  };
}

void reloadImage() {
  img = loadImage(imgPath);
}

void initGui() {
  cp5 = new ControlP5(this);

  cp5.addSlider("threshold")
    .setPosition(10, 10)
    .setSize(30, img.height-20)
    .setRange(0, 255)
    .setValue(255)
    .setCaptionLabel("")
    .setColorActive(color(0, 255))
    .setColorForeground(color(0, 200))
    .setColorBackground(color(0, 100))
    .setColorValue(color(255, 0)) 
    ;
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