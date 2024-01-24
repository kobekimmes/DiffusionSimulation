

class Field {
  
  
  int rows, cols, res;
  Cell[][] field, newField;
  
  public Field(int rows, int cols, int res) {
    this.rows = rows;
    this.cols = cols;
    this.res = res;
    
    this.field = new Cell[rows][cols];
    this.newField = field;
  }
  
  
  public void initField() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.field[i][j] = new Cell(i, j, this.res);
      }
    }
  }
  
  public void evalField() {
    
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
  
  public void laplace(boolean a) {
    if (a) {
      
    }
  }
}
