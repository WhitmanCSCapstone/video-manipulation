/**
* The FFTController is owned by the InputController, manages
* live and nonlive audio input, and handles unique sound-related
* input changes like smoothing and live audio switching.
*/

class FFTController {

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

    /**
    * Constructor creates minim object and loads sound file
    * @param arrayInput[] : SoundDecorator objects passed from InputController
    * @param app : used to construct minim object
    */
    FFTController(SoundDecorator arrayInput[],PApplet app) {
        minim = new Minim(app);
        inputArray = arrayInput;
        liveAudio = minim.getLineIn();
        if(liveAudio == null)
            print("No kick");
        nonLiveAudio = minim.loadFile(MP3_NAME, 1024);
        setFFT();
    }

    /**
    * Updates state of program and handles special button presses
    * @param number : which input/button is triggered
    * @param value : value of that input
    */
    public void updateModel(int number, double value) {
        //Handles live/non-live audio switching
        if (number == LIVE_AUDIO) {
            toggleLive();
        }
        //Handles FFT smoothing change
        else if (number == SMOOTHER) {
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setSmoother(value);
            }
        }
        //Handles change in target frequency min and max
        else if(number == TARGET_FREQ_MIN || number == TARGET_FREQ_MAX) {
            changeTargetFreq(number);
        }
        //Handles change in FFT listening button
        else if(KNOB_MAP.get(number) != null) {
            if (value==INPUT_MAX){
              inputArray[MIDI_MAP.get(KNOB_MAP.get(number))].toggleOn();
            }
        }
        //Handles normal input change
        if (MIDI_MAP.get(number)!=null){
          inputArray[MIDI_MAP.get(number)].updateVal(value);
        }
    }

    /**
    * Returns state of program
    * @return inputArray : input objects
    */
    public input[] fetchInputs(){
        return inputArray;
    }

    /**
    * Updates sound decorate values for all input objects
    */
    public void refresh(){
        driveFFT();
        for (int i=0; i<inputArray.length; i++){
            inputArray[i].setDecorateVal();
        }
    }

    /**
    * Advance FFT forward and update spec values in all input objects
    */
    private void driveFFT(){
        if(isLive) {
            fft.forward(liveAudio.left);
        }else {
            fft.forward(nonLiveAudio.mix);
        }
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
            fft = new FFT(liveAudio.bufferSize(), liveAudio.sampleRate());
        }
        else {
            nonLiveAudio.loop();
            fft = new FFT(nonLiveAudio.bufferSize(), nonLiveAudio.sampleRate());
        }
        for (int i=0; i<inputArray.length; i++) {
            inputArray[i].updateFFT(fft);
        }
    }
}