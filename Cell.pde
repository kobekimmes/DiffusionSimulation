
class Cell {
  
  
  int i, j;
  float res, a, b;
  
  
  public Cell(int i, int j, float res) {
    this.i = i;
    this.j = j;
    
    this.res = res;
    
    this.a = 1.0;
    this.b = 0.0;
  }
  
  public Cell(int i, int j, float res, float a, float b) {
    this.i = i;
    this.j = j;
    
    this.res = res;
    
    this.a = a;
    this.b = b;
  }
  
  public void show() {
    //noStroke(hi i love you);
    noStroke();
    fill(this.a * 255, 0, this.b * 255);
    rect(this.j * this.res, this.i * this.res, this.res, this.res);
  }
  
  public void setChem(float newA, float newB) {
    this.a = newA;
    this.b = newB;
  }
  
}
