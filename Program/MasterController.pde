/*
 * This centralizes and begins all the controller behavior that happens in the program.
 * When procesing calls setup(), draw(), and controllerChange(), MasterController delegates responsibiliteis
 */
public class MasterController {

    /*
    * The QuadContainer that holds the quads and draws to screen.
    */
    private QuadContainer quadCont;

    // /*
    // * The InputController that stores input states.
    // */
    // private InputController inputControl;

    // /*
    // * The MidiView that controls the lighting on the Midi board.
    // */
    // private MidiView midi;

    /*
     * Setup the object by creating the objects it references.
     * QuadContainer will use buffers that are the size of the app's window.
     */
    public MasterController(PApplet app) {
        quadCont = new QuadContainer(app, app.width, app.height);
        quadCont.createAllQuads(app);
        inputController = new InputController();
        // inputController = new InputController(app, MIDI_MAP.size(), midiFlag, soundFlag);
    }

    /*
     * Setup the object by creating the objects it references.
     * Pass in the desired values for the size of the buffer. AKA the dimentions of the app window.
     * Only use this if you want custom quad dimensions.
     */
    public MasterController(PApplet app, int bufferWidth, int bufferHeight) {
        quadCont = new QuadContainer(app, bufferWidth, bufferHeight);
        quadCont.createAllQuads(app);

        // inputController = new InputController(app, MIDI_MAP.size(), midiFlag, soundFlag);
    }

    // /* 
    // * Request the input state as an array of values.
    // * @return array of floats containing all the input state values
    // */
    // private ArrayList<Float> fetchParams();

    // /* 
    // * Tell the input object to update all its inputs. Some input types are not automatically
    // * updated and must be provoked to do so.
    // * Useful to refresh inputs without quad drawing quad to screen.
    // */
    // public void updateInputs() {
    //     inputControl.refresh();
    // }

    // /* 
    // * ?
    // */
    // private void notifyInputController(Input []);

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

    // /* 
    // * Setup the InputController object to hold input states.
    // */
    // public void createInputs();

    // /* 
    // * When processing recieves a controller change, it gets passed here which delegates 
    // * responsibilities depending on the input sources.
    // */
    // public void handleControllerChange(int, int, int);

    /* 
    * Handle everything neccesarry to draw the quad. Make inputs update, fetch inputs, pass to 
    * QuadContainer and have it draw with them.
    */
    public void drawQuad() {
        // updateInputs();
        // quadCont.drawToBuffer(inputControl.fetchInputs());

        //for testing without Input module
        quadCont.drawToBuffer(new ArrayList<Float>());
    }

}