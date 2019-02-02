

class InputController {
  
    private input inputArray[];
    private FFTController fftController;
    
    boolean soundFlag;
    boolean midiFlag;
    
    InputController(PApplet app, int inputNum, boolean isMidi, boolean isSound) {
      
      inputArray = new input[inputNum];

      soundFlag = isSound;
      midiFlag = isMidi;
      
      if (soundFlag) {
        for (int i=0; i<inputNum; i++){
          boolean hasDeadZone = false; //whether the input has a dead zone is specific to Midi
          MidiInput midiInputRef = new MidiInput(hasDeadZone);
          inputArray[i] = new SoundDecorator(midiInputRef, minim);
        }
        fftController(inputArray,app);
      }
      else if (midiFlag) {
        for (int i=0; i<inputNum; i++){
          inputArray[i] = new MidiInput();
        }
      }
    }
    
    public void updateModel(int number, float value) {

      if (soundFlag) {
        fftController.updateModel(number, value);
      } else {
        inputArray[number].updateVal(value);
      }
    }
    
    public input[] fetchInputs() {
      return inputArray;
    }
}
