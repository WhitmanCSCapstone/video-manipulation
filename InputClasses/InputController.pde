

class InputController {
  
    private input inputArray[];
    
    boolean soundFlag;
    boolean midiFlag;
    
    InputController(PApplet app, int inputNum, boolean isMidi, boolean isSound) {
      
      inputArray = new input[inputNum];

      soundFlag = isSound;
      midiFlag = isMidi;
      Minim minim;
      
      if (midiFlag && soundFlag) {
        minim = new Minim(app);
        for (int i=0; i<inputNum; i++){
          MidiInput midiInputRef = new MidiInput();
          inputArray[i] = new SoundInput(midiInputRef, minim);
        }
      }
      else if (midiFlag) {
        for (int i=0; i<inputNum; i++){
          inputArray[i] = new MidiInput();
        }
      }
    }
    
    public void updateModel(int number, float value) {   
      inputArray[number].updateVal(value);

      if (number == 7 && soundFlag) {
        for (int i=0; i<inputArray.length; i++) {
          inputArray[i].setSmoother(value);
        }
      }
      if (number == 45 && soundFlag) {
        for (int i=0; i<inputArray.length; i++) {
          inputArray[i].toggleLive();
        }
      }
      if (number == 7 && soundFlag) {
        for (int i=0; i<inputArray.length; i++) {
          inputArray[i].setSmoother(value);
        }
      }
    }
    
    public input[] fetchInputs() {
      return inputArray;
    }
    //public double buildParamValues()
}
