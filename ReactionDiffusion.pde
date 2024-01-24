
int screenSize = 800;

int res = 10;
int rows = screenSize / res;
int cols = screenSize / res;


Field f = new Field(rows, cols, res);

void settings() {
  width = screenSize;
  height = screenSize;
  
}

void setup() {
  f.initField();
}

void draw() {
  background(255);
  f.drawField();
}
