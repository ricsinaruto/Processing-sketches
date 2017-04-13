class Path {
 
  ArrayList<PVector> points;
//A path is only two points, start and end.
  PVector start;
  PVector end;
 
//A path has a radius, i.e. how wide it is.
  float radius;
 
  Path() {
//Picking some arbitrary values to initialize the path
    radius = 20;
    points = new ArrayList<PVector>();
  }
  
  void addPoint(float x, float y) {   
    PVector point = new PVector(x,y);
    points.add(point);
  }
 
  void display() {  // Display the path.
    strokeJoin(ROUND);
    
    //Draw thick line for radius
    stroke(175);
    strokeWeight(radius*2);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x,v.y);
    }
    endShape(CLOSE);
    
    //Draw thin line for center of path
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
}