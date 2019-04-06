/**
* The FFTController is owned by the InputController, manages
* live and nonlive audio input, and handles unique sound-related
* input changes like smoothing and live audio switching.
*/

class FFTController {

    public static final int LIVE_AUDIO = 45;
    public static final int TARGET_FREQ_MIN = 62;
    public static final int TARGET_FREQ_MAX = 61;

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

    private int bands = 512;

    /**
    * Constructor creates minim object and loads sound file
    * @param arrayInput[] : SoundDecorator objects passed from InputController
    * @param app : used to construct minim object
    */
    FFTController(SoundDecorator arrayInput[],PApplet app) {

        INDEX_MAP = inputMap.buttonToArray();
        SOUND_MAP = inputMap.soundToInput();
        SPECIAL_MAP = inputMap.getSpecialButtons();
        minim = new Minim(app);
        inputArray = arrayInput;
        isLive = false;
        /*
        if(liveAudio == null)
            print("No kick");
        */
        nonLiveAudio = minim.loadFile(MP3_NAME, 1024);
        liveAudio = minim.getLineIn(Minim.MONO);
        audio = nonLiveAudio;
        fft = new FFT(audio.bufferSize(),audio.sampleRate());
        setFFT();
    }

    /**
    * Updates state of program and handles special button presses
    * @param number : which input/button is triggered
    * @param value : value of that input
    */
    public void updateModel(int number, float value) {
        //Handles live/non-live audio switching
        if (SPECIAL_MAP.get("Live_Audio") == number && value == inputMap.INPUT_MAX) {
            toggleLive();
        }
        //Handles FFT smoothing change
        else if (SPECIAL_MAP.get("FFT_Smoother") == number) {
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setSmoother(value);
            }
        }
        /*
        //Handles change in target frequency min and max
        else if(number == TARGET_FREQ_MIN || number == TARGET_FREQ_MAX) {
            changeTargetFreq(number);
        }
        */
        //Handles change in FFT listening button
        else if(SOUND_MAP.get(number) != null) {
            if (value==inputMap.INPUT_MAX){
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
            inputArray[i].setDecorateVal();
        }
    }

    /**
    * Advance FFT forward and update spec values in all InputObj objects
    */
    private void driveFFT(){
        fft.forward(audio.left);

        for (int i=0; i<inputArray.length; i++){
            inputArray[i].updateFFT(fft);
        }
    }

    /**
    * Handle change of minimum or maximum target frequency
    * @param number : input/button number to determine if its min or max
    */
    private void changeTargetFreq(int number){
        if (number==TARGET_FREQ_MIN){
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setTargetFreq(true);
            }
        } else {
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setTargetFreq(false);
            }
        }
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
            liveAudio.enableMonitoring();
        }
        else {
            audio = nonLiveAudio;
            liveAudio.disableMonitoring();
            nonLiveAudio.play();
        }

        fft = new FFT(audio.bufferSize(),audio.sampleRate());

        for (int i=0; i<inputArray.length; i++) {
            inputArray[i].updateFFT(fft);
        }
    }
}
