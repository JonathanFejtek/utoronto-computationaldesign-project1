class Spline{
  ArrayList<PVector> cpoints = new ArrayList<PVector>();
  ArrayList<PVector> b_cpoints = new ArrayList<PVector>();
  ArrayList<PVector> points = new ArrayList<PVector>();
 ArrayList<PVector> normalsA = new ArrayList<PVector>();
 ArrayList<PVector> normalsB = new ArrayList<PVector>();
 ArrayList<LineSeg> segments = new ArrayList<LineSeg>();
 
  PShape curve_image;
  
  Spline(){
    curve_image = createShape();
  }
  
  void add(PVector p){
    cpoints.add(p);
    computeDrawPoints();
    computeCurveImage();
    computeCurvePoints();
    computeCurveSegments();
    computeCurveNormals();
  }
  
  void computeCurveNormals(){
    normalsA.clear();
    normalsB.clear();
    for(LineSeg seg : segments){
      normalsA.add(seg.getNormalA());
      normalsB.add(seg.getNormalB());
    }
  }
  
  void computeCurveSegments(){
    segments.clear();
    for(int i = 1; i < points.size(); i++){
      PVector p1 = points.get(i-1);
      PVector p2 = points.get(i);
      LineSeg seg = new LineSeg(p1,p2);
      segments.add(seg);
    }
  }

  
  void computeDrawPoints(){
    b_cpoints.clear();
    PVector first = cpoints.get(0);
    b_cpoints.add(first);
    for(PVector p : cpoints){
      b_cpoints.add(p);
    }
    PVector last= cpoints.get(cpoints.size()-1);
    b_cpoints.add(last);
  }
  
  void computeCurveImage(){
    curve_image = createShape();
    
    curve_image.beginShape();
    curve_image.noFill();
    PVector first = cpoints.get(0);
    curve_image.curveVertex(first.x,first.y);
    for(PVector p : cpoints){
      curve_image.curveVertex(p.x,p.y);
    
    }
    PVector last= cpoints.get(cpoints.size()-1);
    curve_image.curveVertex(last.x,last.y);
    curve_image.endShape();
  }
  
  void computeCurvePoints(){
    try{
      points.clear();
      ArrayList<PVector> overlap = new ArrayList<PVector>();
      for(int i = 0; i < b_cpoints.size()-3; i+=1){
        PVector p1 = b_cpoints.get(i);
        PVector p2 = b_cpoints.get(i+1);
        PVector p3 = b_cpoints.get(i+2);
        PVector p4 = b_cpoints.get(i+3);
        for(float t = 0; t <= 1.0; t+=1.0/128){
          float x = curvePoint(p1.x,p2.x,p3.x,p4.x,t);
          float y = curvePoint(p1.y,p2.y,p3.y,p4.y,t);
          PVector point = new PVector(x,y);
          boolean overlapped = false;
          for(PVector p : overlap){
            if(p.x == x && p.y == y){
              overlapped = true;
            }
          }
          if(!overlapped){
            points.add(point);
            overlap.add(point);
          }

        }
      }
    } catch(Exception e){
      println(e);
    }
    
  }
  
  PVector getPosAtParam(float t){
    int index = (int)map(t,0,1,0,points.size()-1);
    return points.get(index);
  }
  
  PVector getNormalAAtParam(float t){
    int index = (int)map(t,0,1,0,normalsA.size()-1);
    return normalsA.get(index);
  }
  
  PVector getNormalBAtParam(float t){
    int index = (int)map(t,0,1,0,normalsB.size()-1);
    return normalsB.get(index);
  }
  
  PVector getPosInNormalSpaceA(float u, float v){
    PVector ps = getPosAtParam(u);
    PVector n = getNormalAAtParam(u);
    
    PVector e = ps.get().add(n.get().mult(v));;
    return e;
  }
  
  PVector getPosInNormalSpaceB(float u, float v){
    PVector ps = getPosAtParam(u);
    PVector n = getNormalBAtParam(u);
    
    PVector e = ps.get().add(n.get().mult(v));;
    return e;
  }
  
  void display(){
    stroke(0);
    shape(curve_image);

  }
  
  void display(PGraphics g){
    stroke(0);
    
    for(LineSeg s : segments){
      s.display(g);
      
    }
    
    for(PVector p : cpoints){
      g.ellipse(p.x,p.y,5,5);
    }

  }
    
}