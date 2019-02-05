/**
* Sound Input is an implemented decorator that uses a Fast Fourier
* Transformation to update (decorate) input values without being
* noticed by the clien (InputController)
*/

class SoundDecorator extends InputDecorator{
  
    //NEEDS COMMENTS
    private int specSize;
    private int targetFreq; // Low is for lower frequencies
    private int bandwidth; //Width of frequency band, larger is a smoother responce
    private double fftAvg;
    private boolean isOn;
    private double smoothMapped;
    private double[] fftSmooth;
    private FFT fft;

    /**
    * Constructor initializes field values
    * @param inputComp : reference to base input value
    */
    SoundDecorator(input inputComp) {
      super(inputComp);
      targetFreq = 10;
      bandwidth = 20;
      fftAvg = 0;
      smoothMapped = 0.85;
      isOn=false;
    }

    /**
    * Update base value, overloads super class method
    * @param inputVal : raw input value
    */
    public void updateVal(double inputVal) {
      //setDecorateVal();
      inputComponent.updateVal(inputVal);
    }

    /**
    * Update decorate value
    */
    public void setDecorateVal(){
      if (isOn){
        fftAvg = getAvgFFT();
        decorateVal = (double) map((float)fftAvg,(float)0,60,0,INPUT_MAX*2);
      }else {
        decorateVal = 0;
      }
    }

    /**
    * Update FFT-related fields with new FFT object
    * @param fourierTrans : new FFT object
    */
    public void updateFFT(FFT fourierTrans) {
      fft = fourierTrans;
      specSize = fft.specSize();
      fftSmooth = new double[specSize];
    }

    /**
    * Flip active switch
    */
    public void toggleOn() {
      isOn = !isOn;
    }

    /**
    * Set new smoothing value
    * @param smoothRaw : raw smoothing value
    */
    public void setSmoother(double smoothRaw) {
      smoothMapped = (double) map((float) smoothRaw,INPUT_MIN,INPUT_MAX,0.0,1.0);
    }

    /**
    * Handle change in min or max target frequency
    * @param isMin : is change in min or max target freq
    */
    public void setTargetFreq(boolean isMin) {
      if (isMin){
        targetFreq = min(500, targetFreq+10);
      } else {
        targetFreq = max(0,targetFreq - 10);
      }
    }

    /**
    * @return 
    */
    private double getAvgFFT() {
      //Controls FFT smoothing
      for(int i = 0; i < specSize; i++) {
        double band = fft.getBand(i);
        fftSmooth[i] *= smoothMapped;
        if(fftSmooth[i] < band) 
          fftSmooth[i] = band;
      }
      double sum = 0;
      for(int i = max(targetFreq - bandwidth/2,0); i <= targetFreq+bandwidth/2 || i>=specSize;i++) {
        sum += fftSmooth[i];
      }
      return sum/bandwidth;
    }
}
