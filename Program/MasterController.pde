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

    /*
     * The Midibus object that the program uses
     */
    private MidiBus myBus;

    /*
     * The object that toggles the button lighting on the Midi controller.
     */
    MidiView myMidiView;
    

    Map<String,Integer> SPECIAL_MAP;

    /*
     * Setup the object by creating the objects it references.
     * QuadContainer will use buffers that are the size of the app's window.
     */
    public MasterController(PApplet app) {
        SPECIAL_MAP = inputMap.getSpecialButtons();
        quadCont = new QuadContainer(app, app.width, app.height);
        inputControl = new InputController(app, true, true); //(PApplet, isMidi, isSound)
        setupMidi();
    }


    /*
     * Setup the object by creating the objects it references.
     * Pass in the desired values for the size of the buffer. AKA the dimensions of the app window.
     * Only use this if you want custom quad dimensions.
     */
    public MasterController(PApplet app, int bufferWidth, int bufferHeight) {
        quadCont = new QuadContainer(app, bufferWidth, bufferHeight);
        setupMidi();
    }


    /* 
    * When processing recieves a controller change, it calls this method first.
    * This call delegates responsibilities depending on the input sources.
    */
    public void controllerChange(int channel, int number, int value) {
        println("Controller Update:");
        println("  Controller Change:");
        println("  --------");
        // println("  Channel:"+channel);
        println("  Number:"+number);
        println("  Value:"+value);

        if (SPECIAL_MAP.get("Previous_Sketch") == number) { //'previous quad' button pressed
            if (value == 127) {
                quadCont.selectPrevQuad();
            }
        }
        else if (SPECIAL_MAP.get("Next_Sketch") == number) { //'next quad' button pressed
            if (value == 127) {
                quadCont.selectNextQuad();
            }
        }
        else if (SPECIAL_MAP.get("Freeze_Quad") == number) { //'freeze quad' button pressed
            if (value == 127)
                quadCont.fixQuad();
        }
        else if (SPECIAL_MAP.containsValue(number)){
            println("Value is "+number);
        }

        inputControl.updateModel(number, (float) value);
        myMidiView.lightingChange(channel, number, value);
    }

    /* 
    * Request the input state as an array of values.
    * @return array of floats containing all the input state values
    */
    private ArrayList<Float> fetchParams(){
        return inputControl.fetchInputs();
    }

    /* 
    * Tell the input object to update all its inputs. Some input types are not automatically
    * updated and must be provoked to do so.
    * Useful to refresh inputs without quad drawing quad to screen.
    */
    public void updateInputs() {
        inputControl.refresh();
    }

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
        quadCont.drawToScreen(fetchParams());
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
