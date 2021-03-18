class Draw_Ellipse{ 
private float xVel;
private float yVel;
private float xPos;
private float yPos;
private float Width;
private float Height;
private float incFactor;
private int type;
private int beatStat;
 
   Draw_Ellipse(){  
xPos = 960;
yPos = 540;
Width = 0;
Height = 0;
incFactor = 3;
type = 0;
beatStat = 0;
}

public void setSpeed(int select){
  switch(select){    //currently 2 second travel time
    case(1):{                                                                            // 2.5 seconds beat travel
           xVel = -5.08333333;                 //+                                                     // -4.066666667;        
           yVel = 1.416666667;              //-                                                         //1.133333333;
           type = leftshift;
           break;
    }
    case(2):{
            xVel = -6;              //-                                                              //-4.8;  
            yVel = -2.083333333;                   //-                                                           //-1.6666666667;
            type = tab;
            break;
    }
    case(3):{
            xVel = 5.08333333;              //+                                                                   //4.066666667;   
            yVel = 1.416666667;            //+                                                                       //1.133333333;
            type = enter;
            break;
    }
    case(4):{
            xVel = 6;         //+                                                                             //4.8;
            yVel =    -2.083333333;            //-                                                                    //-1.6666666667;
            type = backspace;
            break;
    }    
    default:{
      xVel = 0;
      yVel =  3.541666667;                                                                                             //2.833333333;
      type = spacebar;
      break;
    }    
    }
  }   

public void speedy(){
fill(lightBlue);
if(incFactor < 100){
incFactor += 1;
}  
if((beatStat != 0) || ((type == backspace && xPos > 1740) ||(type == tab && xPos < 180) ||(type == leftshift && xPos < 290) ||(type == enter && xPos > 1630)
|| (type == spacebar && yPos > 1005))){
  if(beatStat == 1){
    fill(gold);
    incFactor -=2;
  }
  else if(beatStat == 2){
    fill(green);
    incFactor -=2;
  }
  else{
   fill(red);    
  }
  
}
xPos += xVel;
yPos += yVel;
if((xPos != 960 && yPos!= 540) || (yPos != 540)){
  if(type == spacebar){
   ellipse(xPos, yPos, Width + (incFactor * 2.45), Height + incFactor);
    return;
 }
  else{
  ellipse(xPos, yPos, Width + incFactor, Height + incFactor);
  return;
 }
}
}

public void setBeatStat(int state){
  beatStat = state;    
}
public int getBeatStat(){
  return beatStat;
  
}
public float xPosition(){
  return xPos;
}

public float yPosition(){
  return yPos;
}

public int getType(){
  return type; 
}
public void wipeValues(){
xPos = 960;
yPos = 540;
Width = 0;
Height = 0;
incFactor = 3;
type = 0;  
beatStat = 0;
}
}
