
int lifetime;  // How long should each generation live

Population population;  // Population

int lifecycle;          // Timer for cycle of generation
int recordtime;         // Fastest time to target

Obstacle target;        // Target position

//int diam = 24;          // Size of target

ArrayList<Obstacle> obstacles;  //an array list to keep track of all the obstacles!

void setup() {
  size(800, 500,P2D);
  frameRate(1000);
  // The number of cycles we will allow a generation to live
  lifetime = height*2;
  
  // Initialize variables
  lifecycle = 0;
  recordtime = lifetime;
  
  target = new Obstacle(width/2-12, 24, 24, 24);

  // Create a population with a mutation rate, and population max
  float mutationRate = 0.01;
  population = new Population(mutationRate, 200);

  // Create the obstacle course  
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width/2-100, height/2, 100, 10));
  obstacles.add(new Obstacle(width/2-100, height/2-100, 100, 10));
  obstacles.add(new Obstacle(width/2-110, height/2-190, 10, 100));
  obstacles.add(new Obstacle(width/2-210, height/2-190, 10, 100));
  obstacles.add(new Obstacle(width/2-210, height/2-90, 10, 100));
  obstacles.add(new Obstacle(width/2-200, height/2, 100, 10));
  obstacles.add(new Obstacle(width/2-210, height/2-200, 110, 10));
}

void draw() {
  background(255);

  // Draw the start and target positions
  target.display();


  // If the generation hasn't ended yet
  if (lifecycle < lifetime) {
    population.live(obstacles);
    if ((population.targetReached()) && (lifecycle < recordtime)) {
      recordtime = lifecycle;
    }
    lifecycle++;
    // Otherwise a new generation
  } 
  else {
    lifecycle = 0;
    population.fitness();
    population.selection();
    population.reproduction();
  }

  // Draw the obstacles
  for (Obstacle obs : obstacles) {
    obs.display();
  }

  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifecycle), 10, 36);
  text("Record cycles: " + recordtime, 10, 54);
  
  
}

// Move the target if the mouse is pressed
// System will adapt to new target
void mousePressed() {
  target.position.x = mouseX;
  target.position.y = mouseY;
  recordtime = lifetime;
}