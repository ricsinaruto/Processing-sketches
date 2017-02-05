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
  
  void ApplyBehaviors(ArrayList vehicles, Path path) {
    // Follow path force
    PVector f = followPath(path);
    // Separate from other boids force
    PVector s = separate(vehicles);
    // follow mouse
    PVector m = seek(new PVector(mouseX,mouseY),true);
    // Arbitrary weighting
    f.mult(3);
    s.mult(2);
    m.mult(1.4);
    // Accumulate in acceleration
    //applyForce(f);
    applyForce(s);
    applyForce(m);
  }
  
  void run() {
    update();
    display();
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
 
  PVector separate(ArrayList boids) {
    float distance=r*2;
    PVector steer = new PVector(0, 0, 0);
    int count=0;
    
 // For every boid in the system, check if it's too close
    for (int i = 0 ; i < boids.size(); i++) {
      Vehicle other = (Vehicle) boids.get(i);
      float d = PVector.dist(location, other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < distance)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
 
  PVector seek(PVector target, boolean seek) {
    float compare=1000;
    PVector desired = PVector.sub(target,location);
    if (seek) alfa=300-desired.mag()/255*150;
    if (!seek) {compare=desired.mag();}
    float d=desired.mag();
    desired.normalize();
    
    /*if (seek && d<200) {
      float m= map(d,0,100,0,maxspeed);
      desired.mult(m);
    }*/
    desired.mult(maxspeed);
    
   
    
    PVector steer= PVector.sub(desired,velocity);
    PVector steer1=PVector.sub(velocity,desired);
    
    
    steer.limit(maxforce);
    steer1.limit(maxforce);
   
    
    if (seek) return steer;
    else return steer1;
   
    
    
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
    //alfa=255;
  }
  
  //following a path
  PVector followPath(Path p) {
 
//Step 1: Predict the vehicle’s future location.
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(25);
    PVector predictLoc = PVector.add(location, predict);
 
 PVector target = null;
  PVector normal = null;
//Start with a very high record that can easily be beaten.
float worldRecord = 1000000;
//Step 2: Find the normal point along the path.
    for (int i = 0; i < p.points.size(); i++) {
  PVector a = p.points.get(i);
  PVector b = p.points.get((i+1)%p.points.size());
//Finding the normals for each line segment
  PVector normalPoint = getNormalPoint(predictLoc, a, b);
  
   // Check if normal is on line segment
      PVector dir = PVector.sub(b, a);
  
    if (normalPoint.x < min(a.x,b.x) || normalPoint.x > max(a.x,b.x) || normalPoint.y < min(a.y,b.y) || 
    normalPoint.y > max(a.y,b.y)) {
        normalPoint = b.get();
        
        // If we're at the end we really want the next line segment for looking ahead
        a = p.points.get((i+1)%p.points.size());
        b = p.points.get((i+2)%p.points.size());  // Path wraps around
        dir = PVector.sub(b, a);
   }
   float distance = PVector.dist(predictLoc, normalPoint);
 
//If we beat the record, then this should be our target!
  if (distance < worldRecord) {
    worldRecord = distance;
    normal = normalPoint.get();
    
    // Look at the direction of the line segment so we can seek a little bit ahead of the normal
        dir.normalize();
        // This is an oversimplification
        // Should be based on distance to path & velocity
        dir.mult(25);
        target = normal.get();
        target.add(dir);
      }
    }
    
    // Only if the distance is greater than the path's radius do we bother to steer
    if (worldRecord > p.radius) {
      return seek(target,true);
    }
    else {
      return new PVector(0, 0);
    }

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