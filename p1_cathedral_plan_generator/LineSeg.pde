class LineSeg{
  PVector p1;
  PVector p2;
  
  PVector midPoint;
  
  PVector normal1;
  PVector normal2;
  
  PVector p1_n1;
  PVector p1_n2;
  
  PVector p2_n1;
  PVector p2_n2;
  
  ArrayList<Float> parameters = new ArrayList<Float>();
  ArrayList<PVector> parameter_points = new ArrayList<PVector>();
  
  boolean displayDotted = false;
  
  LineSeg(float x1, float y1, float x2, float y2){
    p1 = new PVector(x1,y1);
    p2 = new PVector(x2,y2);
    findMidPoint();
    findNormal();
  }
  
  LineSeg(PVector p1, PVector p2){
    this.p1 = p1.get();
    this.p2 = p2.get();
    findMidPoint();
    findNormal();
  }
  
  PVector getNormalA(){
    return normal1.get();
  }
  
  PVector getNormalB(){
    return normal2.get();
  }
  
  void displayDotted(){
    line(p1.x,p1.y,p2.x,p2.y);
    for(float i = 0; i < 1.0; i+=1.0/16){
       // PVector posp = getPosAtParam(i);
       // ellipse(posp.x,posp.y,1,1);
    }
  }
  
  void findMidPoint(){
    midPoint = PVector.lerp(p1,p2,0.5);
  }
  
  void display(){
    if(displayDotted){
      line(p1.x,p1.y,p2.x,p2.y);
      for(float i = 0; i < 1.0; i+=1.0/16){
       // PVector posp = getPosAtParam(i);
       // ellipse(posp.x,posp.y,1,1);
      }
    }
    else{
     line(p1.x,p1.y,p2.x,p2.y);
    }
  }
  
  void display(PGraphics g){
     g.line(p1.x,p1.y,p2.x,p2.y);
  }
  
  void displayParameterPoints(){
    for(PVector p : parameter_points){
      ellipse(p.x,p.y,5,5);
    }
  }
  
  void computeParameterPoints(){
    parameter_points.clear();
    for(float p : parameters){
      parameter_points.add(getPosAtParam(p));
    }
  }
  
  void setParameter(int index, float t){
    parameters.set(index,t);
    computeParameterPoints();
  }
  
  void addParameter(float t){
    parameters.add(t);
    computeParameterPoints();
  }
  
  void displayOffset(){
    line(p1_n1.x,p1_n1.y,p2_n1.x,p2_n1.y);
    line(p1_n2.x,p1_n2.y,p2_n2.x,p2_n2.y);
  }
  
  ArrayList<PVector> getParameterPoints(){
    return parameter_points;
  }
  
  PVector getPosAtParam(float t){
    return PVector.lerp(p1,p2,t);
  }
  
  void findNormal(){
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    float magnitude = 1;
    normal1 = new PVector(-dy,dx);
    normal1.setMag(magnitude);
    normal2 = new PVector(dy,-dx);
    normal2.setMag(magnitude);
    p1_n1 = p1.get().add(normal1);
    p1_n2 = p1.get().add(normal2);
    p2_n1 = p2.get().add(normal1);
    p2_n2 = p2.get().add(normal2);
  }
  
  PVector getPosInNormalSpaceA(float u, float v){
    PVector a = getPosAtParam(u);
    PVector b = PVector.add(a,normal1);
    PVector c = PVector.lerp(a,b,v);
    return c;
  }
  
  PVector getPosInNormalSpaceB(float u, float v){
    PVector a = getPosAtParam(u);
    PVector b = PVector.add(a,normal2);
    PVector c = PVector.lerp(a,b,v);
    return c;
  }
  
}