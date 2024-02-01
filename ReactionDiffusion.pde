
int screenSize = 1000;

int res = 10;

int rows = screenSize / res;
int cols = screenSize / res;

void settings() {
  width = screenSize;
  height = screenSize;
}

Field f = new Field(rows, cols, res);

void setup() {
  f.initField();
  f.seed(true);
}

void draw() {
  frameRate(60);
  f.addChem();

  
  f.updateField();
  f.drawField();
  f.evalField();
  //f.swapField();
  

  //  f.drawField();
}
