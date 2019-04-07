// Turn all knobs to max value before starting.
// Knob #17 (2nd from left) should start turned all the way to the left.
    // This knob controls speed and to avoid jarring speed changes, it starts out slow.
// Knobs #21 and #22 should start in the middle (pointing up)
    // This makes text movement more natural based on centered starting coordinates

// Global
public class mercerTextQuad extends QuadObject{
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

    mercerTextQuad(PApplet app, PGraphics buffer){
        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);
        tempBuffer.textAlign(CENTER, CENTER);
        wordtoshow = "";
        tempBuffer.noStroke();

        String[] document = loadStrings("interests.txt");   // Calls the text file from your data folder and loads it (by line breaks) into an array.
        String joinLines = join(document, " ");   // joins together what would otherwise be each line in a different spot in an array into one long string
        words = split(joinLines, " ");   // splits paragraph (long single string) at spaces (" ") into different cells
        
        // Array of font names
        String[] fontNames = {//"Wingdings2-500.vlw","SnellRoundhand-Bold-500.vlw", "SynchroLET-500.vlw", "Monaco-500.vlw", "NanumBrush-500.vlw", 
                                "Helvetica-500.vlw", "Palatino-Roman-500.vlw", "Impact-500.vlw"};
                                
        // Array of actual fonts, loaded using names in array above
        fonts = new PFont[fontNames.length];   // Make its size match the # of fonts

        // Loads all the fonts into the array
        for (int i = 0; i < fontNames.length; i++) {
            fonts[i] = loadFont(fontNames[i]);
        }  

    }

    @Override
     protected void runSketch(ArrayList<Float> params){ 
        tempBuffer.beginDraw();
        tempBuffer.textAlign(CENTER, CENTER);

 if (pauseToggle){
       //image(movie, 0, 0, width, height);
//background(255);
  
   if(redToggle){
     
// BACKGROUND ALPHA CONTROL: for fade  
  float BG_AlphaControl = map(params.get(0),0,127,0,255);
// --------------------
// TEXT ALPHA CONTROL:
  float textAlphaControl = map(params.get(1),0,127,0,255);
// --------------------
// SPEED CONTROL: how often to change the word (if (frameCount % speed == 0...)) 
  int speedControl = round(map(params.get(2),0,127,30,2));  // Shouldn't be float b/c % 0
// --------------------
// TEXT BOX SIZE CONTROL: how much of the screen text should take up (in box)
  float boxSizeControl = map(params.get(3),0,127,0.3,.9);
// --------------------
// MAX SIZE CONTROL: changing the biggest font sizes to match b/w short and long words
      // The fraction of the screen height to allow the font to be (if short word)
  float fontSizeControl = map(params.get(4),0,127,0.2,1);
// --------------------
// FONT SELECTION
  int fontSpeedControl = round(map(params.get(4),0,127,15,2));  // This is for changing the speed at which the fonts cycle rather than custom selection
  if (frameCount % fontSpeedControl == 0){

println("changing");
    fontSelect = int(random(0,fonts.length-1));  // Pick font based on dial
  }
// --------------------
// LEFT AND RIGHT
//   float xPos = map(cc[21], 0, 127, 0, width);
  float xPos = tempBuffer.width/2;
// --------------------
// UP AND DOWN
  float yPos = tempBuffer.height/2;
//   float yPos = map(cc[22], 0, 127, height, 0);
// --------------------
// TEXT RGB
  red = map(params.get(5), 0, 127, 0, 255);
  green = map(params.get(6), 0, 127, 0, 255);
  blue = map(params.get(7), 0, 127, 0, 255);
// --------------------
// RESTART: Go back to the beginning of the text
//    if (cc[46] == 127) {  
//      wordIndex = 0; }
   
     
// CALCULATE MAX FONT SIZE
  float fontSize = 100;   // arbitrary, just for calculating correct size below
  //int mf = random
  tempBuffer.textFont(fonts[fontSelect], fontSize);   // Tell the computer that size for the following calculations
  float maxSizeW = fontSize/textWidth(words[wordIndex]) * (width*boxSizeControl);
  float maxSizeH = fontSize/(textDescent()+textAscent()) * (height*boxSizeControl);
tempBuffer.fill(255, BG_AlphaControl);  // fills screen-sized rectangle (below) with white w/ opacity determined by midi
   tempBuffer. rect(0,0,width,height);
   tempBuffer. fill(0);
  fontSize = (min(maxSizeW, maxSizeH));   // Reset fontSize to be the smaller of the two possible maximums for height and width
  fontSize = min(fontSize, fontSizeControl*height*boxSizeControl);
  tempBuffer.textSize(fontSize);
  tempBuffer.text(wordtoshow, xPos, yPos);
  //stroke(0);
  //strokeWeight(0.1*fontSize);
 // if(textWidth(wordtoshow)>5) {
    //strokeCap(SQUARE);
  //line(xPos-textWidth(wordtoshow)/2,yPos,xPos+textWidth(wordtoshow)/2,yPos);
 // }

// CHANGE BY frameCount
  if (frameCount % speedControl == 0) {     // every n'th frame

    // BG fade layer draws whenever text draws
  
    //tint(255,BG_AlphaControl);
    
// QUICK RED
    if (params.get(5) == 127)  // If the value of button # 64 ([R]) is 127 (pushed)
      tempBuffer.fill(200,0,0,textAlphaControl);    // make the fill color red
    else tempBuffer.fill(red,green,blue,textAlphaControl);
    
    //text(words[wordIndex], width/2, height/2 - height/20);  // Draws text in middle of window.
    wordtoshow = words[wordIndex];
    //wordtoshow= wordtoshow.replaceAll("[aeiouAEIOU]","");
    
    wordIndex ++;  // advance one word
    
    // Check if it's time to restart text from beginning
    if(wordIndex == words.length)
      wordIndex = 0;  
  }
 }   
}
  tempBuffer.endDraw();
  //saveFrame("########words.tiff");
}
// Red toggle?
// Fade is still lurchy at low speeds
}
