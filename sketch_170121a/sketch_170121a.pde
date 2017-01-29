import java.util.*; 
 
class PVector {
  float x;
  float y;
  
  PVector (float x_, float y_) {
    x=x_;
    y=y_;
  }
  void add(PVector v) {
    y=y+v.y;
    x=x+v.x;
  }
  
  void sub(PVector v) {
    x=x-v.x;
    y=y-v.y;
  }
  
  void mult(float n) {
    x=x*n;
    y=y*n;
  }
  
  void div(float n) {
     x = x / n;
    y = y / n;
  }
  
  float mag() {
    return sqrt(x*x+y*y);
  }
  
  void normalize() {
    float m=mag();
    if (m!=0)   div(m);
  }
  
  void limit(float max) {
    if(mag()>max) {
      normalize();
      mult(max);
    }
  }
}

PVector random2D(float t) {
  float angle = noise(t)*TWO_PI;
  return new PVector(cos(angle),sin(angle));
}

PVector add(PVector v1, PVector v2) {
    PVector v3 = new PVector(v1.x + v2.x, v1.y + v2.y);
    return v3;
  }
  
PVector sub(PVector v1, PVector v2) {
    PVector v3 = new PVector(v1.x - v2.x, v1.y - v2.y);
    return v3;
  }
  

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float t;
  float accspeed;
  int switcher;
  int r,g,b;
  
   float angle=0;
  float aVelocity=0;
  float aAcceleration=0;
  
  PVector mouse;
  PVector dir;
  
  Mover() {
    location=new PVector(random(width), random(height));
    velocity=new PVector(0, 0);
    acceleration=new PVector(-0.01,0.01);
    topspeed=20;
    t=0;
    switcher=1;
    r=255;
    g=255;
    b=255;
    
  }
  
  void update() {
    mouse= new PVector(mouseX,mouseY);
    dir=sub(mouse,location);
    
    if (dir.mag()*dir.mag()*0.003>0.01) dir.div(dir.mag()*dir.mag()*0.003);
    dir.mult(switcher);
    t+=0.1;
    //acceleration=random2D(t);
    acceleration=dir;
    velocity.add(acceleration);
    location.add(velocity);
    velocity.limit(topspeed);
    
    aAcceleration=acceleration.x/10;
     aVelocity+=aAcceleration;
    
    aVelocity=constrain(aVelocity,-0.1,0.1);
    angle+=aVelocity;
    
  }
  
  void setColor(int rr,int gg, int bb) {
    r=rr;
    g=gg;
    b=bb;
  }
   void display() {
     float angle=atan2(velocity.y,velocity.x);
     stroke(0);
     fill(r,g,b);
    // ellipse(location.x,location.y,40,40);
    rectMode(CENTER);
     pushMatrix();
     
     translate(location.x,location.y);
     rotate(angle);
     rect(0,0,80,10);
     popMatrix();
   }
   
   void checkEdges() {
    if ((location.x+20 > width) || (location.x-20 < 0)) {
     if (location.x+20>width) location.x=width-21;
     if (location.x-20<0) location.x=21;
      velocity.x = velocity.x * -0.9;
    }
    if ((location.y+20 > height) || (location.y-20 < 0)) {
      if (location.y+20>height) location.y=height-21;
     if (location.y-20<0) location.y=21;
    velocity.y = velocity.y * -0.9;
    }
     
   }
   
   void switcher() {
     if (switcher==1) switcher=-1;
     else switcher=1;
   }
}

Mover[] movers =new Mover[6250];

PVector location=new PVector(width/2,height/2);
PVector velocity=new PVector(5,3);
PVector acceleration=new PVector(0.01,0.01);

void setup() {
  size(1920,1080,P2D);
  background(0);
  frameRate(70);
  float noiset=0;
  for (int i=0;i<movers.length;i++) {
    movers[i]=new Mover();
    movers[i].setColor((int)map(noise(noiset),0,1,0,255),(int)map(noise(noiset+10000),0,1,0,255),(int)map(noise(noiset+100000),0,1,0,255));
    noiset+=0.01;
  }
}
 float t=0;
void draw() {
  background(0);
  acceleration.x=(noise(t)-0.5)*1;
  acceleration.y=(noise(t+1000)-0.5)*1;
   velocity.add(acceleration);
  
  
  for (int i=0;i<movers.length;i++) {
  movers[i].checkEdges();
  movers[i].update();
  movers[i].display();
  }
  

 if ((location.x+20 > width) || (location.x-20 < 0)) {
     if (location.x+20>width) location.x=width-21;
     if (location.x-20<0) location.x=21;
      velocity.x = velocity.x * -0.9;
    }
    if ((location.y+20 > height) || (location.y-20 < 0)) {
      if (location.y+20>height) location.y=height-21;
     if (location.y-20<0) location.y=21;
    velocity.y = velocity.y * -0.9;
    }
    velocity.limit(15);
   
 location.add(velocity);
  stroke(0);
  fill(175);

  ellipse(location.x,location.y,40,40);
  
  
  
  PVector mouse  = new PVector(mouseX,mouseY);
  PVector center = new PVector(width/2,height/2);

  mouse.sub(center);
  mouse.normalize();
  mouse.mult(50);
   
  float m = mouse.mag();
  fill(0);
  rect(0,0,m,10);

  translate(width/2,height/2);
  line(0,0,mouse.x,mouse.y);
  
  
  
  t+=0.2;
  
  surface.setTitle(int(frameRate) + " fps");
  
  
  
}

void mousePressed() {
  for (int i=0;i<movers.length;i++) {
  movers[i].switcher();
  }
}