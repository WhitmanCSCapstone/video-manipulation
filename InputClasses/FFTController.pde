

class FFTController {

    private AudioPlayer nonLiveAudio;
    private AudioInput liveAudio;
    private Minim minim;
    private SoundDecorator inputArray[];
    private boolean isLive;
    private FFT fft;

    FFTController(SoundDecorator arrayInput,PApplet app) {
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
        else if(number == TARGET_FREQ_MIN || number = TARGET_FREQ_MAX) {
            changeTargetFreq();
        }

        else if(KNOB_MAP.get(number)) {
            inputArray[KNOB_MAP.get(number)].toggleOn();
        }

        if(isLive) {
        fft.forward(liveAudio.left);
        }else {
            fft.forward(nonLiveAudio.mix);
        }

        
        
        inputArray[number].updateVal(value);
    }

    private void changeTargetFreq(int number){
        if (number==TARGET_FREQ_MIN){
            for (int i=0; i<inputArray.length; i++) {
                inputArray[i].setTargetFreq(true);
            }
            targetFreq = min(500, targetFreq+10);
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

    private setFFT(){
        if(isLive){
            fft = new FFT(liveAudio.bufferSize(), liveAudio.sampleRate());
        }
        else {
            nonLiveAudio.loop();
            fft = new FFT(nonLiveAudio.bufferSize(), nonLiveAudio.sampleRate());
        }
        for (int i=0; i<inputArray.length; i++) {
            inputArray[i].setFFT(fft);
        }
    }
}
