class SpaceCell{
  PShape polyshape;
  
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector p3 = new PVector();
  PVector p4 = new PVector();
  
  PVector pos;
  
  LineSeg l1;
  LineSeg l2;
 LineSeg l3;
 LineSeg l4;
  
  float column_width = 5;
  
  int type = 0;
  int level = 0;
  
  boolean north;
  boolean south;
  boolean east;
  boolean west;
  
  boolean segmented = false; 
  
  LoftStructure statue;
  
  boolean displayColumns = true;
  boolean displayPerimeter = true;
  
  boolean displayButtresses = false;
  
  boolean hasChapel = false;
  
  boolean has_stained_glass = false;
  
  
  
  SpaceCell(PVector p1, PVector p2, PVector p3, PVector p4){
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
    this.p4 = p4;
    
    init();
  }
  
  void setLevel(int l){
    level = l;
  }
  
  void setType(int i){
    type = i; 
    if(type == 2){
      
      setupStatue();
    }
  }
  
  void setupStatue(){
    PVector center = PVector.lerp(p1,p3,0.5);
    statue = new LoftStructure(center.x,center.y,64,4);
  }
  
  void setSegmented(boolean i){
    segmented = i;
  }
  
  SpaceCell(PVector pos){
    this.pos = pos;
    p1 = pos.get().add(-100,-100,0);
    p2 = pos.get().add(-100,100,0);
    p3 = pos.get().add(100,100,0);
    p4 = pos.get().add(100,-100,0);
    
    init();

  }
  
  void init(){
    l1 = new LineSeg(p1,p2);
    l2 = new LineSeg(p2,p3);
    l3 = new LineSeg(p3,p4);
    l4 = new LineSeg(p4,p1);
    
    polyshape = createShape();
    
    polyshape.beginShape();
    polyshape.fill(230);
    polyshape.noStroke();
    polyshape.vertex(p1.x,p1.y);
    polyshape.vertex(p2.x,p2.y);
    polyshape.vertex(p3.x,p3.y);
    polyshape.vertex(p4.x,p4.y);
    polyshape.endShape(CLOSE);
    
    column_width = map(level,0,6,10,3);
  }

  
  void displayPerimeter(){
    if(north){
      if(level == 0 && has_stained_glass){
      l3.displayDotted();
      }
      else{
        l3.display();
      }

    }
    
    if(east){
     l2.display();
    }
    
    if(south){
      if(has_stained_glass){
      l1.displayDotted();
      }
      else{
      l1.display();
      }
      
    }
    
    if(west){
     l4.display();
    }
    
  }
  
  
  void display2(){
    column_width = map(level,0,6,10,3);
    pushStyle();
    polyshape.disableStyle();
    noStroke();
    displayPerimeter = true;
    displayColumns = false;
    hasChapel = false;
    
    if(segmented){
      fill(240);

    }
    else if(displayButtresses){
      noFill();
    }
    else{
      fill(200);
    }
    
    shape(polyshape);
    popStyle();
    

    switch(level){
      case 0: 
          switch(type){
          case 0: break;
         // case 1: displayPew(); break;
         // case 2: displayStatue(); break;
        //  case 3: displayAltar();break;
        }
        
        break;
      case 1: 
          switch(type){
          case 0: break;
         // case 1: break;
         // case 2: displayStatue(); break;
         // case 3: displayVotive(); break;
        }      
        
        break;
      case 2:          
        break;
      case 3: 
          switch(type){
          case 0: break;
         // case 1: displayChapel(); hasChapel = true; break;
         // case 2: displayVotive(); break;
         // case 3: break;
        } 
        break;
        
      case 4: 
          switch(type){
          case 0: break;
         // case 1: displayChapel(); hasChapel = true; break;
         // case 2: displayVotive(); break;
         // case 3: break;
        } 
        break;
      case 5:
          switch(type){
          case 0: break;
         // case 1: displayChapel(); hasChapel = true; break;
         // case 2: displayVotive(); break;
         // case 3: break;
        }       
        break;
      case 6: break;
    }
    
    if(displayPerimeter){
       displayPerimeter();
    }
    
    if(displayButtresses){
      displayButtresses();
    }

    


  }
  
