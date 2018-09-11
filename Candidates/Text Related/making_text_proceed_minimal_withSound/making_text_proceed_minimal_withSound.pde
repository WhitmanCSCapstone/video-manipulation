String[] words;
int wordIndex = 0;
int tempWordIndex = wordIndex;
float t, dt;
String wordtoshow;

import ddf.minim.*;  // Load the audio engine
Minim minim;

AudioSample sound1;

void setup() {
  fullScreen();
  //size(500,500);
  textAlign(CENTER, CENTER);
  wordtoshow = "";
  background(255);
  noStroke();
  noCursor();
  t=0;
  
  String[] document = loadStrings("TMS.txt");   // Calls the text file from your data folder and loads it (by line breaks) into an array.
  String joinLines = join(document, " ");   // joins together what would otherwise be each line in a different spot in an array into one long string
  words = split(joinLines, " ");   // splits paragraph (long single string) at spaces (" ") into different cells
minim = new Minim(this);
  
  // Load all sounds in setup(), images must be in the "data" folder
  sound1 = minim.loadSample("gun-gunshot-02.wav");
  
} 

void draw() {

noStroke();
fill(255);
rect(0,0,width, height);
fill(0);
  
  textSize(180);
  text(wordtoshow, width/2,height/2);


 }   

void keyPressed(){
    if (keyPressed) {     // every n'th frame

    wordtoshow = words[wordIndex];
    wordIndex ++;  // advance one word
    
    // Check if it's time to restart text from beginning
    if(wordIndex == words.length)
      wordIndex = 0; 
      if (key == ' '){
  sound1.trigger();
  }
      
  }
  //if (key == ' '){
  //sound1.play();
  //}
}



                     
