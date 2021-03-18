public class Transition{  
  private PImage white;
  private PImage black;
  float [] opacs;
    
  Transition(){          
    white= loadImage("white.jpg");  
    black = loadImage("black.jpg");
    opacs = new float[20];
    for(int index = 0; index < 10;index++){
      opacs[index] = 0f;
    }
  }
   
  public void fadeWhite(int opacPos,float fadeFactor){ 
    if(opacs[opacPos] <= 255){
      opacs[opacPos] += fadeFactor;
    }
    tint(255,255,255,opacs[opacPos]);    
    image(white,0,0);        
  }
  
  public void fadeBlack(int opacPos,float fadeFactor){ 
    if(opacs[opacPos] <= 255){
      opacs[opacPos] += fadeFactor;
    }
    tint(255,255,255,opacs[opacPos]);    
    image(black,0,0);        
  } 
}
    
    
  
  
  
