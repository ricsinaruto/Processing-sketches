ArrayList<KochLine> lines;

void setup() {
  size(1280, 720);

  lines = new ArrayList<KochLine>();
 
  PVector start = new PVector(0, 500);
  PVector end   = new PVector(width, 500);
 
  lines.add(new KochLine(start, end));
  
  for(int i=0;i<10;i++) {
    generate();
  }
}

void draw() {
  background(255);
  for (KochLine l : lines) {
    l.display();
  }
}

void generate() {
  ArrayList next=new ArrayList<KochLine>();
  
  for (KochLine l:lines) {
    PVector a = l.kochA();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
    
    next.add(new KochLine(a,b));
    next.add(new KochLine(b,c));
    next.add(new KochLine(c,d));
    next.add(new KochLine(d,e));
  }
  lines=next;
}