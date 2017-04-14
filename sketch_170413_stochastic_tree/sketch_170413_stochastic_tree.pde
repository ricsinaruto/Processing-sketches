// Stochastic Tree with angles fluctuating with Perlin noise
// Nature of Code, Chapter 8

// Perlin noise offset 
float yoff = 0;
// Random seed to control randomness while drawing the tree
int seed = 5;


void setup() {
  size(1800, 900,P2D);
  smooth();
  frameRate(60);
}

void draw() {
  background(255);
  fill(0);
  //text("Click mouse to generate a new tree", 10, height-20);

  stroke(0);
  // Start the tree from the bottom of the screen
  translate(width/2, height);
  // Move alogn through noise
  yoff += 0.001;
  randomSeed(seed);
  // Start the recursive branching!
  branch(250, 0);
}


void mousePressed() {
  // New tree starts with new noise offset and new random seed
  yoff = random(1000);
  seed = millis();
}


void branch(float h, float xoff) {
  // thickness of the branch is mapped to its length
  float sw = map(h, 2, 100, 1, 5);
  strokeWeight(sw);
  float r = map(noise(xoff+sw, 10*yoff+100), 0, 1, 0, 255);
  float g = map(noise(xoff+sw+5, 10*yoff+1000), 0, 1, 0, 255);
  float b = map(noise(xoff+sw+10, 10*yoff+10000), 0, 1, 0, 255);
  stroke(r,g,b);
  // Draw the branch
  line(0, 0, 0, -h);
  // Move along to end
  translate(0, -h);

  // Each branch will be 2/3rds the size of the previous one
  h *= 0.7f;
  
  // Move along through noise space
  xoff += 0.1;

  if (h > 4) {
    // Random number of branches
    int n = int(random(1, 5));
    for (int i = 0; i < n; i++) {
      r = map(noise(xoff, 10*yoff+0.001), 0, 1, 0, 255);
      g = map(noise(xoff, 10*yoff+0.002), 0, 1, 0, 255);
      b = map(noise(xoff, 10*yoff+0.003), 0, 1, 0, 255);
      stroke(r,g,b);
      // Here the angle is controlled by perlin noise
      // This is a totally arbitrary way to do it, try others!
      float theta = map(noise(xoff+i, yoff), 0, 1, -PI/3, PI/3);
      if (n%2==0) theta *= -1;
      
      pushMatrix();      // Save the current state of transformation (i.e. where are we now)
      rotate(theta);     // Rotate by theta
      branch(h, xoff);   // Ok, now call myself to branch again
      popMatrix();       // Whenever we get back here, we "pop" in order to restore the previous matrix state
    }
  }
}