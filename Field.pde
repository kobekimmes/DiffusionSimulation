

class Field {


  int rows, cols, res;
  Cell[][] field, newField;
  float f, k; //feed and kill rate of the "chemicals"
  float dA, dB; //diffusion rates of the "chemicals"

  public Field(int rows, int cols, int res) {
    this.rows = rows;
    this.cols = cols;
    this.res = res;

    this.field = new Cell[rows][cols];
    this.newField = field;

    this.f = 0;
    this.k = 0;
    this.dA = 0;
    this.dB = 0;
  }


  public void initField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.field[i][j] = new Cell(i, j, this.res);
      }
    }
  }

  public void evalField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        Cell c = this.field[i][j];
        float a = c.a;
        float b = c.b;

        float newA = a + this.dA * pow(this.laplace(c, true), 2) * a - a * b * b + this.f * (1 - a);
        float newB = b + this.dB * pow(this.laplace(c, false), 2)  * b + a * b * b - (this.k - this.f) * b;
        
        
      }
    }
  }


  public void updateField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.newField[i][j] = this.field[i][j];
      }
    }
  }

  public void drawField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.field[i][j].show();
      }
    }
  }

  public float laplace(Cell cell, boolean a) {
    int[] xDir = new int[]{-1, 0, 1, -1, 0, 1, -1, 0, 1};
    int[] yDir = new int[]{-1, -1, -1, 0, 0, 0, 1, 1, 1};
    
    int i = cell.i;
    int j = cell.j;

    int sum = 0;

    for (int k = 0; k < 10; k++) {
      if (a) {
        if (xDir[k] == 0 ^ yDir[k] == 0) {
          sum += this.field[i + xDir[k]][j + yDir[k]].a * 0.2;
        } else if (xDir[k] != 0 && yDir[k] != 0) {
          sum += this.field[i + xDir[k]][j + yDir[k]].a * 0.05;
        } else {
          sum -= this.field[i + xDir[k]][j + yDir[k]].a;
        }
      }
      else {
        if (xDir[k] == 0 ^ yDir[k] == 0) {
          sum += this.field[i + xDir[k]][j + yDir[k]].b * 0.2;
        } else if (xDir[k] != 0 && yDir[k] != 0) {
          sum += this.field[i + xDir[k]][j + yDir[k]].b * 0.05;
        } else {
          sum -= this.field[i + xDir[k]][j + yDir[k]].b;
        }
      }
    }
    return sum;
  }
}
