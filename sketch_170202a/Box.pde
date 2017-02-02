class Box {
  Body body;
  float w;
  float h;
  boolean dead=false;


Box(float x, float y,float w_, float h_, boolean fixed) {
    w = w_;
    h = h_;
 
//Build body.
    BodyDef bd = new BodyDef();
    if (fixed) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);
 
    Vec2[] vertices = new Vec2[4];  // An array of 4 vectors
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-15, 25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(15, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(20, -15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-10, -10));
 
    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);
 

//Box2D considers the width and height of a rectangle to be the distance from the 
//center to the edge (so half of what we normally think of as width or height).
   
 
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    
    fd.density = 1;
//Set physics parameters.
    fd.friction = 0.3;
    fd.restitution = 0.8;
 
//Attach the Shape to the Body with the Fixture.
    body.createFixture(fd);
 }
 
 void display() {
   Vec2 pos = box2d.getBodyPixelCoord(body);
   float a = body.getAngle();
   
   Fixture f = body.getFixtureList();
   PolygonShape ps = (PolygonShape) f.getShape();
   
   if (pos.x>width || pos.y>height) {dead=true;}
   
 
   rectMode(CENTER);
   pushMatrix();
   translate(pos.x,pos.y);
   rotate(-a);
   fill(175);
   stroke(0);
   beginShape();
   for (int i=0;i <ps.getVertexCount(); i++) {
     Vec2 v=box2d.vectorWorldToPixels(ps.getVertex(i));
     vertex(v.x,v.y);
   }
   
   endShape(CLOSE);
   popMatrix();
 }
 
 
 
 void killBody() {
   box2d.destroyBody(body);
 }
}