
/**
* The MidiInput class is the concrete implementation of
* an input that is specific to mapping Midi inputs.
*/
class MidiInput extends input{

    /* UML DIAGRAM
    private int midiMin;
    private int midiMax;
    public int inputSource;
    */
    
    private float midiMin;
    private float midiMax;
    private float deadzone;
    private boolean hasDeadZone;
    public int inputSource;


    MidiInput(boolean hasDZone){
        value = 0;
        deadzone = 4;
        midiMin = 0;
        midiMax = 127;
        hasDeadZone = hasDZone;
    }
    

    public void updateVal(float val){
        if(hasDeadZone && (val > 63.5-deadzone && value < deadzone + 63.5)){
            value = 63.5;
        } else if (val < midiMin) {
            value = midiMin;
        } else if (val > midiMax) {
            value = midiMax;
        }
    }
/*
    public int mapValue(int midiVal){}
    public updateValUsing(int midiVal){}

    
    public void updateVal(double inputVal){}
    private double mapVal(double inputVal){}
*/

}
