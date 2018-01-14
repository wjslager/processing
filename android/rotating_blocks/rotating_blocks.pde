Block[] blocks;

/* Are all android devices 16:9?
 If not, this part should be replaced by some code
 which retrieves the aspect ratio
 Having the correct aspect ratio set makes sure all blocks are square
 */
int xBlocks = 9, yBlocks = 16;
int numBlocks = xBlocks * yBlocks;
float blockSizeX, blockSizeY;
float blockSizeFactor = 1;
Easing bsEase = new Easing(0.1);
Easing fillEase = new Easing(0.1);

int currentBlock = 0;

void setup() 
{
  fullScreen();

  blockSizeX = width / xBlocks;
  blockSizeY = height / yBlocks;
  blocks = new Block[numBlocks];
  for (int i=0; i<numBlocks; i++) {
    blocks[i] = new Block(i);
  }

  rectMode(CENTER);
  noFill();
  noStroke();

  fill(255, 100);

  background(0);
}

void draw()
{
  background(0, 0, 20);

  // Rotate only one block per frame
  blocks[currentBlock].rotateBlock();
  currentBlock = (currentBlock + 1) % numBlocks;

  // Update/draw all blocks
  for (int i=0; i<numBlocks; i++) {
    blocks[i].update();
  }

  if (touches.length > 0) {
    blockSizeFactor = bsEase.ease(1.5);
    fill(255, fillEase.ease(50));
  } else {
    blockSizeFactor = bsEase.ease(1);
    fill(255, fillEase.ease(100));
  }
}