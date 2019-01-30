/**
* Sound Input is an implemented decorator that uses a Fast Fourier
* Transformation to update (decorate) input values without being
* noticed by the clien (InputController)
*/

class SoundInput extends InputDecorator{
  
    private int freqMin;
    private input inputComponent;
    
    SoundInput(input inputComp) {   
      super(inputComp);
    }


    /* UML DIAGRAM
    private int freqMin;
    private int freqMax;
    private int frequency;
    private int soundSource;
    private FFT fft;
    
    
    public double getRawValue(){}
    public int mapValue(double inputVal)
    */
    
    
    /* CHANGED FROM UML DIAGRAM
    private double freqMin;
    private double freqMax;
    private double frequency;
    private double soundSource;
    private FFT fft;
    
    
    public double getRawValue(){}
    * mapVal already exists in MidiInput,
    * maybe should be moved to Input parent class
    */

}
