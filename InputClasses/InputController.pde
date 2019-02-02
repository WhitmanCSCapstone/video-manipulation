

class InputController {
  
    private input inputArray[];
    private FFTController fftController;
    
    boolean soundFlag;
    boolean midiFlag;
    
    InputController(PApplet app, int inputNum, boolean isMidi, boolean isSound) {
      
      inputArray = new input[inputNum];

      soundFlag = isSound;
      midiFlag = isMidi;

      //whether the input has a dead zone is specific to Midi
      boolean hasDeadZone = false;
      
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
    
    public void updateModel(int number, float value) {
      if (soundFlag) {
        fftController.updateModel(number, value);
      } else if (MIDI_MAP.get(number)!=null){
        inputArray[MIDI_MAP.get(number)].updateVal(value);
      }
    }
    
    public input[] fetchInputs() {
      if (soundFlag){
        return fftController.fetchInputs();
      }
      return inputArray;
    }

    public void refresh(){
      if (soundFlag){
        fftController.refresh();
      }
    }
}
