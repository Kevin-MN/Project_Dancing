import processing.video.*;  // import librarys to display videos and audio.
import ddf.minim.*;

// Movie array that will contain  for displaying video.
Movie [] movies;

// Minim object for loading audio files.
Minim minim;

// AudioPlayer objects(s) that contain main menu music, soundFX, and ?
AudioPlayer menuMusic; 
AudioPlayer clickFX;
AudioPlayer options; 
AudioPlayer resultSong;

// used for "throwing" shapes, and score tracking
ThrowShapes [] games; 

// Images that will be displayed through out game. 
PImage disclaimer;
PImage load2;
PImage load3;
PImage startScreenImage;
PImage resultsScreen;
PImage howTo;

//This object contains fade ins/outs
Transition gameStart;

// This is the overlay for the beat during "showtime" (gameplay)
Overlay overlay; 

// This object will store the songs information and draw shelf graphics. 
public Song_Shelf library;   

//Timer object for keeping time, helps with transitions
Timer introTime;

//Array that contains names of movie files, will be used by the Movies [] movies which will help with show time
public String [] movieNames = {"1.mov","2.mov","3.mov","4.mov","5.mov","6.mov","7.mov"};

//color constants that can be shared by all classes
public color lightBlue = color(66,218,242) ;
public color yellow = color(255,255,0);
public color red = color(255,0,0);
public color green = color(0,255,0);
public color gold = color(255,223,0);
public color purple = color(171,7,165);
public color darkred = color(163,0,0);
public color orange = color(255,165,0);


// booleans used to tell draw() function what "scene" to display,  maybe move scene selection to a seperate class?  
public boolean intro = true;
public boolean startScreen = false;
public boolean songSelect = false;
public boolean showTime = false;
public boolean results = false;
public boolean optionMenu1 = false;
public boolean optionMenu2 = false;
public boolean howToPlay = false;

public final int backspace = 8;
public final int enter = 10;
public final int leftshift = 16;
public final int tab = 9;
public final int spacebar = 32;

public int gameIndex = 0;
public int gameOpacs = 6;

public void settings(){ // This game is optimized for 1920x1080, this is due to the nature of the animations and how they were created based on the resolution. ie the animations are tied to the resolution, not modular/dynamic
  fullScreen(FX2D);  // FX2D renderer best available   ----- IF game is not running on a 1920x1080 system, then the size(x-resolution, y-resolution, renderer) method can be used to downscale it to 1920,1080. Other wise fullscreen(renderer) can can be used.
}

public void setup(){   // This function is the first thing to be called upon program execution, used for loading the games assets, setting up environmentm and variables.
frameRate(60);
//Initialize movie objects in movies array.
//for(int counter = 0; counter < movieNames.length;counter++){
 movies = new Movie[movieNames.length];
 for(int counter = 0; counter < movieNames.length;counter++){
  movies[counter] = new Movie(this, movieNames[counter]);  /////////////////////////////////////// null pointer
}

//Create Minim audio handling object, needed to load songs.
minim = new Minim(this);    

//load music into AudioPlayer objects
menuMusic = minim.loadFile("OrdinaryDays.mp3");
clickFX = minim.loadFile("BFX.mp3");
options = minim.loadFile("AsYou.mp3");
resultSong = minim.loadFile("ResultSong.mp3");

//load all images used throughout the game.
disclaimer = loadImage("disclaimer.jpg");
load2 = loadImage("load2.jpg"); 
load3 = loadImage("load3.jpg");
startScreenImage = loadImage("startScreen.jpg");
howTo = loadImage("howTo.jpg");

//Construct the Song Shelf to 
library = new Song_Shelf();

//Construct objects that will throw shapes, into an array.
games = new ThrowShapes[library.getShelfLength()];
  for(int counter = 0; counter < library.getShelfLength();counter++){
    games[counter] = new ThrowShapes(counter);    
  }

// Construct object that will play animations
gameStart = new Transition();

// Construct overlay object that will display the grid for the beats.
overlay = new Overlay();

//Timer for the length of the intro sequence
introTime = new Timer(17.8); // magic number for beat drop of menu music
}

