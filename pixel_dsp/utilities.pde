// Check if the mouse is within the window
boolean mouseInWindow()
{
  if (mouseX >= 0 && mouseX < width && mouseY >= 0 && mouseY < height) {
    return true;
  }
  return false;
}

// Checks both lower and uppercase
boolean isKey(char keyIn)
{
  if (Character.toLowerCase(key) == keyIn) {
    return true;
  }
  return false;
}

// Returns random string to make filenames more recognizable 
String randomString(int stringLength)
{
  String output = "";
  for (int i = 0; i < stringLength; i++) {
    output += char(int(random(65, 91)) + 32 * int(random(2)));
  }
  return output;
}