class ThrowShapes{ 
  private Draw_Ellipse [] qeued;
  private Timer time;
  private String [] strBeats;
  private String [] beatFiles = {"1.txt","2.txt","3.txt","4.txt","5.txt","6.txt","7.txt","8.txt"};
  private float [] throwBeatTimes;
  private float [] realBeatTimes;
  private float tempRealBeat;
  private float tempPastBeat;
  private int realTimeIndex;
  private int pastIndexCount;    
  private int rand;
  private int lastType;
  private int score;
  private int perfect;
  private int okay;
  private int missed;
  private int highestCombo;
  private int combo;
     
  ThrowShapes(int songSelected){      
    strBeats = loadStrings(beatFiles[songSelected]); 
    throwBeatTimes = new float[strBeats.length];
    realBeatTimes = new float[strBeats.length];
    qeued = new Draw_Ellipse[throwBeatTimes.length]; 
    for(int counter = 0;counter < strBeats.length;counter++){                  
    throwBeatTimes[counter] = float(strBeats[counter]) - 2;     
    realBeatTimes[counter] = float(strBeats[counter]); 
    qeued[counter] = new Draw_Ellipse();
    }                   
    time = new Timer(0); 
    tempRealBeat = 0;
    tempPastBeat = 0;
    realTimeIndex = 0; 
    pastIndexCount = 0;                
    rand = 0;
    lastType = 0;   
    score = 0;
    perfect = 0;    
    okay = 0;
    missed = 0;
    highestCombo = 0;
    combo = 0;
 }
           
  public void throwBeats(){           
        time.countUp();      
        syncronize();
        showScore();
    
    for(int counter = 0; counter < pastIndexCount; counter++){ 
      qeued[counter].speedy();
    }
    
    if(pastIndexCount  == throwBeatTimes.length){
      return;
    }    
   
    tempPastBeat = throwBeatTimes[pastIndexCount];
    
    if((tempPastBeat >= (time.getTime() - .025)) && (tempPastBeat <= (time.getTime() +.025))){ // .35 seems effective    , .28 even more accurate , .20 is very effectvie, the boundaries can be changed but it's very accurate at this point.
      fill(100);  
                           
      rand = int(random(1,5.9999));
      
      if(rand == lastType){
      rand = (rand % 5) + 1;       
      }
    
      switch(rand){      // will determine which "landing pad" the ellipses will travel too
        case(1): {
          qeued[pastIndexCount].setSpeed(1);        
          break;
        }
        case(2): {
           qeued[pastIndexCount].setSpeed(2);         
          break;
        }
        case(3): {
          qeued[pastIndexCount].setSpeed(3);                 
          break;
        }
        case(4): {
           qeued[pastIndexCount].setSpeed(4);            
          break;
        }
        default: {
          qeued[pastIndexCount].setSpeed(5);              
          break;
        }          
      }
      pastIndexCount++;
      lastType = rand;
    }
  }
  
  private void syncronize(){     
    if(realTimeIndex < qeued.length){    
      
      tempRealBeat = realBeatTimes[realTimeIndex];
      
      if((tempRealBeat >= (time.getTime() - .3)) && (tempRealBeat  <= (time.getTime() + .3))){     
          if((tempRealBeat >= (time.getTime() - .2)) && (tempRealBeat  <= (time.getTime() + .2) && (qeued[realTimeIndex].getType() == keyCode))){ //&& (keyPressed == true) //      &&   (keyPressed )        (keyCode == qeued[realTimeIndex].getType())
              if((tempRealBeat >= (time.getTime() - .090)) && (tempRealBeat  <= (time.getTime() + .090) && (qeued[realTimeIndex].getType() == keyCode))){                  
                    qeued[realTimeIndex].setBeatStat(1);
                    scoreIncrement(100);
                    realTimeIndex++;    
                    combo++;
                    perfect++;
                    if(combo > highestCombo){
                      highestCombo = combo;
                    }
                     return;                           
              }           
                  qeued[realTimeIndex].setBeatStat(2);
                  scoreIncrement(75);
                  realTimeIndex++;    
                  okay++;
                  combo++;
                  if(combo > highestCombo){
                      highestCombo = combo;
                    }
                  return;              
          }    
      }
      else if(time.getTime() - tempRealBeat > .3){  // too late\
            qeued[realTimeIndex].setBeatStat(3);
            realTimeIndex++;       
            missed++;
            combo = 0;
            return;
            
          }
        //else if(((tempRealBeat - time.getTime()) > .4) && ( (keyPressed)){  //&& ((tempRealBeat - 2.75)
        // qeued[realTimeIndex].setBeatStat(3); 
         //   realTimeIndex++;            
         // return;
    }  
  }
       
  private void scoreIncrement(int points){    
    score += points;        
  }
  
  public void showScore(){
    textSize(50);
    fill(255);
    text("score: " + score,1460,70);   
    text("combo: " + combo,260, 70);   
  }
  
  public float returnTime(){
    return time.getTime();
  }
  
  public void displayResults(){   
 
   fill(0);
   textSize(50);
 
              text("Song: " + library.getSong(gameIndex),350,225);  
              text("Artist: " + library.getArtist(gameIndex),350,300);  
              text("Difficulty: " + library.getDiff(gameIndex),350,375);
              fill(orange);
              text("Total score: " + score,350,450);
              fill(gold);
              text("Perfect: " + perfect,350,525);
              fill(green);
              text("Okay: " + okay,350,600);
              fill(red);
              text("Missed: " + missed,350,675);
              fill(lightBlue);
              text("Highest Combo: " + highestCombo,350,750);    
              text("Beat accuracy : " + (perfect + okay) + " / " + realTimeIndex,350,825);                            
              fill(purple);
              rect(1160,335,400,100);             
              rect(1160,545,400,100);
              fill(0);    
              textSize(25);
              text("back to song select",1260,395);
              text("exit game",1310,600);
  }
     
  private void resetShapes(){
    for(int counter = 0; counter < qeued.length ; counter++){
      qeued[counter].wipeValues();     
    }    
  }
      
  public void resetGame(){    
  resetShapes();
  time.setTime(0);
  realTimeIndex = 0;
  pastIndexCount = 0;      
  score = 0;
  perfect = 0;
  okay = 0;
  missed = 0;
  highestCombo = 0;
  combo = 0;  
  
  }
}
