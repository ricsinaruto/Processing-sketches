float mutationRate = 0.001;    // Mutation rate
int totalPopulation = 1000;      // Total Population

DNA[] population;             // Array to hold the current population
ArrayList<DNA> matingPool;    // ArrayList which we will use for our "mating pool"
String target;                // Target phrase

PFont f;

void setup() {
  size(800, 200);
  target = "ceau bogdan ce mai faci";

  population = new DNA[totalPopulation];

  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA(target.length());
  }
  
  f = createFont("Courier",12,true);
}

void draw() {
  for (int i = 0; i < population.length; i++) {
    population[i].calcFitness(target);
  }

  ArrayList<DNA> matingPool = new ArrayList<DNA>();  // ArrayList which we will use for our "mating pool"

  for (int i = 0; i < population.length; i++) {
    int nnnn = int(population[i].fitness * 100);  // Arbitrary multiplier, we can also use monte carlo method
    for (int j = 0; j <nnnn; j++) {              // and pick two random numbers
      matingPool.add(population[i]);
    }
  }

  for (int i = 0; i < population.length; i++) {
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    DNA partnerA = matingPool.get(a);
    DNA partnerB = matingPool.get(b);
    DNA child = partnerA.crossover(partnerB);
    child.mutate(mutationRate);
    population[i] = child;
  }
  
  background(255);
  fill(0);
  String everything = "";
  String tmp="";
  float best_fitness=1000;
  for (int i = 0; i < population.length; i++) {
    if (population[i].fitness<best_fitness) {
      best_fitness=population[i].fitness;
      tmp=population[i].getPhrase();
    }
  }
  everything+=tmp+"    ";
  textFont(f,12);
  text(everything,10,10,width,height);

  
}