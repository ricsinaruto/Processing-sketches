import java.util.*;

ArrayList<Vehicle> vehicles;
Path path;
Flock flock;

void setup() {
  size(1920,1080,P2D);
  frameRate(60);
  vehicles=new ArrayList<Vehicle>();
  flock=new Flock();
  
  for (int i=0;i<500;i++) {
    Vehicle p =new Vehicle(random(width),random(height));
    flock.addBoid(p);
  }
  path=new Path();
  
   path.addPoint(200,height/2+50);
   path.addPoint(400,height/2+50);
   path.addPoint(600,height/2-50);
   path.addPoint(400,height/2-100);
   path.addPoint(200,height/2-30);
   path.addPoint(200,height/2+50);
  
}

/*void mousePressed() {
  Vehicle p =new Vehicle(mouseX,mouseY);
  vehicles.add(p);
}*/


void draw() {
  background(130);
  
  path.display();
  if (mousePressed) {
  Vehicle p =new Vehicle(mouseX,mouseY);
  vehicles.add(p);
}
  
 flock.run();
  
   
  
   surface.setTitle(int(frameRate) + " fps");
}