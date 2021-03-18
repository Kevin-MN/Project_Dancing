class Song_Shelf{    
  private String [] songs = {"Our Moment OP Ver.","Wiping All Out", "Dancing All Night","P4 Ultimax","Pursuing My True Self","Whims of Fate","When Mother Was There"};  //store all song names
  private String [] artists = { "Persona 3","ATLUS Kitojah Remix","android-52","Persona 4","ATLUS Kozuka Remix","Yukihiro Fukutomi Remix"," ATLUS Kitajoh Remix"};  // stores song artists, need to be in sync with songs[]. 
  private String [] difficulty = { "Easy", "Medium","Hard","Hard","Easy","Easy","Easy","Easy"};  // stores difficulty of songs, needs to also be in sync with songs[].
  private float horizontal;
  private float vertical;
  private int shelfLength;
  
  Song_Shelf(){  
    horizontal = 0f;
    vertical = 0f;
    shelfLength = songs.length;     
  }
  
  public String getSong(int shelfPosition){
        return songs[shelfPosition];
  }
  
  public String getArtist(int shelfPos){
        return artists[shelfPos];
  }
  
  public String getDiff(int shelfPos){
    return difficulty[shelfPos];    
  }
  
  public int getShelfLength(){
    return shelfLength;
  }
  
  public void displaySongs(){   
    horizontal = 100f;
    vertical = 100f;
    for(int songCount = 0; songCount < songs.length;songCount++){  // inside the for loop should intitialize the array that will contain the feild boundaries for selecting a song.
      if(songCount > 0 && songCount % 4 == 0){
        horizontal += 400f;
        vertical-= 800 ;
      }
     fill(255);
     rect((songCount + horizontal)  , (songCount * 200) + vertical, 300, 100,7);
     fill(0);
     textSize(25);
     text(songs[songCount],(songCount + horizontal) + 15f,(songCount * 200) + vertical +40f);
     text(difficulty[songCount],(songCount + horizontal) + 15f,(songCount * 200) + vertical +75f);
    } 
  }  
}
