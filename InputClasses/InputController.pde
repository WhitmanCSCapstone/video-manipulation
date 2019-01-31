

class InputController {
  
    private input inputArray[];
    
    InputController(int inputNum, boolean midiFlag, boolean soundFlag) {
      
      inputArray = new input[inputNum];
      
      if (midiFlag && soundFlag) {
        for (int i=0; i<inputNum; i++){
          MidiInput midiInputRef = new MidiInput();
          inputArray[i] = new SoundInput(midiInputRef);
        }
      }
      else if (midiFlag) {
        for (int i=0; i<inputNum; i++){
          inputArray[i] = new MidiInput();
        }
      }
    }
    
    public void updateModel(int number, double value) {   
      inputArray[number].updateVal(value);
    }
    
    public input[] fetchInputs() {
      return inputArray;
    }
    //public double buildParamValues()
}
