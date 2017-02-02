class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float r;
  float maxspeed;
  float maxforce;
  float alfa;
  int re,bl,gr;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 10.0;
    
//Arbitrary values for maxspeed and force; try varying these!
    maxspeed = 5;
    maxforce = 1;
    re=(int)random(255);
    bl=(int)random(255);
    gr=(int)random(255);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
 
 
  void seek(PVector target, boolean seek) {
    float compare=1000;
    PVector desired = PVector.sub(target,location);
    if (seek) alfa=300-desired.mag()/255*150;
    if (!seek) {compare=desired.mag();}
    float d=desired.mag();
    desired.normalize();
    
    if (seek && d<200) {
      float m= map(d,0,100,0,maxspeed);
      desired.mult(m);
    }
    else desired.mult(maxspeed);
    
    if (location. x < 25) {
//Make a desired vector that retains the y direction of the vehicle but points the x direction directly away from the window’s left edge.
          desired = new PVector(maxspeed,velocity.y);
}
    
    PVector steer= PVector.sub(desired,velocity);
    PVector steer1=PVector.sub(desired,velocity);
    
    
    steer.limit(maxforce);
    steer1.limit(maxforce*2);
    steer1.div(0.5);
    
    if (seek) applyForce(steer);
    if (!seek && compare<300) applyForce(steer1);
    
  }
  
  void follow (FlowField flow) {
    PVector desired=flow.lookup(location);
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
    alfa=255;
  }
  
  void display() {
//Vehicle is a triangle pointing in the direction of velocity; since it is drawn pointing up, we rotate it an additional 90 degrees.
    float theta = velocity.heading() + PI/2;
    fill(re,bl,gr,(int)alfa);
    stroke(0,alfa);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}