void loadFile(File selection) {
  if (selection == null) {
    // File loading dialog has been closed
    exit();
  } else {
    imgPath = selection.getAbsolutePath();
    img = loadImage(imgPath);
    surface.setSize(img.width, img.height);
  }
}

void reloadImage() {
  img = loadImage(imgPath);
  global_sort(threshold, inverse, sortMode);
}

void keyPressed() {
  if (key==CODED && keyCode==SHIFT) {                // Shift
    factor = 1;
  } else if (key==CODED && keyCode==UP) {            // Arrow up
    threshold += 1 * factor;
    // Reapply fx
    reloadImage();
  } else if (key==CODED && keyCode==DOWN) {          // Arrow down
    threshold -= 1 * factor;
    // Reapply fx
    reloadImage();
  }

  threshold = constrain(threshold, 0, 255);
}

void keyReleased() {
  if (img == null) {                                 // Do not respond to the keyboard if no image has been loaded yet
    // Do nothing
  } else if (key==CODED && keyCode==SHIFT) {         // Shift
    factor = 10;
  } else if (key=='r') {                             // R
    // Reload the image for whatever purposes
    reloadImage();
  } else if (key=='s') {                             // S
    // Write to file and print the location: 
    // original_name_jpeg-HHMMSS-globalsorted.png
    imgSavePath = imgPath+"-"+hour()+minute()+second()+"-globalsorted.png";
    img.save(imgSavePath);
    println("Saved image to: ", imgSavePath);
  } else if (key=='i') {                             // I
    // Inverse the sorting
    inverse =! inverse;
    // Reapply fx
    reloadImage();
  } else if (key==TAB) {                             // TAB
    // Show or hide the help menu
    showHelp =! showHelp;
  } else if (int(key) >= 49 && int(key) <= 51) {     // 1 / 2 / 3
    // Change the sort mode using the 1, 2 and 3 keys
    sortMode = int(key) - 48;
    // Reapply fx
    reloadImage();
  }
}

void mouseWheel(MouseEvent event) {
  // Increase or decrease the threshold value
  threshold += -event.getCount() * factor;
  threshold = constrain(threshold, 0, 255);
  // Reapply fx
  reloadImage();
}