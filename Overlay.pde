class Overlay{
  private PImage white;
  private PImage black;
  private float vertShift;
   
  Overlay(){   
    white = loadImage("white.jpg");  
    black = loadImage("black.jpg");
    vertShift = 300;   
  }  
  
  public void displayTopButtons(){   
    fill(yellow);
    rect(0,0,50,50,0,0,6,0);    
    fill(red);
    rect(1870,0,50,50,0,0,0,6);  
  }
  
  private void displayOptions(){
    fill(yellow);
    rect(0,0,50,50,0,0,6,0);        
     }
  
  public void displayOverlay(){      
    fill(255,130);
    strokeWeight(7);
    stroke(orange);
    ellipse(1680,290,130,130); // upper right, Q1
    ellipse(240,290,130,130); // upperleft, Q2    
    ellipse(350,710,130,130); //lower left, Q3
    ellipse(1570,710,130,130);  //lower right, Q4
    ellipse(960,965,300,125);    // middle, y-Axis
    noStroke();   
  }
  
  public void inGameOptions(){    
    for(int counter = 1;counter <= 3;counter++){
      fill(purple);
      rect(810, (100*counter) + vertShift, 300 ,50,7);              
    }
        textSize(25);
        fill(0);
         text("resume game",885, (134) + vertShift);
         text("return to menu",882, (234) + vertShift);
         text("exit game",907, (334) + vertShift);             
  }
    
  public void options(){
    for(int counter = 1;counter <= 3;counter++){
      fill(purple);
      rect(810, (100 * counter) + vertShift, 300 ,50,7);              
    }
         textSize(25);
         fill(0);         
         text("back to song select",857.5, (134) + vertShift);   
         text("quick quide",896, (234) + vertShift); 
         text("exit game",907, (334) + vertShift);           
  }
  
   public void white(){
    image(white,0,0);
  }  
      
    public void black(){
     image(black,0,0); 
    }
}
