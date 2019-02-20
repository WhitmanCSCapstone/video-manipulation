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
     * Default constructor populates using hard-coded parameters.
     */
    public TextQuad () {
        constructorHelper();
        loadDefaultWords();
    }

    /*
     * Constructor to load words from a given file path.
     * @param wordFilePath - string containing path to file with text data
     */
    public TextQuad(String wordFilePath) {
        constructorHelper();
        loadText(wordFilePath);
        loadDefaultFonts();
    }

    /*
     * Helper function for constructors to call field constructors.
     * Does not populate arrays with data.
     */
    private void constructorHelper() {
        words = new ArrayList<String>();
        fonts = new ArrayList<PFont>();

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
     * Final draw to real buffer - currently not using params
     * 
     */ 
    public void drawToBuffer(PGraphics buffer, ArrayList<Float> params){
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }

}
