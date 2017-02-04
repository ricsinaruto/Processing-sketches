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
  
  PVector getNormalPoint(PVector p, PVector a, PVector b) {
//PVector that points from a to p
    PVector ap = PVector.sub(p, a);
//PVector that points from a to b
    PVector ab = PVector.sub(b, a);
 
//Using the dot product for scalar projection
    ab.normalize();
    ab.mult(ap.dot(ab));
//Finding the normal point along the line segment
    PVector normalPoint = PVector.add(a, ab);
 
    return normalPoint;
  }
  
  //following flowfield lines
  void follow (FlowField flow) {
    PVector desired=flow.lookup(location);
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
    alfa=255;
  }
  
  //following a path
  void followPath(Path p) {
 
//Step 1: Predict the vehicle’s future location.
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(25);
    PVector predictLoc = PVector.add(location, predict);
 
 PVector target = null;
//Start with a very high record that can easily be beaten.
float worldRecord = 1000000;
//Step 2: Find the normal point along the path.
    for (int i = 0; i < p.points.size()-1; i++) {
  PVector a = p.points.get(i);
  PVector b = p.points.get(i+1);
//Finding the normals for each line segment
  PVector normalPoint = getNormalPoint(predictLoc, a, b);
    if (normalPoint.x < a.x || normalPoint.x > b.x) {
//Use the end point of the segment as our normal point if we can’t find one.
      normalPoint = b.get();
   }
   float distance = PVector.dist(predictLoc, normalPoint);
 
//If we beat the record, then this should be our target!
  if (distance < worldRecord) {
    worldRecord = distance;
    target = normalPoint.get();
  }
    }
 seek(target,true);
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