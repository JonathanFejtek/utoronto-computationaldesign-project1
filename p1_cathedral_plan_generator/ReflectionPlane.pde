class ReflectionPlane{
  float y_pos;
  float y_pos_initial;
  ReflectionPlane(float y){
    y_pos_initial = y;
    this.y_pos = map(y,0,height,-height/2,height/2);
  }
  
  void display(){
    line(0,height/2+y_pos,width,height/2+y_pos);
  }
  
   PVector getReflectedY(float x, float y){
    return new PVector(x,(-y+height)+(2*y_pos));
  }
  
   PVector getReflectedY(PVector p){
    return new PVector(p.x,(-p.y+height)+(2*y_pos));
  }
  
}