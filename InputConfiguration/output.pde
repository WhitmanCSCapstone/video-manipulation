//import processing.video.*;

//Movie vid;

//IMPORTS FOLLOW - Double check to make sure these are necessary!
import themidibus.*;

public class OutputQuad extends QuadObject{
	private HashMap<String, Integer> map = MidiMapper.getSpecialButtons();
	private float ry = 0.0;
	private float rx =0.0;
	private String[] words;
	private PFont[] fonts;
	private int wordIndex = 0;
	private int tempWordIndex = wordIndex;
	private int fontIndex = 0;
	private int fontSelect = 0; // To show in console which font is being used
	private float red, green, blue; // Text color variables
	private boolean pauseToggle = true;
	private boolean redToggle = true; // start as not red
	private String wordtoshow;

	OutputQuad(PApplet app, PGraphics buffer){
	  //size(936,288,P3D);
	  MidiBus.list();  // Shows controllers in the console
		//Deleted new Midi initialization
	  
	  textAlign(CENTER, CENTER);
	  wordtoshow = "";
	
	  
	  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
	    params.get(i) = 127; // Replaced: 	    cc[i] = 127;
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

	@Override
	protected void runSketch(Arraylist<Float> params){
		tempBuffer.beginDraw();
	  {
	  tempBuffer.noStroke();
	  float bop = map(params.get(21),0,127,255,5); // Replaced: 	  float bop = map(cc[21],0,127,255,5);
	  tempBuffer.fill(0,bop);
	  tempBuffer.rect(0,0,0,tempBuffer.width,tempBuffer.height);
	   tempBuffer.stroke(255);
	  float w = map(params.get(19),0,127,10,2); // Replaced: 	  float w = map(cc[19],0,127,10,2);
	   tempBuffer.strokeWeight(w);
	  tempBuffer.translate(tempBuffer.width / 2, tempBuffer.height/2);
	   float ma = map(params.get(map.get("Fade")), 0,127,0,65); // Replaced: 	   float ma = map(cc[16], 0,127,0,65);
	   float mb = map(params.get(map.get("X_Skew")), 0,127,0,65); // Replaced: 	   float mb = map(cc[17], 0,127,0,65);
	   tempBuffer.rotateY (ry);
	  ry = ry + ma;
	  tempBuffer.rotateX (rx);
	  rx = rx + mb;
	   tempBuffer.beginShape();
	
	  float cw = map(params.get(map.get("Y_Skew")),0,127,-height/2,tempBuffer.height/2); // Replaced: 	  float cw = map(cc[18],0,127,-height/2,tempBuffer.height/2);
	  float co = map(params.get(20),0,127,255,5); // Replaced: 	  float co = map(cc[20],0,127,255,5);
	  float s = map(params.get(22),0,127,.2,2); // Replaced: 	  float s = map(cc[22],0,127,.2,2);
	  tempBuffer.fill(0,co);
	  tempBuffer.ellipse(cw,0,tempBuffer.height *s,tempBuffer.height *s);
	  tempBuffer.vertex(-width/2, - tempBuffer.height/2, 0, 0, 0);
	  tempBuffer.vertex(tempBuffer.width/2, -height/2, 0, tempBuffer.width, 0);
	  tempBuffer.vertex(tempBuffer.width/2, tempBuffer.height/2, 0, tempBuffer.width, tempBuffer.height);
	  tempBuffer.vertex(-width/2, tempBuffer.height/2, 0, 0, tempBuffer.height);
	  tempBuffer.endShape(); }
	
	 if (pauseToggle) {
	  if (tempBuffer.redToggle) {
	
	   // BACKGROUND ALPHA CONTROL: for fade  
	   float BG_AlphaControl = map(params.get(map.get("Fade")), 0, 127, 0, 255); // Replaced: 	   float BG_AlphaControl = map(cc[16], 0, 127, 0, 255);
	   // --------------------
	   // TEXT ALPHA CONTROL:
	   float tempBuffer.textAlphaControl = map(params.get(map.get("FFT_Sensitivity")), 0, 127, 0, 255); // Replaced: 	   float tempBuffer.textAlphaControl = map(cc[23], 0, 127, 0, 255);
	   // --------------------
	   // SPEED CONTROL: how often to change the word (if (frameCount % speed == 0...)) 
	   int speedControl = round(map(params.get(map.get("X_Skew")), 0, 127, 30, 2)); // Shouldn't be float b/c % 0 // Replaced: 	   int speedControl = round(map(cc[17], 0, 127, 30, 2)); // Shouldn't be float b/c % 0
	   // --------------------
	   // TEXT BOX SIZE CONTROL: how much of the screen text should take up (in box)
	   float tempBuffer.boxSizeControl = map(params.get(map.get("Y_Skew")), 0, 127, 0.3, .9); // Replaced: 	   float tempBuffer.boxSizeControl = map(cc[18], 0, 127, 0.3, .9);
	   // --------------------
	   // MAX SIZE CONTROL: changing the biggest font sizes to match b/w short and long words
	   // The fraction of the screen height to allow the font to be (if short word)
	   float fontSizeControl = map(params.get(19), 0, 127, 0.2, 1); // Replaced: 	   float fontSizeControl = map(cc[19], 0, 127, 0.2, 1);
	   // --------------------
	   // FONT SELECTION
	   //int fontSpeedControl = round(map(cc[20],0,127,500,10));  // This is for changing the speed at which the fonts cycle rather than custom selection
	   fontSelect = int(random(0, fonts.length - 1)); // Pick font based on dial
	   // --------------------
	   // LEFT AND RIGHT
	   float xPos = map(params.get(21), 0, 127, 0, tempBuffer.width); // Replaced: 	   float xPos = map(cc[21], 0, 127, 0, tempBuffer.width);
	   // --------------------
	   // UP AND DOWN
	   float yPos = map(params.get(22), 0, 127, tempBuffer.height, 0); // Replaced: 	   float yPos = map(cc[22], 0, 127, tempBuffer.height, 0);
	   // --------------------
	   // TEXT RGB
	   tempBuffer.red = map(params.get(map.get("Zoom")), 0, 127, 0, 255); // Replaced: 	   tempBuffer.red = map(cc[0], 0, 127, 0, 255);
	   tempBuffer.green = map(params.get(map.get("X_Rotation")), 0, 127, 0, 255); // Replaced: 	   tempBuffer.green = map(cc[1], 0, 127, 0, 255);
	   tempBuffer.blue = map(params.get(map.get("Y_Rotation")), 0, 127, 0, 255); // Replaced: 	   tempBuffer.blue = map(cc[2], 0, 127, 0, 255);
	   // --------------------
	   // RESTART: Go back to the beginning of the text
	   if (params.get(46) == 127) { // Replaced: 	   if (cc[46] == 127) {
	    wordIndex = 0;
	   }
	
	
	   // CALCULATE MAX FONT SIZE
	   float fontSize = 100; // arbitrary, just for calculating correct size below
	   //int mf = random
	   tempBuffer.textFont(fonts[fontSelect], fontSize); // Tell the computer that size for the following calculations
	   float maxSizeW = fontSize / tempBuffer.textWidth(words[wordIndex]) * (tempBuffer.width * tempBuffer.boxSizeControl);
	   float maxSizeH = fontSize / (tempBuffer.textDescent() + tempBuffer.textAscent()) * (tempBuffer.height * tempBuffer.boxSizeControl);
	   tempBuffer.fill(255, BG_AlphaControl); // fills screen-sized rectangle (below) with white w/ opacity determined by midi
	   tempBuffer.rect(0, 0, tempBuffer.width, tempBuffer.height);
	   tempBuffer.fill(0);
	   fontSize = (min(maxSizeW, maxSizeH)); // Reset fontSize to be the smaller of the two possible maximums for height and width
	   fontSize = min(fontSize, fontSizeControl * tempBuffer.height * tempBuffer.boxSizeControl);
	   tempBuffer.textSize(fontSize);
	   tempBuffer.text(wordtoshow, xPos, yPos);
	
	   // CHANGE BY frameCount
	   if (frameCount % speedControl == 0) { // every n'th frame
	
	    // BG fade layer draws whenever text draws
	    // QUICK RED
	    if (params.get(64) == 127) // If the value of button # 64 ([R]) is 127 (pushed) // Replaced: 	    if (cc[64] == 127) // If the value of button # 64 ([R]) is 127 (pushed)
	     tempBuffer.fill(200, 0, 0, tempBuffer.textAlphaControl); // make the fill color red
	    else tempBuffer.fill(tempBuffer.red, tempBuffer.green, tempBuffer.blue, tempBuffer.textAlphaControl);
	
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
	    
		tempBuffer.endDraw();
	}

}

