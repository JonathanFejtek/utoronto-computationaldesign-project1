class BooleanField{
  BooleanBox[][] field;
  float x;
  float y;
  float w;
  float h;
  
  float w_div;
  float h_div;
  
  int num_w;
  int num_h;
  
  BooleanField(float x, float y, float w, float h, int num_w, int num_h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.num_w = num_w;
    this.num_h = num_h;
    
    w_div = w/num_w;
    h_div = h/num_h;
    field = new BooleanBox[num_w][num_h];
    
    for(int i = 0; i < num_w; i++){
      for(int j = 0; j < num_h; j++){
        BooleanBox new_box = new BooleanBox(x+(i*w_div),y+(j*h_div),w_div,h_div);
        field[i][j] = new_box;
      }
    }
  }
  
  int getCellWidth(){
    return num_w;
  }
  
  int getCellHeight(){
    return num_h;
  }
  
  void set(int i, int j, boolean b){
    field[i][j].set(b);
  }
  
  ArrayList<Boolean> getRow(int index){
    
    ArrayList<Boolean> b = new ArrayList<Boolean>();
    for(int i = 0; i < field.length; i++){
      b.add(field[i][index].getValue());
    }
    return b;
  }
  
  boolean get(int i, int j){
    try{
      return field[i][j].getValue();
    } catch(Exception e){
      return false;
    }
  }
  
  int getVal(int i, int j){
      try{
      return field[i][j].getVal();
    } catch(Exception e){
      return -1;
    }
  }
  
 void setVal(int i, int j, int v){
   try{ field[i][j].setVal(v);
   } catch (Exception e){
     
   }
 }
 
 void mousePressed(){
   if(isMousedOver()){
    for(int i = 0; i < num_w; i++){
      for(int j = 0; j < num_h; j++){
        field[i][j].mousePressed();
      }
    }     
   }
 }
 
 void display(){
    for(int i = 0; i < num_w; i++){
      for(int j = 0; j < num_h; j++){
        field[i][j].display();
      }
    }    
 }
  
  
  boolean isMousedOver(){
    return (mouseX >= x && mouseX <= x+w) && (mouseY >= y && mouseY <= y+w);
  }  
  
  
}