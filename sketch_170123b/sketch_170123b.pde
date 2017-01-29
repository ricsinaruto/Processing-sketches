class Oscillator  {
 

  PVector angle;
  PVector velocity;
  PVector amplitude;
 
  Oscillator()  {
    angle = new PVector();
    velocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));

    amplitude = new PVector(random(width/2),random(height/2));
  }
 
  void oscillate()  {
    angle.add(velocity);
  }
 
  void display()  {

    float x = sin(angle.x)*amplitude.x;

    float y = sin(angle.y)*amplitude.y;
 
    pushMatrix();
    translate(width/2,height/2);
    stroke(0);
    fill(175);

    line(0,0,x,y);
    ellipse(x,y,40,40);
    popMatrix();
  }
}

Oscillator[] oscis =new Oscillator[28];



void setup() {
  size(1920,1080,P2D);
  background(0);
  
  //frameRate(1000);
  float noiset=0;
  for (int i=0; i<oscis.length;i++) {
  oscis[i]=new Oscillator();
  }
}

 float t=0;
 
void draw() {
  background(0);
  
  for(int i=0;i<oscis.length;i++) {
     
    oscis[i].oscillate();
    oscis[i].display();
    
  }
  
  
  surface.setTitle(int(frameRate) + " fps");
  t+=0.01;
}