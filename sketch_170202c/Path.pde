class Path {
 
  ArrayList<PVector> points;
//A path is only two points, start and end.
  PVector start;
  PVector end;
 
//A path has a radius, i.e. how wide it is.
  float radius;
 
  Path() {
//Picking some arbitrary values to initialize the path
    radius = 50;
    points = new ArrayList<PVector>();
  }
  
  void addPoint(float x, float y) {   
    PVector point = new PVector(x,y);
    points.add(point);
  }
 
  void display() {  // Display the path.
     stroke(0);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x,v.y);
    }
    endShape();
  }
}