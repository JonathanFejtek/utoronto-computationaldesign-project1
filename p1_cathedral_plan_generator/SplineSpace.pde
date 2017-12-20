class SplineSpace{
  
  ArrayList<Spline> splinesA = new ArrayList<Spline>();
  ArrayList<Spline> splinesB = new ArrayList<Spline>();
  
  float draw_height = 100;
  float draw_width = 75;
  
  int len;
  int levels;
  
  ReflectionPlane rp;
 
  
  SplineSpace(int levels, int len){
    this.levels = levels;
    this.len = len;
    rp = new ReflectionPlane(height/2);
    
    for(int i = 0; i < levels; i++){
      
      Spline s_a = new Spline();
      Spline s_b = new Spline();
      splinesA.add(s_a);
      splinesB.add(s_b);
    }
  }
  
  void reset(){
    splinesA.clear();
    splinesB.clear();
    for(int i = 0; i < levels; i++){
      
      Spline s_a = new Spline();
      Spline s_b = new Spline();
      splinesA.add(s_a);
      splinesB.add(s_b);
    }    
  }
  
  PVector[] getPolyCoordinates(int l, int t){
    float offset = 1*(1.0/len);
    if(l == 0){
      Spline s1 = splinesA.get(l);
      Spline s2 = splinesB.get(l);
       PVector p1 = s1.getPosAtParam(t*(1.0/len));
       PVector p2 = s1.getPosAtParam(t*(1.0/len) +offset);
       PVector p3 = s2.getPosAtParam(t*(1.0/len) +offset);
       PVector p4 = s2.getPosAtParam(t*(1.0/len));
       return new PVector[] {p1,p2,p3,p4};
    }
    else{
      Spline s1 = splinesA.get(l);
      Spline s2 = splinesA.get(l-1);
       PVector p1 = s1.getPosAtParam(t*(1.0/len));
       PVector p2 = s1.getPosAtParam(t*(1.0/len) +offset);
       PVector p3 = s2.getPosAtParam(t*(1.0/len) +offset);
       PVector p4 = s2.getPosAtParam(t*(1.0/len));     
     return new PVector[] {p1,p2,p3,p4};
   }

  }
  
  PVector[] getPolyCoordinatesRefl(int l, int t){
    float offset = 1*(1.0/len);
    if(l == 0){
      Spline s1 = splinesA.get(l);
      Spline s2 = splinesB.get(l);
       PVector p1 = s1.getPosAtParam(t*(1.0/len));
       PVector p2 = s1.getPosAtParam(t*(1.0/len) +offset);
       PVector p3 = s2.getPosAtParam(t*(1.0/len) +offset);
       PVector p4 = s2.getPosAtParam(t*(1.0/len));
       return new PVector[] {p1,p2,p3,p4};
    }
    else{
      Spline s1 = splinesA.get(l);
      Spline s2 = splinesA.get(l-1);
       PVector p1 = rp.getReflectedY(s1.getPosAtParam(t*(1.0/len)));
       PVector p2 = rp.getReflectedY(s1.getPosAtParam(t*(1.0/len) +offset));
       PVector p3 = rp.getReflectedY(s2.getPosAtParam(t*(1.0/len) +offset));
       PVector p4 = rp.getReflectedY(s2.getPosAtParam(t*(1.0/len)));     
     return new PVector[] {p1,p2,p3,p4};
   }

  }
  
  
  void computeLinear(){
    for(int l = 0; l < levels; l++){
       Spline s_1 = splinesA.get(l);
       Spline s_2 = splinesB.get(l);
      for(int i = 0 ; i < len; i++){
        float dh = map(l,0,levels,100,50);
        float t = map(i, 0, len, 0, TWO_PI);
        float v = map(sin(i/4.0), -1, 1, 10, 70);
        v = 0;
        PVector p1 =new PVector(i*45+45,((l+1)*dh-v)+height/2);
        s_1.add(p1);
        PVector p2 = rp.getReflectedY(p1.x,p1.y);
        s_2.add(p2);
       }
    }
  }
  
  void computeCircularPiece(){
    for(int l = 0; l < levels; l++){
      Spline s_1 = splinesA.get(l);
       Spline s_2 = splinesB.get(l);
      for(int i = 8; i >= 0; i--){
       float dh = map(l,0,levels,100,50);
        float amp = dh*(l+1);
        float t = map(i,0,8,0,PI/2);
        float x = amp*sin(t+2*PI/4)+(len*45)+45;
        float y = amp*cos(t+2*PI/4)+height/2;
        PVector p2 =new PVector(x,y);
       // println(p1);
        
        PVector p1 = rp.getReflectedY(p2.x,p2.y);
        s_2.add(p2);
        s_1.add(p1);
      }
    }
    len +=8;
  }
  
  void display(){
    for(Spline s : splinesA){
      s.display();
    }
    
    for(Spline s : splinesB){
      s.display();
    }
  }
 
}