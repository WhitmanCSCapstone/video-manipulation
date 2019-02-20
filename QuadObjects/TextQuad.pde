/*
 * QuadObject for sketches that manipulate text.
 */
public class TextQuad extends QuadObject {

    /*
     * Array of words to use in the sketch.
     */
    ArrayList<String> words;
    /*
     * Array of fonts for use in the sketch
     */
    ArrayList<PFont> fonts;
    /*
     * Index of current selected word in words array
     */
    int curWord = 0;
    /*
     * Index of current selected font in fonts array
     */
    int curFont = 0;
    /*
     * Flag used for pausing the sketch.
     * false if not paused, true if paused
     */
    boolean pauseFlag = false;

    /*
     * Current X and Y position of the text.   
     */
     float xPos;
     float yPos;


    /*
     * Default constructor populates using hard-coded parameters.
     */
    public TextQuad (PGraphics buffer) {
        constructorHelper(buffer);
        loadDefaultWords();
    }

    /*
     * Constructor to load words from a given file path.
     * @param wordFilePath - string containing path to file with text data
     */
    public TextQuad(String wordFilePath, PGraphics buffer) {
        constructorHelper(buffer);
        loadText(wordFilePath);
        loadDefaultFonts();
    }

    /*
     * Helper function for constructors to call field constructors.
     * Does not populate arrays with data.
     */
    private void constructorHelper(PGraphics buffer) {
        words = new ArrayList<String>();
        fonts = new ArrayList<PFont>();
        xPos = 400;
        yPos = 400;
        textAlign(CENTER, CENTER);
        tempBuffer = createGraphics(buffer.width, buffer.height);

        noStroke();
        noCursor();
    }

    /*
     * Helper function to populate the words field with some sample data.
     * words must be constructed prior to call.
     */
    public void loadDefaultWords() {
        words.add("hi");
        words.add("there");
        words.add("world");
    }

    /*
     * Constructor helper function to load two default fonts.
     */
    public void loadDefaultFonts() {
        String[] fontNames = {"Helvetica-500.vlw", "Impact-500.vlw"};
        loadFonts(fontNames);
    }
 
    /*
     * Helper function to load given font files into fonts array.
     * Clears the fonts array before populating with given fonts.
     */
     public void loadFonts(String[] fontNames) {
        fonts.clear();
        for (int i = 0; i < fontNames.length; i++) {
            PFont f = loadFont(fontNames[i]);
            if (f != null) {
                fonts.add(f);
            }
        }
        fonts.trimToSize();
     }

     /*
      * Load contents of given file into words array.
      * words array will be replaced with given content.
      * Text will be delimited by spaces.
      * If file read fails, then array will contain default words.
      */
      public void loadText(String wordFilePath) {
        try {
            words.clear();
            //load document and split it by spaces
            String[] doc = loadStrings(wordFilePath);
            String bigString = join(doc, " "); 
            words = new ArrayList<String>(Arrays.asList(split(bigString, " ")));
        }
        catch (Exception e) {
            e.printStackTrace();
            System.out.print("TextQuad could not load given file: '");
            System.out.println("' " + wordFilePath);
            System.out.println("Default data was loaded instead");
            loadDefaultWords();
        }
        words.trimToSize();
      }

    /* 
     * Final draw to real buffer
     * @arg buffer - the buffer that this quad should draw to when finished
     * @arg params - ArrayList of parameters that represent the input values for given frame
     */ 
    @Override
    public void drawToBuffer(PGraphics buffer, ArrayList<Float> params){
        executeHandlers();
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }

    /*
     *
     */
     protected void executeHandlers(){
        tempBuffer.beginDraw();
        float fontSize = 100;   // arbitrary, just for calculating correct size below
        float fintSizeControl = 100; //hardcode input value
        float boxSizeControl = 100;  //hardcode input value
        float BG_AlphaControl = 100; //hardcode input value
        float fontSizeControl = 100; //hardcode input value

        textFont(fonts.get(curFont), fontSize);   // Tell the computer that size for the following calculations
        float maxSizeW = fontSize/textWidth(words.get(curWord)) * (width*boxSizeControl);
        float maxSizeH = fontSize/(textDescent()+textAscent()) * (height*boxSizeControl);
        fill(255, BG_AlphaControl);  // fills screen-sized rectangle (below) with white w/ opacity determined by midi
        rect(0,0,width,height);
        fill(0);
        fontSize = (min(maxSizeW, maxSizeH));   // Reset fontSize to be the smaller of the two possible maximums for height and width
        fontSize = min(fontSize, fontSizeControl*height*boxSizeControl);
        textSize(fontSize);
        text(words.get(curWord), xPos, yPos);
        tempBuffer.endDraw();
     }

}
