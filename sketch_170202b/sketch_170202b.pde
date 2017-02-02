import java.util.*;

ArrayList<Vehicle> vehicles;

void setup() {
  size(1600,900,P2D);
  frameRate(60);
  vehicles=new ArrayList<Vehicle>();
  
  for (int i=0;i<1000;i++) {
    Vehicle p =new Vehicle(random(width),random(height));
    vehicles.add(p);
  }
}

void mousePressed() {
  Vehicle p =new Vehicle(mouseX,mouseY);
  vehicles.add(p);
}


void draw() {
  background(0);
  
  for (Vehicle b: vehicles) {
    b.seek(new PVector(mouseX,mouseY),true);
    
    for (int i=0;i<5;i++) {
      b.seek(new PVector(random(width),random(height)),false);
    }
    b.update();
    b.display();
  }
  
   
  
   surface.setTitle(int(frameRate) + " fps");
}