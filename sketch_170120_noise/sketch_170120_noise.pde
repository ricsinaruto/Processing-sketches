import java.util.*; 

Random generator;
Random generator2;

class Walker {
  //Objects have data.
  float x;
  float y;
  float tx,ty;
  
  //constructor
   Walker() {
    tx=0;
    ty=1;
  }
  
  //object displays itself and takes a step
  void display() {
    
    ellipse(x,y,50,20);
  }
  
  //random step
  void step() {
     x = map(noise(tx), 0, 1, 0, width);
     y = map(noise(ty), 0, 1, 0, height);
     
     tx += 0.01;
    ty += 0.01;
    
  }
}

//initializing
Walker w;


//program window
void setup() {
  size(1280,720);
  w=new Walker();
  background(255);
  generator= new Random();
  generator2=new Random();
  
}

float t=0;
float xoff = 0.0;
//drawing
void draw() {
  //background(255);
  //w.step();
  //w.display();
 
  float num=(float) generator.nextGaussian();
  float sd=60;
  float mean=320;
  float x=sd*num+mean;
  
  noStroke();
  //noLoop();
  
  fill(0,100);
 // ellipse(x,180,16,16);
  
  float n=noise(t);
  float y=map(n,0,1,0,width);
  println(n);
 // ellipse(y,180,16,16);
 
  
  
  
 loadPixels();
  for (int xl = 0; xl < width; xl++) {

  float yoff = 0.0;
 
  for (int yl = 0; yl < height; yl++) {

    float bright = map(noise(xoff,yoff,t),0,1,0,255);
   // noiseDetail(10,0.5);

    pixels[xl+yl*width] = color(bright,0,255);

    yoff += 0.006;
    
  }

  xoff += 0.005;
}
updatePixels();
t+=11;
 
 
}
 
 