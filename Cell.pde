
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
  
  public void show() {
    //noStroke(hi i love you);
    noStroke();
    float c;
    fill(floor((this.b + this.a)/2 * 255));
    rect(this.i * this.res, this.j * this.res, this.res, this.res);
  }
  
  public void setChem(float newA, float newB) {
    this.a = newA;
    this.b = newB;
  }
  
}
