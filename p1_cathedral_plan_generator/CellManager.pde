class CellManager{
  BooleanField boolean_field;
  SplineSpace spline_space;
  ArrayList<SpaceCell> cells = new ArrayList<SpaceCell>();
  ArrayList<SpaceCell> empties = new ArrayList<SpaceCell>();
  
  CellManager(BooleanField bf, SplineSpace sp){
    boolean_field = bf;
    spline_space = sp;
    
  }
  
  void initializeCells(){
    cells.clear();
    for(int j = 0; j < boolean_field.getCellHeight(); j++){
      for(int i = 0; i < boolean_field.getCellWidth(); i++){
        if(boolean_field.get(i,j)){
          PVector[] vecs = spline_space.getPolyCoordinates(j,i);
          SpaceCell s = new SpaceCell(vecs[0],vecs[1],vecs[2],vecs[3]);
          cells.add(s);
          PVector[] vecs2 = spline_space.getPolyCoordinatesRefl(j,i);
          SpaceCell s2 = new SpaceCell((vecs2[0]),vecs2[1],vecs2[2],vecs2[3]);
          cells.add(s2);
        }
      }
    }    
  }
  
  void computeCellTaxonomy(){
    cells.clear();
    empties.clear();
    for(int j = 0; j < boolean_field.getCellHeight(); j++){
      for(int i = 0; i < boolean_field.getCellWidth(); i++){
        if(boolean_field.get(i,j)){
          int type = boolean_field.getVal(i,j);
          boolean north = !boolean_field.get(i,j-1);
          boolean east = !boolean_field.get(i+1,j);
          boolean south = !boolean_field.get(i,j+1);
          boolean west = !boolean_field.get(i-1,j);
          
          boolean has_stained_glass = false;
          
          if(j == 0){
            has_stained_glass = true;
          }
          
          if(j == 1){
            float r = random(4);
            if(r < 2){
              has_stained_glass = true;
            }
          }
          
          if(j > 1){
            float r = random(10);
            if(r < 3){
              has_stained_glass = true;
            }
          }
          
          if(j == 0){
            if(!boolean_field.get(i,j+1)){
              north = true;
             // has_stained_glass = true;
            }
            else{
              north = false;
            }
          }
          
          if(i == ((boolean_field.getCellWidth())-1)){
            if(!boolean_field.get(i+1,j)){
              east = false;
            }
          }
          
          PVector[] vecs = spline_space.getPolyCoordinates(j,i);
          SpaceCell s = new SpaceCell(vecs[0],vecs[1],vecs[2],vecs[3]);
          s.setNorth(north);
          s.setSouth(south);
          s.setEast(east);
          s.setWest(west);
          s.setType(type);
          s.setLevel(j);
          s.has_stained_glass = has_stained_glass;
          cells.add(s);
          
          PVector[] vecs2 = spline_space.getPolyCoordinatesRefl(j,i);
          SpaceCell s2 = new SpaceCell((vecs2[0]),vecs2[1],vecs2[2],vecs2[3]);
          s2.setNorth(north);
          s2.setSouth(south);
          s2.setEast(east);
          s2.setWest(west);
          s2.setType(type);
          s2.setLevel(j);
          s2.has_stained_glass = has_stained_glass;
          cells.add(s2);
        }
        
        
        else{
          if(boolean_field.get(i,j-1)){
            PVector[] vecs = spline_space.getPolyCoordinates(j,i);
            SpaceCell s = new SpaceCell(vecs[0],vecs[1],vecs[2],vecs[3]);
            s.setLevel(j);
            s.displayButtresses = true;
            empties.add(s);
            
            PVector[] vecs2 = spline_space.getPolyCoordinatesRefl(j,i);
            SpaceCell s2 = new SpaceCell(vecs2[0],vecs2[1],vecs2[2],vecs2[3]);
            s2.setLevel(j);
            s2.displayButtresses = true;
            empties.add(s2);
          }
        }
        
        
      }
    } 
  }
  
  void display(){
    for(SpaceCell s : cells){
      s.display2();
    }
    
    for(SpaceCell s : empties){
      s.display2();
    }
    
    for(SpaceCell s : cells){
      s.displayColumns2();
    }
    
  }

}