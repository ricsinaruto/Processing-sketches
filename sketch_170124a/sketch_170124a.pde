import java.util.*; 

ArrayList<Particle> particles;

void setup() {
  size(1920,1080,P2D);
  frameRate(60);
  particles=new ArrayList<Particle>();
}

 float noiset=0;
void draw() {
  background(0);
  for (int i=0;i<10;i++) {
    particles.add(new Particle(new PVector(mouseX,mouseY),
    (int)map(noise(noiset),0,1,0,255),(int)map(noise(noiset+10000),0,1,0,255),(int)map(noise(noiset+100000),0,1,0,255)));
    noiset+=0.005;
  }
  
  Iterator<Particle> it= particles.iterator();
  while (it.hasNext()) {
    Particle p=it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }

  surface.setTitle(int(frameRate) + " fps");
}





class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int r,g,b;

  float lifespan;
 
  Particle(PVector l, int rr, int bb, int gg) {
    acceleration = new PVector(0,0.05);
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
 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);

    lifespan -= 2;
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