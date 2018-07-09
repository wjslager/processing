void keyPressed() {
  /* Keyboard controls:
   
   space  save frame
   L      start/stop continious drawing
   V      insert a webcam frame
   X      insert random noise
   C      clear screen (to black)
   
   */
  switch (key) 
  {
  case ' ':
    //String filename = str(year()) + "-" + str(month()) + "-" + str(day()) + "-" + str(hour()) + "-" + str(millis()) + "-" + randomString(5);
    String filename = str(hour()) + str(minute()) + "-" + str(millis()) + "-" + randomString(5);
    saveFrame(imageFolder + "/" + filename + ".png");
    println("Frame saved as " + filename + ".png");
    break;
  case 'l':
    looping = !looping;
    if (looping) {
      noLoop();
    } else {
      loop();
    }
    break;
  case 'f':
    draw();
    break;
  case 'v':
    captureFrame = true;
    break;
  case 'x':
    randomFrame = true;
    break;
  case 'c':
    clearFrame = true;
    break;
  }
}