public void draw(){
  
    noStroke();    
  if(intro == true){  // this part for disclaimer, fadeIns and fadeOuts, and message from team    this block is good but may want to adjust times for fade ins 
     
      //intro = false;
     // startScreen = true;
      menuMusic.play();    
      introTime.countDown();
    
    if(int(introTime.getTime()) >= 10){        
      gameStart.fadeWhite(0,4);
      image(disclaimer,0,0); 
      return;
    }
          
    if(int(introTime.getTime()) < 10 && int(introTime.getTime()) >= 8.5){         
      image(disclaimer,0,0);
       gameStart.fadeWhite(1,12); 
       return;
    }
     
    if(int(introTime.getTime()) < 8.5  && int(introTime.getTime())>= 6.375){
      gameStart.fadeWhite(2,4);
      image(load2,0,0);   
      return;
    }
          
    if(int(introTime.getTime()) <  6.375 && int(introTime.getTime()) >= 4.25){
      image(load2,0,0);
      gameStart.fadeWhite(3,4); 
      return;
    }   
    
     if(int(introTime.getTime()) <  4.25 && int(introTime.getTime()) >= 2.125){     
      gameStart.fadeWhite(4,4); 
      image(load3,0,0);
      return;
    }   
    
     if(int(introTime.getTime()) <  2.125 && int(introTime.getTime()) > 0){
      image(load3,0,0);
      gameStart.fadeWhite(5,4); 
      return;
    }   
    
    if(int(introTime.getTime()) <= 0){      
      intro = false;
      startScreen = true; 
       return;
    }   
  }      
    
  if(optionMenu1 == true){  // non ingame option menu  //displays the non in-game options screen          needs work!!!!!!!!!!!!
    overlay.white();
    overlay.options();    
   return; 
  }
  
  if(optionMenu2 == true){  //ingame option menu      // needs work!!!!!!!!!!!!!!!!
    overlay.white();
    overlay.inGameOptions();
    return;
  }
  
  if(howToPlay == true){
     image(howTo,0,0);
    overlay.displayOptions();
  }
  
  if(startScreen == true){  //starting screen
    gameStart.fadeWhite(6,12);
    image(startScreenImage,0,0);     
    return;    
  }
  
  if(songSelect == true){  // song select screen    
    menuMusic.play();
    background(lightBlue);   
    library.displaySongs();
    overlay.displayTopButtons();
    return;   
  }
  
  if(showTime == true){  //in-game screen for selected song    
    movies[gameIndex].play(); 
   image(movies[gameIndex],0,0,1920,1080);       
     games[gameIndex].throwBeats(); 
   overlay.displayOverlay();
     overlay.displayOptions();       
    if(games[gameIndex].returnTime() >= (movies[gameIndex].duration())){
    movies[gameIndex].stop();   
    resultSong.loop();
    gameOpacs++;
    showTime = false;
    results = true;
    return;
} 
 return;
}
    
   if(results == true){   
     gameStart.fadeBlack(gameOpacs,2.5);
     overlay.white();
    games[gameIndex].displayResults();      
    return;
  }  
  }
    
public void mousePressed(){  

if(startScreen == true || songSelect == true || optionMenu1 == true || howToPlay == true || results == true){  // plays mouse click if in startscreen or song select only
  clickFX.play();
  clickFX.rewind();
}
}

