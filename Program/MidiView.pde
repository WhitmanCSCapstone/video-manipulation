class MidiView {

	Map<Integer,Integer> MIDIINDEX_MAP;
	//Map<Integer,Integer> KNOB_MAP;
	//Map<Integer,Integer> SLIDER_MAP;
	MidiBus myBus;
	/*
	 * Constructor
	 */
	MidiView(MidiBus my_Bus) {
		myBus=my_Bus;
		//Initialize sound buttons to input knobs
		//KNOB_MAP = MidiMapper.buttonToKnob();
		MIDIINDEX_MAP = inputMap.buttonToArray();
		//SLIDER_MAP= MidiMapper.buttonToSlider();

		//Initialize sound buttons off
		midiSwitches = new boolean[MIDIINDEX_MAP.size()];
		for (int i=0; i<midiSwitches.length; i++){
		  midiSwitches[i] = false;
			myBus.sendControllerChange(0,i,0);
		}
	}

	/*
	 * Turn FFT buttons on or off, light up controller
	 */
	void lightingChange(int channel, int number, int value) {
		//Turn FFT buttons on or off, light up controller
		if (MIDIINDEX_MAP.get(number) != null){
			int knobIndex = MIDIINDEX_MAP.get(number);
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