class Pair {
 
//Two objects that each have a Box2D body
  Box p1;
  Box p2;
//Arbitrary rest length
  float len = 50;
 
  Pair(float x, float y) {
 
//Problems can result if the bodies are initialized at the same location.
 
    p1 = new Box(x,y,16,16,false);
    p2 = new Box(x+random(-1,1),y+random(-1,1),16,16,false);
 
//Making the joint!
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
    djd.length = box2d.scalarPixelsToWorld(len);
    djd.frequencyHz = 1;  // Try a value less than 5
    djd.dampingRatio = 1; // Ranges between 0 and 1
 
//Make the joint. Note that we aren't storing a reference to the joint anywhere! We might need to someday, but for now it's OK.
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
 
  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    stroke(0);
    line(pos1.x,pos1.y,pos2.x,pos2.y);
 
    p1.display();
    p2.display();
  }
}