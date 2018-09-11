
//import processing.video.*;
//Movie movie;
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;

String[] words;
PFont[] fonts;

int wordIndex = 0;
int tempWordIndex = wordIndex;
int fontIndex = 0;
int fontSelect = 0;  // To show in console which font is being used
float red, green, blue;  // Text color variables

boolean pauseToggle = true;
boolean redToggle = true;   // start as not red
String wordtoshow;

import processing.sound.*;
float amplitude = 0.01;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;

void setup() {
  fullScreen();
  //size(500,500);
  textAlign(CENTER, CENTER);
  wordtoshow = "";
 
  noStroke();
  noCursor();
  
  //movie = new Movie(this, "multiples.mov");
  //   movie.read();
  //movie.loop();
  

  
  // Setting up midi controller
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
     mic = new AudioIn(this, 0);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
  cc[17] = 2;  // Make only speed minimum at startup
  // Center text at startup
  cc[19] = 0.6;
  cc[21] = 63;
  cc[22] = 63;
  
  
  // Create array of words from a text file
  String[] document = loadStrings("D.txt");   // Calls the text file from your data folder and loads it (by line breaks) into an array.
  String joinLines = join(document, " ");   // joins together what would otherwise be each line in a different spot in an array into one long string
  words = split(joinLines, " ");   // splits paragraph (long single string) at spaces (" ") into different cells
  
  // Array of font names
  String[] fontNames = {"Wingdings2-500.vlw","SnellRoundhand-Bold-500.vlw", "SynchroLET-500.vlw", "Monaco-500.vlw", "NanumBrush-500.vlw", 
                         "Helvetica-500.vlw", "Palatino-Roman-500.vlw", "Impact-500.vlw"};
                        
  // Array of actual fonts, loaded using names in array above
  fonts = new PFont[fontNames.length];   // Make its size match the # of fonts

  // Loads all the fonts into the array
  for (int i = 0; i < fontNames.length; i++) {
    fonts[i] = loadFont(fontNames[i]);
  }  

}

//void movieEvent(Movie m) {
//  m.read();
//}

void draw() {
 if (pauseToggle){
   //vidSpeed = map(cc[7], 0,127,.1,2.0);
   //movie.speed(vidSpeed);
   //    image(movie, 0, 0, width, height);
    

   if(redToggle){
     
// BACKGROUND ALPHA CONTROL: for fade  
  float BG_AlphaControl = map(cc[16],0,127,0,255);
// --------------------
// TEXT ALPHA CONTROL:
  float textAlphaControl = map(cc[23],0,127,0,255);
// --------------------
// SPEED CONTROL: how often to change the word (if (frameCount % speed == 0...)) 
  int speedControl = round(map(cc[17],0,127,30,2));  // Shouldn't be float b/c % 0
// --------------------
// TEXT BOX SIZE CONTROL: how much of the screen text should take up (in box)
  float boxSizeControl = map(cc[18],0,127,0.3,.9);
// --------------------
// MAX SIZE CONTROL: changing the biggest font sizes to match b/w short and long words
      // The fraction of the screen height to allow the font to be (if short word)
  float fontSizeControl = map(cc[19],0,127,0.2,1);
// --------------------
// FONT SELECTION
  //int fontSpeedControl = round(map(cc[20],0,127,500,10));  // This is for changing the speed at which the fonts cycle rather than custom selection
  fontSelect = round(map(cc[20],0,127,0,fonts.length-1));  // Pick font based on dial
// --------------------
// LEFT AND RIGHT
  float xPos = map(cc[21], 0, 127, 0, width);
// --------------------
// UP AND DOWN
  float yPos = map(cc[22], 0, 127, height, 0);
// --------------------
// TEXT RGB
  red = map(cc[0], 0, 127, 0, 255);
  green = map(cc[1], 0, 127, 0, 255);
  blue = map(cc[2], 0, 127, 0, 255);
// --------------------

// RESTART: Go back to the beginning of the text
   if (cc[46] == 127) {  
     wordIndex = 0; }
     
     
// CALCULATE MAX FONT SIZE

  float fontSize = 180;   // arbitrary, just for calculating correct size below
  textFont(fonts[fontSelect], fontSize);   // Tell the computer that size for the following calculations
  float maxSizeW = fontSize/textWidth(words[wordIndex]) * (width*boxSizeControl);
  float maxSizeH = fontSize/(textDescent()+textAscent()) * (height*boxSizeControl);
  //fontSize = (min(maxSizeW, maxSizeH));   // Reset fontSize to be the smaller of the two possible maximums for height and width
  //fontSize = min(fontSize, fontSizeControl*height*boxSizeControl);
  textSize(fontSize);
  float mY = map(amp.analyze(),0.02,.5,300,height-150);
   fill(255,60);
    rect(0,0,width,height);
    fill(0);
  text(wordtoshow, xPos, mY);
  if(cc[48] == 127){
  stroke(0);
  strokeWeight(0.1*fontSize);
  if(textWidth(wordtoshow)>5) {
    strokeCap(SQUARE);
  line(xPos-textWidth(wordtoshow)/2,yPos,xPos+textWidth(wordtoshow)/2,yPos);}
  }

// CHANGE BY frameCount
  if (frameCount % speedControl == 0) {     // every n'th frame

    // BG fade layer draws whenever text draws
   // fill(255, BG_AlphaControl);  // fills screen-sized rectangle (below) with white w/ opacity determined by midi
    //tint(255,BG_AlphaControl);
    
// QUICK RED
    if (cc[64] == 127)  // If the value of button # 64 ([R]) is 127 (pushed)
      fill(200,0,0,textAlphaControl);    // make the fill color red
    else fill(red,green,blue,textAlphaControl);
    
    //text(words[wordIndex], width/2, height/2 - height/20);  // Draws text in middle of window.
    wordtoshow = words[wordIndex];
    if(cc[58] == 127){
    
    wordtoshow= wordtoshow.replaceAll("[aeiouAEIOU]","");}
    
    wordIndex ++;  // advance one word
    
    // Check if it's time to restart text from beginning
    if(wordIndex == words.length)
      wordIndex = 0;  
  }
 }   
}

// Report play data when #41 is held
  if (cc[41] == 127) {
    textSize(16);
    fill(255);
    rect(85,30, textWidth("_________ seconds have passed since the start"), height/20);
    fill(100);
    text(millis()/1000 + " seconds have passed since the start", 250,50); 
    text("you are in frame: " + frameCount,250,85);
  }
}


                       // midi #  (ex:) knob #    # from knob, mapped to be b/w 0 and 1
  void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  println("Frame rate:"+frameRate);
  //println("Font:"+fontNames[fontSelect]);   // How can I get it to say the font name, not just the #?
  println("Font number:"+fontSelect);
  cc[number] = value;  // saves the midi output # to be converted later for what we need

  if (cc[42] == 127) { // Press #42 to pause
   pauseToggle = !pauseToggle;
  }

  if (cc[45] == 127) { // Press #45 to save an image
    saveImage();       // See save function
  }
}

// Red toggle?
// Fade is still lurchy at low speeds
