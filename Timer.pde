//This class will help keep Time, time is tied to frame rates, not the most elegant or accurate method. /////////////// GOLDEN ////////////////
class Timer{  
  float Time;  
  Timer(float set){  //creates Timer object with a variable containing time.
    Time = set;    
  }  
  public float getTime(){  // return Time instance variable
    return Time;    
  }    
  public void setTime(float set){  // sets the Time instance variable to arguement passed
    Time = set;
  }  
  public void countUp(){      // increases Time by (1/60) 
    Time += 1/frameRate;    
  }  
  public void countDown(){    // decreases Time by (1/60);
    Time -= 1/frameRate;    
  }    
}
