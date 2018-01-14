class Block
{ 
  float xPos, yPos, targetRotation, dRotation, rotation;
  int id;

  Block(int i)
  {
    // The id is retrieved from the for-loop which constructs each instance
    // This was all cubes inside of the for-loop will be spread out nicely over the screen
    id = i;
    xPos = ((id % xBlocks) * blockSizeX) + (blockSizeX * 0.5);
    yPos = ((id / xBlocks) * blockSizeY) + (blockSizeY * 0.5);
  }

  void update()
  {
    // Smooth the rotation
    dRotation = targetRotation - rotation;
    rotation += dRotation * 0.1;

    // Draw the block
    pushMatrix();
    translate(xPos, yPos);
    rotate(rotation);
    rect(0, 0, blockSizeX * blockSizeFactor * 0.92, blockSizeY * blockSizeFactor * 0.92);
    popMatrix();
  }

  void rotateBlock()
  {
    // Rotate by PI/16
    targetRotation += PI * 0.0625;
  }
} 