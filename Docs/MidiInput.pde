import Input;

/**
* The MidiInput class is the concrete implementation of
* an input that is specific to mapping Midi inputs.
*/
class MidiInput extends Input{

    /* UML DIAGRAM
    private int midiMin;
    private int midiMax;
    public int inputSource;
    */
    
    /* CHANGES FROM UML
    private double midiMin;
    private double midiMax;
    public int inputSource;
    */
    
    /* UML DIAGRAM
    public void updateVal(){}
    public int mapValue(int midiVal){}
    public updateValUsing(int midiVal){}
    */
    
    /* CHANGES FROM UML
    public void updateVal(double inputVal){}
    private double mapVal(double inputVal){}
    */