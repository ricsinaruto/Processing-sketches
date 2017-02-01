import java.util.*; 
PImage img;

ArrayList<ParticleSystem> systems;
Repeller repeller;

void setup() {
  size(1600,900,P2D);
  frameRate(60);
  img=loadImage("particleTexture.png");
  systems = new ArrayList<ParticleSystem>();
  repeller=new Repeller(width/2,height/2);
}

void mousePressed() {
  systems.add(new ParticleSystem(new PVector(mouseX,mouseY),(int)random(255),(int)random(255),(int)random(255)));
}

 float noiset=0;
void draw() {
  blendMode(ADD);
  background(30);
  /*for (int i=0;i<15;i++) {
    particles.add(new Particle(new PVector(mouseX,mouseY),
    (int)map(noise(noiset),0,1,0,255),(int)map(noise(noiset+10000),0,1,0,255),(int)map(noise(noiset+100000),0,1,0,255)));
    noiset+=0.005;
  }*/
  
  PVector gravity=new PVector(0,0.01);
  
  for (ParticleSystem ps: systems) {
    ps.addParticle(new PVector(mouseX,mouseY),
     (int)map(noise(noiset),0,1,0,255),(int)map(noise(noiset+10000),0,1,0,255),(int)map(noise(noiset+100000),0,1,0,255));
    ps.applyForce(gravity);
    ps.applyRepeller(repeller);
    ps.run();
    noiset+=0.005;
  }
  
  //repeller.display();

  surface.setTitle(int(frameRate) + " fps");
}

class Repeller {
  float strength=200;
  PVector location;
  float r = 50;
 
  Repeller(float x, float y)  {
    location = new PVector(x,y);
  }
 
  void display() {
    stroke(255);
    fill(255);
    ellipse(location.x,location.y,r*2,r*2);
  }
  
  PVector repel(Particle p) {
    PVector dir=PVector.sub(location, p.location);
    float d=dir.mag();
    dir.normalize();
    d=constrain(d,5,100);
    float force=-1*strength/(d*d);
    dir.mult(force);
    return dir;
  }
}

//a list of Particle classes
class ParticleSystem {
  ArrayList<Particle> particles;
 
  PVector origin;
  int r,g,b;
  int particleNumber=20;
  
  ParticleSystem(PVector location, int rr, int gg, int bb) {
    r=rr;
    g=gg;
    b=bb;
    origin=location.get();
    particles=new ArrayList<Particle>();
  }
  
  void applyForce(PVector f) {
    for (Particle p: particles) {
      p.applyForce(f);
    }
  }
  
  void applyRepeller(Repeller r) {

    for (Particle p: particles) {
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }
  
  void addParticle (PVector mouseLocation,int r,int g,int b) {
    for (int i=0;i<particleNumber;i++) {
      particles.add(new Confetti(mouseLocation,r,g,b));
    }
  }
  
  void run() {
    Iterator<Particle> it= particles.iterator();
  while (it.hasNext()) {
    Particle p=it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
  }
}

//Confetti class that inherits the particle class
class Confetti extends Particle {
  
  
  Confetti(PVector l, int r, int g, int b) {
    super(l,r,g,b);
  }
  
  void display() {
    
    float theta = map(location.x,0,width,0,TWO_PI*2);
    
    
    imageMode(CENTER);
    stroke(0,lifespan/4);
    tint(r,g,b,lifespan/4);
    
    //rotation
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    image(img,0,0);
    popMatrix();
  }
}

//Particle class
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int r,g,b;

  float mass=1;
  float lifespan;
 
  Particle(PVector l, int rr, int bb, int gg) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-2,2),random(-2,2));
    location = l.get();

    lifespan = 255;
    r=rr;
    g=gg;
    b=bb;
  }
  
  void run() {
    update();
    display();
  }
  
  void applyForce(PVector force) {
    PVector f=force.get();
    f.div(mass);
    acceleration.add(f);
  }
    
 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);

    lifespan -= 1;
  }
 
  void display() {

    stroke(0,lifespan);
    fill(r,g,b,lifespan);
    ellipse(location.x,location.y,30,30);
  }
  
   boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}