  void displayNullSpace(){
    pushStyle();
    strokeWeight(1);
    fill(100);
    shape(polyshape);
    popStyle();
  }
  
  void displayAltar(){
    for(int i = 3; i >0; i--){
      float offset = i*0.05;
    PVector p1 = getPosAtUV(0.4-offset,0.4-offset);
    PVector p2 = getPosAtUV(0.6+offset,0.4-offset);
    PVector p3 = getPosAtUV(0.6+offset,0.6+offset);
    PVector p4 = getPosAtUV(0.4-offset,0.6+offset);
    pushStyle();
    beginShape();
    fill(160);
    vertex(p1.x,p1.y);
    vertex(p2.x,p2.y);
    vertex(p3.x,p3.y);
    vertex(p4.x,p4.y);
    endShape(CLOSE); 
    popStyle();
    }
  }
  
  void displayChapel(){
   pushStyle();
    beginShape();
    fill(200);
    vertex(p4.x,p4.y);
    for(float i = 0; i <= 1; i+=1.0/8){
      float t = map(i,0,1,0,PI);
      float x = map(cos(t-PI),-1,1,0,1);
      float y = map(sin(t-PI),-1,1,0.5,1);
      PVector p = getPosAtUV(x,y);
      vertex(p.x,p.y);
    }
    vertex(p3.x,p3.y);
    endShape();
    popStyle();
  }
  
  void displayVotive(){
    for(float i = 0.2; i <= 0.8; i+=(0.8-0.2)/8){
      for(float j = 0.2; j < 0.3; j+=(0.4-0.3)/3){
      PVector p = getPosAtUV(i,j);
      pushStyle();
      strokeWeight(0.2);
      fill(100);
      ellipse(p.x,p.y,2,2);
      popStyle();
    }
    }
   
    
  }
  
  void displayStatue(){
   statue.display();
  }
  
  void displayButtresses(){

    for(int i = 0; i <= 1; i++){
    PVector top_c = getPosAtUV(i,0.5);
    PVector bot_c = getPosAtUV(i,1);
    pushStyle();
    //strokeWeight(3);
   // line(top_c.x,top_c.y,bot_c.x,bot_c.y);
    popStyle();
    }

  }
  
  
    


  
  void displayColumns2(){
    boolean perimeter_space = (north || south || east || west);
    pushStyle();
    fill(0);
    if(perimeter_space && displayColumns){
     ellipse(p1.x,p1.y,column_width,column_width);
     ellipse(p2.x,p2.y,column_width,column_width);
     ellipse(p3.x,p3.y,column_width,column_width);
     ellipse(p4.x,p4.y,column_width,column_width);
    }
    popStyle();
  }
  
  void setNorth(boolean i){
    north = i;
  }
  
  void setEast(boolean i){
    east = i;
  }
  
  void setSouth(boolean i){
   south = i;
  }
  
  void setWest(boolean i){
    west = i;
  }
  
  
  void displayPew(){
    for(int j = 1; j < 4; j++){
      PVector top_c = PVector.lerp(p1,p2,j*0.25);
      PVector bot_c = PVector.lerp(p4,p3,j*0.25);
      LineSeg pew_area = new LineSeg(top_c,bot_c);
      for(float i = 5*(1.0/50); i < 1.0-(5*(1.0/50)); i+=1.0/50){
        PVector person_pos = pew_area.getPosAtParam(i);
        ellipse(person_pos.x,person_pos.y,4,4);
    }
    }
  }
  
  PVector getPosAtUV(float u, float v){
    PVector top_h = PVector.lerp(p1,p2,u);
    PVector bot_h = PVector.lerp(p4,p3,u);
    
    LineSeg helper_u = new LineSeg(top_h,bot_h);
    
    return helper_u.getPosAtParam(v);
    
  }
  
}