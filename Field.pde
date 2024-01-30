

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
    this.newField = new Cell[rows][cols];

    this.f = 0.055;
    this.k = 0.062;
    this.dA = 1.0;
    this.dB = 0.5;
  }


  public void initField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        Cell c = new Cell(i, j, this.res);
        this.field[i][j] = c;
        c.setChem(0, 0);
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
        float newA = a + ((this.dA * this.laplace(c, true)) - (a * (b * b)) + (this.f * (1 - a)));
        float newB = b + ((this.dB * this.laplace(c, false)) + (a * (b * b)) - ((this.k + this.f) * b));

        //println("new: ", newA, newB);

        this.newField[i][j].a = newA;
        this.newField[i][j].b = newB;
      }
    }
  }

  public void updateField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.field[i][j] = this.newField[i][j];
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

  public void swapField() {
    Cell[][] temp = this.field;
    this.field = this.newField;
    this.newField = temp;
  }
  
  public int wrap(int x, int limit) {
    return (x + limit) % limit;
  }

  public float laplace(Cell cell, boolean a) {
    int[] xDir = new int[]{-1, 0, 1, -1, 1, -1, 0, 1, 0};
    int[] yDir = new int[]{-1, -1, -1, 0, 0, 1, 1, 1, 0};

    int i = cell.i;
    int j = cell.j;

    int sum = 0;

    for (int k = 0; k < 9; k++) {
      int x = wrap(i + xDir[k], rows);
      int y = wrap(j + yDir[k], cols);
      if (a) {
        if ((xDir[k] == 0) ^ (yDir[k] == 0)) {
          //println(k, "axial", xDir[k], yDir[k]);
          sum += (this.field[x][y].a) * 0.9;
        
        } else if ((xDir[k] != 0) && (yDir[k] != 0)) {
          //println(k, "diag", xDir[k], yDir[k]);
          sum += (this.field[x][y].a) * 0.05;
          
        } else {
          //println(k, "self", xDir[k], yDir[k]);
          sum -= (this.field[x][y].a);
          
        }
      } 
      else {
        if ((xDir[k] == 0) ^ (yDir[k] == 0)) {
          sum += (this.field[x][y].b) * 0.1;
          
        } else if ((xDir[k] != 0) && (yDir[k] != 0)) {
          sum += (this.field[x][y].b) * 0.05;
          
        } else {
          sum -= this.field[x][y].b;
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
      this.newField[y][x].b += 0.5;
      this.newField[y][x].a = 0.0;
    }
  }

  public void seed(boolean random) {
    if (random) {
      int rX = (int) random(this.rows);
      int rY = (int) random(this.cols);

      this.field[rX][rY].b = 1;
      this.field[rX][rY].a = 0;
      //this.newField[rX][rY].b = 1;
    } else {
      int squareSize = 5;
      for (int i = (rows/2)-squareSize; i < (rows/2)+squareSize; i++) {
        for (int j = (cols/2)-squareSize; j < (cols/2)+squareSize; j++) {
          this.field[i][j].b = 1;
          this.field[i][j].a = 0;
          //this.newField[i][j].b = 1;
        }
      }
    }
  }
}
