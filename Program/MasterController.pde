/*
 * This centralizes and begins all the controller behavior that happens in the program.
 * When procesing calls setup(), draw(), and controllerChange(), MasterController delegates responsibiliteis
 */
public class MasterController {

    /*
    * The QuadContainer that holds the quads and draws to screen.
    */
    private QuadContainer quadCont;

    /*
    * The InputController that stores input states.
    */
    private InputController inputControl;

    // /*
    // * The MidiView that controls the lighting on the Midi board.
    // */
    // private MidiView midi;


    /*
     * The Midibus object that the program uses
     */
    MidiBus myBus;
    MidiView myMidiView;

    /*
     * Setup the object by creating the objects it references.
     * QuadContainer will use buffers that are the size of the app's window.
     */
    public MasterController(PApplet app) {
        quadCont = new QuadContainer(app, app.width, app.height);
        quadCont.createAllQuads(app);
        inputControl = new InputController(app, true, false); //(PApplet, isMidi, isSound)
        setupMidi();
    }


    /*
     * Setup the object by creating the objects it references.
     * Pass in the desired values for the size of the buffer. AKA the dimensions of the app window.
     * Only use this if you want custom quad dimensions.
     */
    public MasterController(PApplet app, int bufferWidth, int bufferHeight) {
        quadCont = new QuadContainer(app, bufferWidth, bufferHeight);
        quadCont.createAllQuads(app);
        setupMidi();
        // inputControl = new InputController(app, midiFlag, soundFlag);
    }


    /* 
    * When processing recieves a controller change, it calls this method first.
    * This call delegates responsibilities depending on the input sources.
    */
    void controllerChange(int channel, int number, int value) {
        println("Controller Update:");
        println("  Controller Change:");
        println("  --------");
        println("  Channel:"+channel);
        println("  Number:"+number);
        println("  Value:"+value);
        inputControl.updateModel(number,value);
        myMidiView.lightingChange(channel, number, value);
    }

    // /* 
    // * Request the input state as an array of values.
    // * @return array of floats containing all the input state values
    // */
    // private ArrayList<Float> fetchParams();

    /* 
    * Tell the input object to update all its inputs. Some input types are not automatically
    * updated and must be provoked to do so.
    * Useful to refresh inputs without quad drawing quad to screen.
    */
    public void updateInputs() {
        inputControl.refresh();
    }


    // /* 
    // * Used to create an FFT object. 
    // * @arg AudioDevice an object that contains the audio source to FFT
    // * @return FFT object created from the AudioDevice input
    // */
    // public FFT setupFFT(AudioDevice);

    /*
    * Tell QuadContainer to switch the currently selected quad
    * @arg quadIndex the number of the quad to switch to
    */
    public void switchQuad(int quadIndex){
        try {
            quadCont.selectNewQuad(quadIndex);
        } catch (IndexOutOfBoundsException e) {
            System.out.println("Error: Attempted to switch to a quad index that didn't exist. Nothing was done.");
        }
    }

    /* 
    * Setup the InputController object to hold input states.
    */
    public void createInputs() {

    }


    /* 
    * Handle everything neccesarry to draw the quad. Make inputs update, fetch inputs, pass to 
    * QuadContainer and have it draw with them.
    */
    public void drawQuad() {
        updateInputs();
        quadCont.drawToScreen(inputControl.fetchInputs());

        //for testing without Input module
        // quadCont.drawToBuffer(new ArrayList<Float>());
    }

    /*
     * Help the constructors of MasterController setup the MidiBus object.
     */
    void setupMidi() {
        MidiBus.list();  // Shows controllers in the console
        String osName = System.getProperty("os.name").toLowerCase();
        boolean isMacOs = osName.startsWith("mac");
        if (isMacOs) 
        {
            myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
        }
        else
        {
            myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2");
        }

        myMidiView= new MidiView(myBus);
        // midiFlag = true; //Should depend on whether Midi Controller is found
        // soundFlag = true;
    }
}