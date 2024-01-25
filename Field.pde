

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

    this.f = 0.05;
    this.k = 0.062;
    this.dA = 1.0;
    this.dB = 0.005;
  }


  public void initField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        Cell c = new Cell(i, j, this.res);
        this.field[i][j] = c;
        this.newField[i][j] = c;
      }
    }
  }

  public void evalField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        Cell c = this.field[i][j];
        float a = c.a;
        float b = c.b;
        //println("old: ", a,b);

        //float newA = a + (this.dA * this.laplace(c, true));
        //float newB = b + (this.dB * this.laplace(c, false));
        float newA = a + ((this.dA * this.laplace(c, true) * a) - (a * (b * b)) + (this.f * (1 - a)));
        float newB = b + ((this.dB * this.laplace(c, false) * b) + (a * (b * b)) - ((this.k + this.f) * b));
        
        //println("new: ", newA, newB);

        this.newField[i][j].setChem(newA, newB);
        
      }
    }
  }

  public void updateField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        //this.field[i][j].setChem(this.newField[i][j].a, this.newField[i][j].b);
        this.field[i][j] = this.newField[i][j];
        this.field[i][j].show();
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
    int[] xDir = new int[]{-1, 0, 1, -1, 1, -1, 0, 1, 0};
    int[] yDir = new int[]{-1, -1, -1, 0, 0, 1, 1, 1, 0};

    int i = cell.i;
    int j = cell.j;

    int sum = 0;

    for (int k = 0; k < 9; k++) {
      if (((i + xDir[k] > -1) && (i + xDir[k] < this.rows)) && ((j + yDir[k] > -1) && (j + yDir[k] < this.cols))) {
        if (a) {
          if ((xDir[k] == 0) ^ (yDir[k] == 0)) {
            //println(k, "axial", xDir[k], yDir[k]);
            sum += (this.field[i + xDir[k]][j + yDir[k]].a) * 0.5;
          } else if ((xDir[k] != 0) && (yDir[k] != 0)) {
             //println(k, "diag", xDir[k], yDir[k]);
            sum += (this.field[i + xDir[k]][j + yDir[k]].a) * 0.05;
          } else {
            //println(k, "self", xDir[k], yDir[k]);
            sum -= (this.field[i + xDir[k]][j + yDir[k]].a);
          }
        } else {
          if ((xDir[k] == 0) ^ (yDir[k] == 0)) {
            sum += (this.field[i + xDir[k]][j + yDir[k]].b) * 0.2;
          } else if ((xDir[k] != 0) && (yDir[k] != 0)) {
            sum += (this.field[i + xDir[k]][j + yDir[k]].b) * 0.05;
          } else {
            sum -= this.field[i + xDir[k]][j + yDir[k]].b;
          }
        }
      }
    }
    return sum;
  }
  
  
  public void addChem() {
    int x = mouseX / this.res;
    int y = mouseY / this.res;
    
    if (mousePressed) {
      println(x, y);
      this.field[x][y].b += 0.5;
    }
  }
  
  public void seed(boolean random) {
    if (random) {
      int rX = (int) random(this.rows);
      int rY = (int) random(this.cols);
      
      this.field[rX][rY].b = 1;
      //this.newField[rX][rY].b = 1;
    }
    else {
      int squareSize = 2;
      for (int i = (rows/2)-squareSize; i < (rows/2)+squareSize; i++) {
        for (int j = (cols/2)-squareSize; j < (cols/2)+squareSize; j++) {
          this.field[i][j].b = 1;
          //this.newField[i][j].b = 1;
          
        }
      }
    }
    
  }
}
