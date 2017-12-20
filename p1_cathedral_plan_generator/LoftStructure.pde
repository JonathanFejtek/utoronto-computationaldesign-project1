class LoftStructure{
  ArrayList<ParametricPoly> levels = new ArrayList<ParametricPoly>();
  PVector pos;
  int num_lines;
  int num_levels;
  
  LoftStructure(float x, float y, int num_lines, int num_levels){
    this.pos = new PVector(x,y);
    this.num_lines = num_lines;
    this.num_levels = num_levels;
    
    ParametricPoly last_created = null;
    for(int i = 0; i < num_levels; i++){
      ParametricPoly new_level = new ParametricPoly(pos.x,pos.y,num_lines,i);
      levels.add(new_level);
      if(last_created !=null){
        new_level.setConstraintPoly(last_created);
      }
      last_created = new_level;
    }
    
  }
  
  
  void display(){
    for(ParametricPoly p : levels){
      p.displayPolyCurve();
    }
  }
}