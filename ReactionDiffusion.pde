
int screenSize = 800;

int res = 5;
int rows = screenSize / res;
int cols = screenSize / res;


Field f = new Field(rows, cols, res);

void settings() {
  width = screenSize;
  height = screenSize;
  
}

void setup() {
  f.initField();
  f.seed(false);
}

void draw() {
  frameRate(60);
  f.addChem();
  f.evalField();
  f.updateField();
  //f.drawField();
  
}
