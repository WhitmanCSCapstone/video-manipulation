class MidiView {

	/*
	 * Constructor
	 */
	MidiView(MidiBus myBus) {

		//Initialize sound buttons to input knobs
		KNOB_MAP = MidiMapper.buttonToKnob();
		MIDI_MAP = MidiMapper.buttonToArray();

		//Initialize sound buttons off
		midiSwitches = new boolean[MIDI_MAP.size()];
		for (int i=0; i<midiSwitches.length; i++){
		  midiSwitches[i] = false;
		}
	}

	/*
	 * Turn FFT buttons on or off, light up controller
	 */
	public void lightingChange(int channel, int number, int value) {
	  //Turn FFT buttons on or off, light up controller
	  if (KNOB_MAP.get(number) != null){ //if button maps to knob
	    int knobIndex = MIDI_MAP.get(KNOB_MAP.get(number)); //get knobs array slot
	    boolean isListening = midiSwitches[knobIndex]; 
	    if (value==127){
	      if (!isListening){
	        myBus.sendControllerChange(channel,number,value);
	      }
	      midiSwitches[knobIndex] = !isListening;
	    }
	    else if (!isListening){
	      myBus.sendControllerChange(channel,number,value);
	    }
	  }
	}
}