void keyPressed() {
  if (key==CODED && keyCode==SHIFT) {
    factor = 1;
  } else if (key==CODED && keyCode==UP) {
    threshold += 1 * factor;
  } else if (key==CODED && keyCode==DOWN) {
    threshold -= 1 * factor;
  };
  
  threshold = constrain(threshold, 0, 255);
}

void keyReleased() {
  if (img == null) {
    // Do nothing
  } else if (key==CODED && keyCode==SHIFT) {
    factor = 10;
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
    global_sort(threshold, inverse, sortMode);
  } else if (key==TAB) {
    showHelp =! showHelp;
  } else if (int(key) >= 49 && int(key) <= 51) {
    sortMode = int(key) - 48;
    reloadImage();
    global_sort(threshold, inverse, sortMode);
  };
}

void mouseWheel(MouseEvent event) {
  threshold += -event.getCount() * factor;
  threshold = constrain(threshold, 0, 255);
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
  global_sort(threshold, inverse, sortMode);
}