public void mouseClicked(){
  
  if(songSelect == true && mouseX >= 1875 && mouseY <= 50){  // this block states : if both intro and start screen are false and the mouse is being clicked in top right corner, exit and stop all audio.
      minim.stop();
      exit();
   }   
      
  if(startScreen == true){  // if on starting screen and mouse clicked, go to song select
    startScreen = false;
    songSelect = true; 
    return;
  }
  
  if(intro == true){
    intro = false;
    startScreen = true;
    return;
  }
  
  if(songSelect == true && mouseX > 0 && mouseY > 0 && mouseX < 50 & mouseY <50){  // if in song select and press options, go to options1
    menuMusic.pause();    
    options.loop();
    songSelect = false;
    optionMenu1 = true;   
    return;
  }
  
 if(optionMenu1 == true){
     if(mouseX > 810 && mouseX < 1210 && mouseY > 400 && mouseY < 450){
         options.pause();
         options.rewind();
         menuMusic.play();
         optionMenu1 = false;
         songSelect = true;    
         return;     
     }
     if(mouseX > 810 && mouseX < 1210 && mouseY > 500 && mouseY < 550){
       optionMenu1 = false;
       howToPlay = true;  
       return;
     }
      if(mouseX > 810 && mouseX < 1210 && mouseY > 600 && mouseY < 650){
        minim.stop();
        exit();        
      }   
 }
 
 if(howToPlay == true && mouseX > 0 && mouseY > 0 && mouseX < 50 & mouseY <50){
   howToPlay = false;
   optionMenu1 = true;
   return;   
 }
  
    
  if(songSelect == true){
     if(mouseX >= 100 && mouseY >= 100 && mouseX <= 400 && mouseY <= 200){  //showtime 1
    menuMusic.pause();
    gameIndex = 0;
    songSelect = false;    
    showTime = true;
    return;
    }
     
    if( mouseX >= 100 && mouseY >= 300 && mouseX <= 400 && mouseY <= 400 ){   //showtime 2
    menuMusic.pause();
    gameIndex = 1;
    songSelect = false;    
    showTime = true;    
    return;
   }
               
       
  if(mouseX >= 100 && mouseY >= 500 && mouseX <= 400 && mouseY <= 600 ){  //showtime 3
    menuMusic.pause();
    gameIndex = 2;
    songSelect = false;  
    showTime = true;   
    return;
   }   
   if(mouseX >= 100 && mouseY >= 700 && mouseX <= 400 && mouseY <= 800){  //showtime 1
    menuMusic.pause();
    gameIndex = 3;
    songSelect = false;    
    showTime = true;
    return;
    }
     
    if( mouseX >= 500 && mouseY >= 100 && mouseX <= 800 && mouseY <= 200 ){   //showtime 2
    menuMusic.pause();
    gameIndex = 4;
    songSelect = false;    
    showTime = true;    
    return;
   }
                      
  if(mouseX >= 500 && mouseY >= 300 && mouseX <= 800 && mouseY <= 400 ){  //showtime 3
    menuMusic.pause();
    gameIndex = 5;
    songSelect = false;  
    showTime = true;   
    return;
   }   
   if(mouseX >= 500 && mouseY >= 500 && mouseX <= 800 && mouseY <= 600){  //showtime 1
    menuMusic.pause();
    gameIndex = 6;
    songSelect = false;    
    showTime = true;
    return;
    }
     
  }
     
    if((showTime == true) && mouseX < 50 && mouseY < 50 && mouseX > 0 && mouseY > 0){ // displays in game options if ingame
      movies[gameIndex].pause();
      options.loop();
      showTime = false;
      optionMenu2 = true;     
      return;
    }
        
    if(optionMenu2 == true){  // There has to be a more efficient way
     if(mouseX > 810 && mouseX < 1210 && mouseY > 400 && mouseY < 450){
         options.pause();
         options.rewind();
         optionMenu2 = false;
         showTime = true;    
         return;     
     }
     if(mouseX > 810 && mouseX < 1210 && mouseY > 500 && mouseY < 550){
       movies[gameIndex].stop();
       games[gameIndex].resetGame();  
       options.pause();
       options.rewind();
       menuMusic.rewind();               
       optionMenu2 = false;
       showTime = false;
       songSelect = true;         
       return;
     }
      if(mouseX > 810 && mouseX < 1210 && mouseY > 600 && mouseY < 650){
        minim.stop();
        exit();        
      }   
 }
 
   if(results == true){
     if(mouseX >1160 && mouseX < 1560 && mouseY > 335 && mouseY < 435){
       resultSong.pause();
       resultSong.rewind();
       menuMusic.rewind();
       games[gameIndex].resetGame();
       results = false;
       songSelect = true;       
     }
     if(mouseX >1160 && mouseX < 1560 && mouseY > 545 && mouseY < 645){
         minim.stop();
         exit();       
     }                  
   }
       
   
 }
 
// method for keyPress, will execute even if finger not lifted
public void keyPressed(){
  
  if(keyCode == 27){  // at any time during the program if escape is pressed, the program will stop all audio and exit
  minim.stop();
  exit();  
  }
    
  if(startScreen == true){  //if on starting screen and press any mouse button, go to song select
    clickFX.play();
    clickFX.rewind();
    startScreen = false;
    songSelect = true;
    return;
  }
      
  if(songSelect == true || optionMenu1 == true || optionMenu2 == true || results == true){  // if in song select just play FX
    clickFX.play();
    clickFX.rewind();
    return;   
  }      
  
  if(intro == true){
    intro = false;
    startScreen = true;
    return;
  }
}



//helper method for the play() function of the Movie class, this method is required for the proper function of Movie objects, will be called inside of draw accordingly.
public void movieEvent(Movie m){  
m.read();
}
