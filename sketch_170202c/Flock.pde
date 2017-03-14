class Flock {
  ArrayList<Vehicle> vehicles;
  
  Flock() {
    vehicles=new ArrayList<Vehicle>();
  }
  
  void run() {
    for (Vehicle v : vehicles) {
      v.run(vehicles);
    }
  }
  
  void addBoid(Vehicle v) {
    vehicles.add(v);
  }
}