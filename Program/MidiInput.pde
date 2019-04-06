/**
* The MidiInput class is the concrete implementation of
* InputObj that is specific to mapping Midi inputs.
*/
class MidiInput extends InputObj{

    //Midi input minimum
    private double midiMin;
    //Midi input maximum
    private double midiMax;
    //Midi input middle
    private double midiMid;
    //Size of dead zone in midi units
    private double deadzone;
    //Has dead zone or not
    private boolean hasDeadZone;

    /**
    * Constructor initializes values
    * @param hasDZone : determines if input has dead zone in middle
    */
    MidiInput(boolean hasDZone){
        super();
        deadzone = 4.0;
        midiMin = 0.0;
        midiMax = 127.0;
        midiMid = 63.5;
        hasDeadZone = hasDZone;
    }
    
    /**
    * Map input value to appropriate Midi value, overloads super class method
    * @param val : raw input value
    */
    public void updateVal(double val){
        if(hasDeadZone && val > (midiMid-deadzone) && val < (deadzone + midiMid)){
            value = midiMid;
        } else if (val < midiMin) {
            value = midiMin;
        } else if (val > midiMax) {
            value = midiMax;
        } else {
          value = val;
        }
    }
}
