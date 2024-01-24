
class Cell {
  
  
  int i, j;
  float res, a, b;
  
  
  public Cell(int i, int j, float res) {
    this.i = i;
    this.j = j;
    
    this.res = res;
    
    this.a = 1.0;
    this.b = 0;
    
    
  }
  
  public void show() {
    stroke(0);
    rect(this.i * this.res, this.j * this.res, this.res, this.res);
  }
  
  
  
  
  
  
}
