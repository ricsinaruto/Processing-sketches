class Windmill {
 
//Our “Windmill” is two boxes and one joint.
  RevoluteJoint joint;
  Box box1;
  Box box2;
 
  Windmill(float x, float y) {
 
//In this example, the Box class expects a boolean argument that will be used to determine if the Box is fixed or not. 
//See website for the Box class code.
    box1 = new Box(x,y,120,10,false);
    box2 = new Box(x,y,10,40,true);
 
 
 
    RevoluteJointDef rjd = new RevoluteJointDef();
//The joint connects two bodies and is anchored at the center of the first body.
    rjd.initialize(box1.body, box2.body, box1.body.getWorldCenter());
 
 
 
//A motor!
    rjd.motorSpeed = PI*2;
    rjd.maxMotorTorque = 100000.0;
    rjd.enableMotor = true;
 
//Create the Joint.
    joint = (RevoluteJoint) box2d.world.createJoint(rjd);
  }
 
//Turning the motor on or off
  void toggleMotor() {
    boolean motorstatus = joint.isMotorEnabled();
    joint.enableMotor(!motorstatus);
  }
 
  void display() {
    box1.display();
    box2.display();
  }
}