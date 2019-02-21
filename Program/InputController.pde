/**
* The InputController manages changes in the state of the program.
* A single instance of it is contained in the Master Controller.
* It uses FFTController to manage sound responsive inputs.
*/
class InputController {
  
    //inputArray: state of inputs
    private InputObj inputArray[];
    //fftController: manages sound input
    private FFTController fftController;
    
    //soundFlag: takes sound input
    boolean soundFlag;
    //midiFlag: takes midi input
    boolean midiFlag;
    
    //for testing
    InputController(){}

    /**
    * Constructor initializes fields and constructs fftController
    * @param app : used by fftController to create Minim object
    * @param inputNum : the number of InputObj objects to create
    * @param isMidi : flag says if MidiPlayer is found
    * @param isSound : flag says if sound input decorating is on
    */
    InputController(PApplet app, int inputNum, boolean isMidi, boolean isSound) {
      
      inputArray = new InputObj[inputNum];

      soundFlag = isSound;
      midiFlag = isMidi;

      //whether the input has a dead zone is specific to Midi
      boolean hasDeadZone = false; //configuring of dead zones should be refactored later
      
      //should be refactored to allow for non-Midi inputs
      if (soundFlag) {
        SoundDecorator soundInputArray[];
        SoundDecorator soundInput;
        soundInputArray = new SoundDecorator[inputNum];
        for (int i=0; i<inputNum; i++){
          MidiInput midiInputRef = new MidiInput(hasDeadZone);
          soundInput = new SoundDecorator(midiInputRef);
          inputArray[i] = soundInput;
          soundInputArray[i] = soundInput;
        }
        fftController = new FFTController(soundInputArray,app);
      }
      else if (midiFlag) {
        for (int i=0; i<inputNum; i++){
          inputArray[i] = new MidiInput(hasDeadZone);
        }
      }
    }
    
    /**
    * Updates the state of program
    * @param number : which button/input is triggered
    * @param value : the value of that input
    */
    public void updateModel(int number, double value) {
      if (soundFlag) {
        fftController.updateModel(number, value);
      } else if (MIDI_MAP.get(number)!=null){
        inputArray[MIDI_MAP.get(number)].updateVal(value);
      }
    }
    
    /**
    * Returns the state of the program
    * @return inputArray : array of values that are sent to the sketch
    */
    public InputObj[] fetchInputs() {
      /*
      if (soundFlag){
        return fftController.fetchInputs();
      } */
      return inputArray;
    }

    /**
    * Updates sound listening
    */
    public void refresh(){
      if (soundFlag){
        fftController.refresh();
      }
    }
}
