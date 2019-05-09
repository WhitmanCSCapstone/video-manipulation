//import processing.video.*;

//Movie vid;
import themidibus.*;
float cc[] = new float[256];
MidiBus myBus;
float ry = 0.0;
float rx =0.0;

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


void setup(){
  //size(936,288,P3D);
  fullScreen(P3D);
  MidiBus.list();  // Shows controllers in the console
  myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output
  
  textAlign(CENTER, CENTER);
  wordtoshow = "";

  
  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
    cc[i] = 127;
  }
  //vid = new Movie(this, "uuu.mov");
  //vid.loop();
  //noStroke()

 fill(0);

  String[] document = loadStrings("interests.txt");   // Calls the text file from your data folder and loads it (by line breaks) into an array.
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


void draw(){ 
  {
  noStroke();
  float bop = map(cc[21],0,127,255,5);
  fill(0,bop);
  rect(0,0,0,width,height);
   stroke(255);
  float w = map(cc[19],0,127,10,2);
   strokeWeight(w);
  translate(width / 2, height/2);
   float ma = map(cc[16], 0,127,0,65);
   float mb = map(cc[17], 0,127,0,65);
   rotateY (ry);
  ry = ry + ma;
  rotateX (rx);
  rx = rx + mb;
   beginShape();

  float cw = map(cc[18],0,127,-height/2,height/2);
  float co = map(cc[20],0,127,255,5);
  float s = map(cc[22],0,127,.2,2);
  fill(0,co);
  ellipse(cw,0,height *s,height *s);
  vertex(-width/2, - height/2, 0, 0, 0);
  vertex(width/2, -height/2, 0, width, 0);
  vertex(width/2, height/2, 0, width, height);
  vertex(-width/2, height/2, 0, 0, height);
  endShape(); }

 if (pauseToggle) {
  if (redToggle) {

   // BACKGROUND ALPHA CONTROL: for fade  
   float BG_AlphaControl = map(cc[16], 0, 127, 0, 255);
   // --------------------
   // TEXT ALPHA CONTROL:
   float textAlphaControl = map(cc[23], 0, 127, 0, 255);
   // --------------------
   // SPEED CONTROL: how often to change the word (if (frameCount % speed == 0...)) 
   int speedControl = round(map(cc[17], 0, 127, 30, 2)); // Shouldn't be float b/c % 0
   // --------------------
   // TEXT BOX SIZE CONTROL: how much of the screen text should take up (in box)
   float boxSizeControl = map(cc[18], 0, 127, 0.3, .9);
   // --------------------
   // MAX SIZE CONTROL: changing the biggest font sizes to match b/w short and long words
   // The fraction of the screen height to allow the font to be (if short word)
   float fontSizeControl = map(cc[19], 0, 127, 0.2, 1);
   // --------------------
   // FONT SELECTION
   //int fontSpeedControl = round(map(cc[20],0,127,500,10));  // This is for changing the speed at which the fonts cycle rather than custom selection
   fontSelect = int(random(0, fonts.length - 1)); // Pick font based on dial
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
    wordIndex = 0;
   }


   // CALCULATE MAX FONT SIZE
   float fontSize = 100; // arbitrary, just for calculating correct size below
   //int mf = random
   textFont(fonts[fontSelect], fontSize); // Tell the computer that size for the following calculations
   float maxSizeW = fontSize / textWidth(words[wordIndex]) * (width * boxSizeControl);
   float maxSizeH = fontSize / (textDescent() + textAscent()) * (height * boxSizeControl);
   fill(255, BG_AlphaControl); // fills screen-sized rectangle (below) with white w/ opacity determined by midi
   rect(0, 0, width, height);
   fill(0);
   fontSize = (min(maxSizeW, maxSizeH)); // Reset fontSize to be the smaller of the two possible maximums for height and width
   fontSize = min(fontSize, fontSizeControl * height * boxSizeControl);
   textSize(fontSize);
   text(wordtoshow, xPos, yPos);

   // CHANGE BY frameCount
   if (frameCount % speedControl == 0) { // every n'th frame

    // BG fade layer draws whenever text draws
    // QUICK RED
    if (cc[64] == 127) // If the value of button # 64 ([R]) is 127 (pushed)
     fill(200, 0, 0, textAlphaControl); // make the fill color red
    else fill(red, green, blue, textAlphaControl);

    //text(words[wordIndex], width/2, height/2 - height/20);  // Draws text in middle of window.
    wordtoshow = words[wordIndex];
    //wordtoshow= wordtoshow.replaceAll("[aeiouAEIOU]","");

    wordIndex++; // advance one word

    // Check if it's time to restart text from beginning
    if (wordIndex == words.length)
     wordIndex = 0;
   }
  }
 }

//saveFrame("#######.tiff");
    
}

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
 // println("Font number:"+fontSelect);
  cc[number] = value;  // saves the midi output # to be converted later for what we need

 // if (cc[42] == 127) { // Press #42 to pause
  // pauseToggle = !pauseToggle;
  }
