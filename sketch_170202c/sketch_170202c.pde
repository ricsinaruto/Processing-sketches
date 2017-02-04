import java.util.*;

ArrayList<Vehicle> vehicles;
Path path;

void setup() {
  size(1600,900,P2D);
  frameRate(60);
  vehicles=new ArrayList<Vehicle>();
  
  for (int i=0;i<1000;i++) {
    Vehicle p =new Vehicle(random(width),random(height));
    vehicles.add(p);
  }
  path=new Path();
  for (int i=0;i<10;i++) {
    if (i%2==0) path.addPoint(i*100,height/2+200);
    if (i%2==1) path.addPoint(i*100,height/2-200);
  }
}

/*void mousePressed() {
  Vehicle p =new Vehicle(mouseX,mouseY);
  vehicles.add(p);
}*/


void draw() {
  background(0);
  
  if (mousePressed) {
  Vehicle p =new Vehicle(mouseX,mouseY);
  vehicles.add(p);
}
  
  for (Vehicle b: vehicles) {
    b.followPath(path);
    
   /* for (int i=0;i<5;i++) {
      b.seek(new PVector(random(width),random(height)),false);
    }*/
    b.update();
    b.display();
  }
  
   path.display();
  
   surface.setTitle(int(frameRate) + " fps");
}