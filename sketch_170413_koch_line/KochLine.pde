class KochLine {
  PVector start;
  PVector end;
  
  KochLine(PVector a, PVector b) {
    start=a.get();
    end =b.get();
  }
  
  void display() {
    stroke(0);
    line(start.x,start.y,end.x,end.y);
  }
  
  
  //calculating new line points
  PVector kochA() {
    return start.get();
  }
  PVector kochE() {
    return end.get();
  }
  
  PVector kochB() {
    PVector v=PVector.sub(end,start);
    v.div(3);
    v.add(start);
    return v;
  }
  PVector kochD() {
    PVector v=PVector.sub(end,start);
    v.mult(2/3.0);
    v.add(start);
    return v;
  }
  
  PVector kochC() {
    PVector a=start.get();
    
    PVector v=PVector.sub(end,start);
    v.div(3);
    a.add(v);
    
    v.rotate(-radians(60));
    a.add(v);
    
    return(a);
  }
}