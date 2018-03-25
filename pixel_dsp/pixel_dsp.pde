// Saved frames will be stored here
String imageFolder = "docs";

IIR pixIIR = new IIR(0.5);

/* ==== ==== SETUP ==== ==== */

void setup()
{
  size(800, 800);
  //size(1920, 1080);
  background(0);
}

/* ==== ==== DRAW ==== ==== */

void draw()
{
  // Pixel manipulation
  loadPixels();

  if (mousePressed && mouseInWindow()) {
    if (mouseButton == LEFT)
    {
      pixels[mouseY * width + mouseX] = color(255);
    } else 
    if (mouseButton == RIGHT)
    {
      pixels[mouseY * width + mouseX] = pixels[mouseY * width + mouseX] << 2;
    } else 
    if (mouseButton == CENTER)
    {
      int x = abs(int(random(-20, 20) + mouseX)) % width;
      int y = abs(int(random(-20, 20) + mouseY)) % height;
      pixels[y * width + x] = pixels[mouseY * width + mouseX] << 10;
    }
  }

  // Process using a simple IIR
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = int(pixIIR.filter(pixels[i]));
  }
  
  // Delay effect
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = int(pixels[i] * 0.9999) + int(0.0001 * pixels [constrain(i-10000, 0, pixels.length)]);
  }
  updatePixels();
}

/* ==== ==== INTERACTION ==== ==== */

void keyPressed() {
  switch (key) 
  {
  case ' ':
    //String filename = str(year()) + "-" + str(month()) + "-" + str(day()) + "-" + str(hour()) + "-" + str(millis()) + "-" + randomString(5);
    String filename = str(hour()) + str(minute()) + "-" + str(millis()) + "-" + randomString(5);
    saveFrame(imageFolder + "/" + filename + ".png");
    println("Frame saved as " + filename + ".png");
    break;
  }
}