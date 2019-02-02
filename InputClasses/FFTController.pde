

class FFTController {

    private AudioPlayer nonLiveAudio;
    private AudioInput liveAudio;
    private Minim minim;
    private SoundDecorator inputArray[];
    private boolean isLive;
    private FFT fft;

    FFTController(SoundDecorator arrayInput[],PApplet app) {
        minim = new Minim(app);
        inputArray = arrayInput;
        liveAudio = minim.getLineIn(Minim.STEREO, 512);
        nonLiveAudio = minim.loadFile("groove.mp3", 1024);
        setFFT();
    }

    public void updateModel(int number, float value) {
        if (number == LIVE_AUDIO) {
            toggleLive();
        }
        else if (number == SMOOTHER) {
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setSmoother(value);
            }
        }
        //controlling the target frequency for the fft
        else if(number == TARGET_FREQ_MIN || number == TARGET_FREQ_MAX) {
            changeTargetFreq(number);
        }
        else if(KNOB_MAP.get(number) != null) {
            if (value==127){ //FIX EXPLICIT REFERENCE TO MIDI
              inputArray[MIDI_MAP.get(KNOB_MAP.get(number))].toggleOn();
            }
        }

        driveFFT();

        if (MIDI_MAP.get(number)!=null){
          inputArray[MIDI_MAP.get(number)].updateVal(value);
        }
    }

    public input[] fetchInputs(){
        return inputArray;
    }

    public void refresh(){
        driveFFT();
        for (int i=0; i<inputArray.length; i++){
            inputArray[i].setDecorateVal();
        }
    }

    private void driveFFT(){
        if(isLive) {
            fft.forward(liveAudio.left);
        }else {
            fft.forward(nonLiveAudio.mix);
        }
        for (int i=0; i<inputArray.length; i++){
            inputArray[i].toggleFFT(fft);
        }
    }

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

    private void toggleLive() {
        isLive = !isLive;
        setFFT();
    }

    private void setFFT(){
        if(isLive){
            fft = new FFT(liveAudio.bufferSize(), liveAudio.sampleRate());
        }
        else {
            nonLiveAudio.loop();
            fft = new FFT(nonLiveAudio.bufferSize(), nonLiveAudio.sampleRate());
        }
        for (int i=0; i<inputArray.length; i++) {
            inputArray[i].toggleFFT(fft);
        }
    }
}
