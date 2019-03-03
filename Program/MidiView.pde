class MidiView {

	Map<Integer,Integer> MIDIINDEX_MAP = MidiMapper.buttonToArray();
	Map<Integer,Integer> KNOB_MAP = MidiMapper.buttonToKnob();
	Map<Integer,Integer> SLIDER_MAP = MidiMapper.buttonToSlider();
	MidiBus myBus;
	/*
	 * Constructor
	 */
	MidiView(MidiBus my_Bus) {
		myBus=my_Bus;
		//Initialize sound buttons to input knobs
		KNOB_MAP = MidiMapper.buttonToKnob();
		MIDIINDEX_MAP = MidiMapper.buttonToArray();

		//Initialize sound buttons off
		midiSwitches = new boolean[MIDIINDEX_MAP.size()];
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
	    int knobIndex = MIDIINDEX_MAP.get(KNOB_MAP.get(number)); //get knobs array slot
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
	  if (SLIDER_MAP.get(number) != null){ //if button maps to slider
	    int sliderIndex = MIDIINDEX_MAP.get(SLIDER_MAP.get(number)); //get slider's array slot
	    boolean isListening = midiSwitches[sliderIndex]; 
	    if (value==127){
	      if (!isListening){
	        myBus.sendControllerChange(channel,number,value);
	      }
	      midiSwitches[sliderIndex] = !isListening;
	    }
	    else if (!isListening){
	      myBus.sendControllerChange(channel,number,value);
	    }
	  }
	}
}