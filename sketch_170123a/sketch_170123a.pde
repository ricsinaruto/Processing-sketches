class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int topspeed;
  float mass;
  float scale;
  int r,g,b;
  int acclimit;
  float G;
  float angle=0;
  float aVelocity=0;
  float aAcceleration=0;
  
  
  Mover(float m, float x, float y,int rr,int gg,int bb) {
    location=new PVector(x, y);
    velocity=new PVector(0, 0);
    acceleration=new PVector(0,0);
    topspeed=50;
    acclimit=2500;
    mass=m;
    G=0.5;
    scale=40;
    r=rr;
    g=gg;
    b=bb;
  }
  
  void applyForce(PVector force) {
    PVector f=force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  void update() {
    
    acceleration.limit(acclimit);
   //println(acceleration);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
    aAcceleration=acceleration.x/10;
     aVelocity+=aAcceleration;
    
    aVelocity=constrain(aVelocity,-0.1,0.1);
    angle+=aVelocity;
    
    acceleration.mult(0);
    
    
    
   
    
  }
  
   void display() {
     float angle=atan2(velocity.y,velocity.x);
     
     stroke(0);
     fill(r,g,b);
     rectMode(CENTER);
     pushMatrix();
     
     translate(location.x,location.y);
     rotate(angle);
     rect(0,0,mass*scale*2,mass*scale);
     popMatrix();
   }
   
   void checkEdges() {
    if ((location.x+(mass*scale)/2 > width) || (location.x-(mass*scale)/2 < 0)) {
     if (location.x+(mass*scale)/2>width) location.x=width-(mass*scale)/2;
     if (location.x-(mass*scale)/2<0) location.x=(mass*scale)/2;
      velocity.x = velocity.x * -0.9;
    }
    if ((location.y+(mass*scale)/2 > height) || (location.y-(mass*scale)/2 < 0)) {
      if (location.y+(mass*scale)/2>height) location.y=height-(mass*scale)/2;
     if (location.y-(mass*scale)/2<0) location.y=(mass*scale)/2;
    velocity.y = velocity.y * -0.9;
    }
   }
   
   



PVector attract(Mover m) {
    PVector force=PVector.sub(location, m.location);
    float distance=force.mag();
    distance = constrain(distance,20,1000);
    force.normalize();
    float strength=(G*mass*m.mass)/(distance*distance);
    force.mult(strength);
    return force;
  }
}

Mover[] movers =new Mover[280];



void setup() {
  size(1920,1080,P2D);
  background(0);
  
  //frameRate(1000);
  float noiset=0;
  for (int i=0; i<movers.length;i++) {
  movers[i]=new Mover(random(1,10),random(width),random(height),
  (int)map(noise(noiset),0,1,0,255),(int)map(noise(noiset+10000),0,1,0,255),(int)map(noise(noiset+100000),0,1,0,255));
   noiset+=1;
  }
}

 float t=0;
 
void draw() {
  background(0);
  
  
  
  PVector wind=new PVector();
  wind.x=(noise(t)-0.5)*1;
  wind.y=(noise(t+10000)-0.5)*1;
  if (mousePressed){ wind.x+=1;}
  
  
  for(int i=0;i<movers.length;i++) {
     
    for (int j=0;j<movers.length;j++) {
      if (i!=j) {
        PVector force=movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }
    float m=movers[i].mass;
    PVector gravity=new PVector(0,0.1*m);
    
    //PVector f=a.attract(movers[i]);
    //movers[i].applyForce(f);
    movers[i].checkEdges();
    movers[i].applyForce(wind);
   // movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    
  }
  
  
  surface.setTitle(int(frameRate) + " fps");
  t+=0.01;
}