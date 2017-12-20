class ParametricPoly{
  PVector pos;
  ArrayList<LineSeg> strutlines = new ArrayList<LineSeg>();
  float size = 5;
  ArrayList<Float> parameters = new ArrayList<Float>();
  ArrayList<PVector> parameter_points = new ArrayList<PVector>();

  ParametricPoly child;
  ParametricPoly parent;
  int level;
  
  ParametricPoly(float x, float y, int num_lines, int level){
    this.level = level;
    this.pos = new PVector(x,y);
    this.size = map(level,0,4,13,2);
    
    float iter = TWO_PI/num_lines;
    for(int i = 0; i < num_lines; i++){
      PVector radial_pos = new PVector(pos.x+size*cos(i*iter),pos.y+size*sin(i*iter));
      LineSeg new_strut = new LineSeg(pos.x,pos.y,radial_pos.x,radial_pos.y);
      float t = map(i,0,num_lines,0,TWO_PI);
      float v = map(sin(7*t),-1,1,0.9,1);
      parameters.add(v);
      parameter_points.add(new_strut.getPosAtParam(t));
      strutlines.add(new_strut);
    }
     updateParameters();
  }
  
  
  void displayParameterPoints(){
    for(PVector p : parameter_points){
      ellipse(p.x,p.y,5,5);
    }
  }
  
  void setParameterValues(float[] floats){
    for(int i = 0; i < floats.length && i < parameter_points.size(); i++){
      parameter_points.get(i).set(strutlines.get(i).getPosAtParam(floats[i]));
    }
  }
  
  void updateParameters(){
    int i = 0;
    for(float p : parameters){
      parameter_points.get(i).set(strutlines.get(i).getPosAtParam(p));
      i++;
    }
  }
  
  
  
  void displayStrutlines(){
    for(LineSeg strut : strutlines){
      strut.display();
    }
  }
  
  void displayPolyLinear(){
    for(int i = 1; i < parameter_points.size(); i++){
      PVector p1 = parameter_points.get(i-1);
      PVector p2 = parameter_points.get(i);
      line(p1.x,p1.y,p2.x,p2.y);
    }
    PVector p1 = parameter_points.get(0);
    PVector p2 = parameter_points.get(parameter_points.size()-1);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  
  void displayPolyCurve(){
    pushStyle();
    fill(100,25);
    beginShape();
    for(PVector p : parameter_points){
      curveVertex(p.x,p.y);
    }
    PVector p_last = parameter_points.get(0);
    PVector p_next1 = parameter_points.get(1);
    PVector p_next2 = parameter_points.get(2);
   curveVertex(p_last.x,p_last.y);
   curveVertex(p_next1.x,p_next1.y);
   curveVertex(p_next2.x,p_next2.y);
   endShape(CLOSE);
   popStyle();
  }
  
  void setConstraintPoly(ParametricPoly p){
    this.parent = p;
    p.child = this;
  }

}