/**
* The FFTController is owned by the InputController, manages
* live and nonlive audio input, and handles unique sound-related
* input changes like smoothing and live audio switching.
*/

class FFTController {


    Map<Integer,Integer> INDEX_MAP;
    Map<Integer,Integer> SOUND_MAP;
    Map<String,Integer> SPECIAL_MAP;

    private AudioSource audio;

    //nonLiveAudio: created from mp3 file loaded in
    private AudioPlayer nonLiveAudio;
    //liveAudio: loaded in from mic
    private AudioInput liveAudio;
    //minim: Minim object used to create fft objects
    private Minim minim;
    //inputArray: state of program
    private SoundDecorator inputArray[];
    //isLive: toggles live and prerecorded audio
    private boolean isLive;
    //fft: switches off being live audio fft and prerecorded fft
    private FFT fft;

    private int specSize;
    private int targetFreq; // Low is for lower frequencies
    private int bandwidth; //Width of frequency band, larger is a smoother responce
    private double fftAvg;
    private boolean isOn;
    private double smoothMapped;
    private double[] fftSmooth;
    private float sensitivity;

    private float inputMin = inputMap.INPUT_MIN;
    private float inputMax = inputMap.INPUT_MAX;

    /**
    * Constructor creates minim object and loads sound file
    * @param arrayInput[] : SoundDecorator objects passed from InputController
    * @param app : used to construct minim object
    */
    FFTController(SoundDecorator arrayInput[],PApplet app) {


        targetFreq = 10;
        bandwidth = 20;
        fftAvg = 0;
        smoothMapped = 0.85;

        INDEX_MAP = inputMap.buttonToArray();
        SOUND_MAP = inputMap.soundToInput();
        SPECIAL_MAP = inputMap.getSpecialButtons();
        minim = new Minim(app);
        inputArray = arrayInput;
        isLive = false;

        nonLiveAudio = minim.loadFile(MP3_NAME, 1024);
        liveAudio = minim.getLineIn(Minim.MONO);
        audio = nonLiveAudio;

        fft = new FFT(audio.bufferSize(),audio.sampleRate());
        specSize = fft.specSize();
        fftSmooth = new double[specSize];
        setFFT();
    }

    /**
    * Updates state of program and handles special button presses
    * @param number : which input/button is triggered
    * @param value : value of that input
    */
    public void updateModel(int number, float value) {
        //Handles live/non-live audio switching
        if (SPECIAL_MAP.get("Live_Audio") == number && value == inputMax) {
            toggleLive();
        }
        //Handles FFT smoothing change
        else if (SPECIAL_MAP.get("FFT_Smoother") == number) {
            smoothMapped = (double) map(value,inputMin,inputMax,0.0,1.0);
        }
        
        //Handles change in target frequency min and max
        else if(SPECIAL_MAP.get("Decrease_Target_Freq") == number) {
            setTargetFreq(true);
        }
        else if(SPECIAL_MAP.get("Increase_Target_Freq") == number) {
            setTargetFreq(false);
        }
        else if(SPECIAL_MAP.get("FFT_Sensitivity") == number) {
            changeSensitivity(value);
        }

        //Handles change in FFT listening button
        else if(SOUND_MAP.get(number) != null) {
            if (value==inputMax){
              inputArray[INDEX_MAP.get(SOUND_MAP.get(number))].toggleOn();
            }
        }
        //Handles normal input change
        if (INDEX_MAP.get(number)!=null){
          inputArray[INDEX_MAP.get(number)].updateVal(value);
        }
    }
    /**
    * Returns state of program
    * @return inputArray : InputObj objects
    */
    public InputObj[] fetchInputs(){
        return inputArray;
    }

    /**
    * Updates sound decorate values for all InputObj objects
    */
    public void refresh(){
        driveFFT();
        for (int i=0; i<inputArray.length; i++){
            inputArray[i].setDecorateVal((float)fftAvg,sensitivity);
        }
    }

    /**
    * Advance FFT forward and update spec values in all InputObj objects
    */
    private void driveFFT(){
        fft.forward(audio.left);

        getAvgFFT();
    }

    /**
    * Handle change of minimum or maximum target frequency
    * @param number : input/button number to determine if its min or max
    */
    private void changeTargetFreq(int number){
        /*
        if (number==TARGET_FREQ_MIN){
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setTargetFreq(true);
            }
        } else {
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setTargetFreq(false);
            }
        }
        */
    }

    /**
    * Switch live audio setting and reset FFT
    */
    private void toggleLive() {
        isLive = !isLive;
        setFFT();
    }

    /**
    * Reset FFT
    */
    private void setFFT(){
        if(isLive){
            audio = liveAudio;
            nonLiveAudio.pause();
            //liveAudio.enableMonitoring();
        }
        else {
            audio = nonLiveAudio;
            //liveAudio.disableMonitoring();
            nonLiveAudio.play();
        }

        fft = new FFT(audio.bufferSize(),audio.sampleRate());
    }

    private void getAvgFFT() {
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
        fftAvg = sum/bandwidth;
    }

    private void setTargetFreq(boolean isMin) {
      if (isMin){
        targetFreq = min(500, targetFreq+10);
      } else {
        targetFreq = max(0,targetFreq-10);
      }
    }

    private void changeSensitivity(float newSensitivity){
        sensitivity = newSensitivity; 
    }

}
