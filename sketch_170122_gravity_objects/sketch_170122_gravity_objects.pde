import java.util.*; 

class Liquid {
  float x,y,w,h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  void display() {
    noStroke();
    fill(175);
    rect(x,y,w,h);
  }
}
Liquid liquid;

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
    acceleration.mult(0);
    
  }
  
   void display() {
     stroke(0);
     fill(r,g,b);
     ellipse(location.x,location.y,mass*scale,mass*scale);
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
   
   boolean isInside(Liquid l) {
  if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h)
  {
    return true;
  } else {
    return false;
  }
}

void drag(Liquid l) {
   
    float speed=velocity.mag();
    float dragMagnitude=l.c*speed*speed;
    PVector drag=velocity.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    
    applyForce(drag);
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

Mover[] movers =new Mover[20];

class Attractor {
  float mass;
  PVector location;
  float G;
 
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
    G=1;
  }
  
  PVector attract(Mover m) {
    PVector force=PVector.sub(location, m.location);
    float distance=force.mag();
    distance = constrain(distance,5,25);
    force.normalize();
    float strength=(G*mass*m.mass)/(distance*distance);
    force.mult(strength);
    return force;
  }
    
 
  void display() {
    stroke(0);
    fill(175,200);
    ellipse(location.x,location.y,mass*10,mass*10);
  }
}


Attractor a;

void setup() {
  size(1920,1080);
  background(0);
  liquid=new Liquid(width/2, height/2, width/2, height/2, 0.1);
  a = new Attractor();
  frameRate(1000);
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
  liquid.display();
  a.display();
  
  
  
  PVector wind=new PVector();
  wind.x=(noise(t)-0.5)*1;
  wind.y=(noise(t+10000)-0.5)*1;
  if (mousePressed){ wind.x+=10;}
  
  
  for(int i=0;i<movers.length;i++) {
     if (movers[i].isInside(liquid)) {
      movers[i].drag(liquid);
    }
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
    //movers[i].applyForce(wind);
   // movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    
  }
  
  
  surface.setTitle(int(frameRate) + " fps");
  t+=0.01;
}