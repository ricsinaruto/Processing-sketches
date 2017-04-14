float time=0;
float theta;
void setup() {
  size(1800, 900,P2D);
  //newTree();
  frameRate(60);
}

void draw() {
  background(255);
  theta = map(mouseX,0,width,0,PI);
  time+=0.001;
  
  //pushMatrix();
  // Start the tree from the bottom of the screen
  translate(width/2, height);
  stroke(0);
  // Start the recursive branching!
  branch(200);
  //popMatrix();
}

//void mousePressed() {
  //newTree();
  //redraw();
//}

void newTree() {
  background(255);
  fill(0);
  text("Click mouse to generate a new tree", 10, height-10);

  stroke(0);
  pushMatrix();
  // Start the tree from the bottom of the screen
  translate(width/2, height);
  // Start the recursive branching!
  branch(300);
  popMatrix();
}



void branch(float h) {
  // thickness of the branch is mapped to its length
  float sw = map(h, 2, 200, 1, 20);
  strokeWeight(sw);
  // Draw the actual branch
  line(0, 0, 0, -h);
  // Move along to end
  translate(0, -h);

  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;

  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    // A random number of branches
    //int n = int(random(1, 5));
    //for (int i = 0; i < 4; i++) {
      float wind=map(noise(time),0,1,-PI/6,PI/6);
      pushMatrix();      // Save the current state of transformation (i.e. where are we now)
      rotate(theta-wind);     // Rotate by theta
      branch(h);         // Ok, now call myself to branch again
      popMatrix();
      
      pushMatrix();      // Save the current state of transformation (i.e. where are we now)
      rotate(-theta-wind);     // Rotate by theta
      branch(h);         // Ok, now call myself to branch again
      popMatrix();       // Whenever we get back here, we "pop" in order to restore the previous matrix state
    //}
  }
}