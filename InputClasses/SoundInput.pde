/**
* Sound Input is an implemented decorator that uses a Fast Fourier
* Transformation to update (decorate) input values without being
* noticed by the clien (InputController)
*/

class SoundInput extends InputDecorator{
  
    private input inputComponent;

    private int specSize;
    private int targetFreq; // Low is for lower frequencies
    private int bandwidth; //Width of frequency band, larger is a smoother responce
    private float fftAvg;
    private boolean isLive;
    private boolean isOn;
    private float smoothMapped;
    private FFT fft;
    private float[] fftSmooth;
    private AudioPlayer nonLiveAudio;
    private AudioInput liveAudio;
    
    private Minim minim;

    SoundInput(input inputComp, Minim minim) {   
      super(inputComp);
      targetFreq = 10;
      bandwidth = 20;
      fftAvg = 0;
      smoothMapped = 0.85;
      isLive = false;
      isOn = false;
      liveAudio = minim.getLineIn(Minim.STEREO, 512);
      nonLiveAudio = minim.loadFile("groove.mp3", // filename
                            1024      // buffer size
                         );
      liveAudio = minim.getLineIn(Minim.STEREO, 512);
      nonLiveAudio = minim.loadFile("groove.mp3", 1024);
      if(isLive){
        fft = new FFT(liveAudio.bufferSize(), liveAudio.sampleRate());
      }
      else {
        nonLiveAudio.loop();
        fft = new FFT(nonLiveAudio.bufferSize(), nonLiveAudio.sampleRate());
      }
      specSize = fft.specSize();
      fftSmooth = new float[specSize];
    }

    public void updateVal(float inputVal) {
      fftAvg = getAvgFFT();
      float adjust = map(fftAvg,0,60,0,255);
      if (!isOn) {
        adjust = 0;
      }
      inputComponent.updateVal(inputVal + adjust);
    }

    public void toggleFFT() {
      isOn = !isOn;
    }

    public void toggleLive() {
      isLive = !isLive;
      if(isLive)
      {
        nonLiveAudio.pause(); //optionally pause the audio while switching to live sound
        fft = new FFT(liveAudio.bufferSize(), liveAudio.sampleRate());
      }
      else
      {
        nonLiveAudio.loop(); //optionally pause the audio while switching to live sound
        fft = new FFT(nonLiveAudio.bufferSize(), nonLiveAudio.sampleRate());
      }
      specSize = fft.specSize();
      fftSmooth = new float[specSize];
    }

    public void setSmoother(float smoothRaw) {
      smoothMapped = map(smoothRaw,0,127,0.0,1.0);
    }

    private float getAvgFFT() {
      //Controls FFT smoothing
      if(isLive)
        fft.forward(liveAudio.left);
      else
        fft.forward(nonLiveAudio.mix);

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
