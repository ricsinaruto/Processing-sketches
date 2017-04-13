import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


ArrayList<Box> boxes;
Box2DProcessing box2d;  
ArrayList<Boundary> boundaries;
ArrayList<Pair> pairs;
ArrayList<Windmill> windmills;

Surface surface1;



void setup() {
  size(1920,1080,P3D);
  frameRate(60);
  
    // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  box2d.setGravity(0,-100);
  
  boxes=new ArrayList<Box>();
  boundaries=new ArrayList<Boundary>();
  pairs=new ArrayList<Pair>();
  windmills=new ArrayList<Windmill>();
  surface1 = new Surface();
  
}

void keyPressed() {
    Windmill p = new Windmill(mouseX,mouseY);
    windmills.add(p);
  }

void draw() {
  background(255);
  box2d.step();
  
  surface1.display();
  
  if (mousePressed) {
    Box p= new Box(mouseX,mouseY,30,30,false);
    boxes.add(p);
  }
  
 /* if (keyPressed) {
    Boundary p = new Boundary(mouseX,mouseY,200,20);
    boundaries.add(p);
  }*/
  
  Iterator<Box> it= boxes.iterator();
  while (it.hasNext()) {
    Box p=it.next();
    p.display();
    if (p.dead)
    {
      p.killBody();
      it.remove();
    }
  }
  
  for (Boundary b: boundaries) {
    b.display();
  }
  
  for (Windmill b: windmills) {
    b.display();
  }
  
   surface.setTitle(int(frameRate) + " fps");
}