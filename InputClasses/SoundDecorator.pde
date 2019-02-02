/**
* Sound Input is an implemented decorator that uses a Fast Fourier
* Transformation to update (decorate) input values without being
* noticed by the clien (InputController)
*/

class SoundDecorator extends InputDecorator{
  
    private int specSize;
    private int targetFreq; // Low is for lower frequencies
    private int bandwidth; //Width of frequency band, larger is a smoother responce
    private float fftAvg;
    private boolean isOn;
    private float smoothMapped;
    private float[] fftSmooth;
    private FFT fft;

    SoundDecorator(input inputComp) {
      super(inputComp);
      targetFreq = 10;
      bandwidth = 20;
      fftAvg = 0;
      smoothMapped = 0.85;
      isOn=false;
    }

    public void updateVal(float inputVal) {
      setDecorateVal();
      inputComponent.updateVal(inputVal);
    }

    public void setDecorateVal(){
      if (isOn){
        fftAvg = getAvgFFT();
        decorateVal = map(fftAvg,0,60,0,255);
      }else {
        decorateVal = 0;
      }
    }

    public void toggleFFT(FFT fourierTrans) {
      fft = fourierTrans;
      specSize = fft.specSize();
      fftSmooth = new float[specSize];
    }

    public void toggleOn() {
      isOn = !isOn;
    }

    public void setSmoother(float smoothRaw) {
      smoothMapped = map(smoothRaw,0,127,0.0,1.0); //FIX EXPLICIT REFERENCE TO MIDI
    }

    public void setTargetFreq(boolean isMin) {
      if (isMin){
        targetFreq = min(500, targetFreq+10);
      } else {
        targetFreq = max(0,targetFreq - 10);
      }
    }

    private float getAvgFFT() {
      //Controls FFT smoothing
      for(int i = 0; i < specSize; i++) {
        float band = fft.getBand(i);
        fftSmooth[i] *= smoothMapped;
        if(fftSmooth[i] < band) 
          fftSmooth[i] = band;
      }
      float sum = 0;
      for(int i = max(targetFreq - bandwidth/2,0); i <= targetFreq+bandwidth/2 || i>=specSize;i++) {
        sum += fftSmooth[i];
      }
      return sum/bandwidth;
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
