class BooleanBox{
  float x;
  float y;
  float w;
  float h;
  
  boolean selected = false;
  
  int value =-1;
  
  // 1 : pew space;
  // 2 : statue space
  
  BooleanBox(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display(){
    pushStyle();
    if(selected){
      fill(map(value,0,7,180,0));
    }
    else{
      fill(250);
    }
    rect(x,y,w,h);
    popStyle();
  }
  
  boolean isMousedOver(){
    return (mouseX >= x && mouseX <= x+w) && (mouseY >= y && mouseY <= y+h);
  }
  
  void mousePressed(){
    if(isMousedOver()){
      if(selected && value == 3){
        selected = false;
        value = -1;
      }
      else{
        selected = true;
        value++;
      }
    }
  }
  
  boolean getValue(){
    return selected;
  }
  
  int getVal(){
    return value;
  }
  
  void setVal(int v){
    value = v;
  }
  
  void set(Boolean b){
    selected = b;
  }
  
}