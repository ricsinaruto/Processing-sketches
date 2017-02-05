import java.util.*;

ArrayList<Vehicle> vehicles;
Path path;

void setup() {
  size(1600,900,P2D);
  frameRate(60);
  vehicles=new ArrayList<Vehicle>();
  
  for (int i=0;i<20;i++) {
    Vehicle p =new Vehicle(random(width),random(height));
    vehicles.add(p);
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
  
  for (Vehicle v: vehicles) {
    // Path following and separation are worked on in this function
    v.ApplyBehaviors(vehicles,path);
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }
  
   
  
   surface.setTitle(int(frameRate) + " fps");
}