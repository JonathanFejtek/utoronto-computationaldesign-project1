
//documentation can be made available upon request
//After loading a (valid) array, click to visualize structure

//'s' to save current design
//'l' to load an array
//'b' to save an image
//'f' to view array editor
//'r' to view spline field


import processing.pdf.*;

boolean record;

SplineSpace sp;

PrintWriter output;
BufferedReader reader;

BooleanField bf;

CellManager cm;


boolean bf_active = false;
boolean spline_active = false;

void setup(){
  size(1400,800,P2D);
  smooth(16);
  bf = new BooleanField(20,20,200,200,20+8,6);
  sp = new SplineSpace(6,20);
  sp.computeLinear();
  sp.computeCircularPiece();
  cm = new CellManager(bf,sp);
  cm.computeCellTaxonomy();
}

void saveField(){
  selectOutput("Select a file to write to:", "fileSave");
}

void loadField(){
  selectInput("Select a file to process:", "fileLoad");
}

void fileLoad(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String s = selection.getAbsolutePath();
    reader = createReader(s);
    
    for(int j = 0; j < bf.getCellHeight(); j++){
      String level = null;
      String level2 = null;
      try{
       level = reader.readLine();
       level2 = reader.readLine();
      } catch (Exception e){
        
      }
      if(level == null){
        break;
      }
      else{
        String[] booleans = split(level,',');
        String[] vals = split(level2,',');
        for(int i = 0; i < bf.getCellWidth(); i++){
          bf.set(i,j,boolean(booleans[i]));
          bf.setVal(i,j,int(vals[i]));
        }
      }
        
    
  }
  
  }
}

void fileSave(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String s = selection.getAbsolutePath();
    output = createWriter(s);
   for(int j = 0; j < bf.getCellHeight(); j++){
     String level = "";
     String level2 = "";
    for(int i = 0; i < bf.getCellWidth(); i++){
      level += str(bf.get(i,j)) + ',';
      level2 += str(bf.getVal(i,j)) + ',';
    }
    output.println(level);
    output.println(level2);
    
   }
   output.flush();
   output.close();
  }
}

void draw(){
  if(record){
    beginRecord(PDF,"frame-####.pdf");
  }
  colorMode(HSB,255);
  background(100,5,250);
  
  cm.display();
 
 if(bf_active){
   bf.display();
 }
 if(spline_active){
   sp.display();   
 }
 
 if(record){
   endRecord();
   record = false;
 }

}


int im = 0;
void keyPressed(){
  if(key == 's'){
    saveField();
  }
  
  else if(key == 'l'){
    loadField();
  }
  
  else if(key == 'b'){
    save("image" + str(im));
    im++;
  }
  
  else if(key == 'f'){
    bf_active = !bf_active;
  }
  
  else if(key == 'r'){
    spline_active = !spline_active;
  }
  
  else if(key == 'i'){
    record = true;
  }
}


void mousePressed(){
  if(bf_active){
    bf.mousePressed();
  }
  cm.computeCellTaxonomy();
}