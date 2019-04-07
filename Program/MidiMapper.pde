public static class MidiMapper{

    final static HashMap<Integer, Integer> soundButtonToInputMap;
    final static HashMap<Integer, Integer> buttonIDtoArrayIndexMap;
    final static HashMap<String, Integer> specialButtonIDMap;

    final static float INPUT_MIN = 0;
    final static float INPUT_MAX = 127;

    //Static block is run when this object is pulled into memory.
    //These blocks will initialize the mapping fields above
    static{ //Initialize "S" button ID -> knob ID mapping
        soundButtonToInputMap = new HashMap<Integer, Integer>();
        soundButtonToInputMap.put(32, 16);
        soundButtonToInputMap.put(64,  0);
        soundButtonToInputMap.put(33, 17);
        soundButtonToInputMap.put(65,  1);
        soundButtonToInputMap.put(34, 18);
        soundButtonToInputMap.put(66,  2);
        soundButtonToInputMap.put(35, 19);
        soundButtonToInputMap.put(67,  3);
        soundButtonToInputMap.put(36, 20);
        soundButtonToInputMap.put(68,  4);
        soundButtonToInputMap.put(37, 21);
        soundButtonToInputMap.put(69,  5);
        soundButtonToInputMap.put(38, 22);
        soundButtonToInputMap.put(70,  6);
        soundButtonToInputMap.put(39, 23);
        soundButtonToInputMap.put(71,  7);
    }

    //initialize button ID -> array index mapping
    static{
        buttonIDtoArrayIndexMap = new HashMap<Integer, Integer>();
        buttonIDtoArrayIndexMap.put(19, 0);
        buttonIDtoArrayIndexMap.put( 3, 1);
        buttonIDtoArrayIndexMap.put(20, 2);
        buttonIDtoArrayIndexMap.put( 4, 3);
        buttonIDtoArrayIndexMap.put(21, 4);
        buttonIDtoArrayIndexMap.put( 5, 5);
        buttonIDtoArrayIndexMap.put(22, 6);
        buttonIDtoArrayIndexMap.put( 6, 7);
        buttonIDtoArrayIndexMap.put(23, 8);
        buttonIDtoArrayIndexMap.put( 7, 9);
        buttonIDtoArrayIndexMap.put(16, 10);
        buttonIDtoArrayIndexMap.put( 0, 11);
        buttonIDtoArrayIndexMap.put(17, 12);
        buttonIDtoArrayIndexMap.put( 1, 13);
        buttonIDtoArrayIndexMap.put(18, 14);
        buttonIDtoArrayIndexMap.put( 2, 15);
        buttonIDtoArrayIndexMap.put(32, 16);
        buttonIDtoArrayIndexMap.put(64, 17);
        buttonIDtoArrayIndexMap.put(33, 18);
        buttonIDtoArrayIndexMap.put(65, 19);
        buttonIDtoArrayIndexMap.put(34, 20);
        buttonIDtoArrayIndexMap.put(66, 21);
        buttonIDtoArrayIndexMap.put(35, 22);
        buttonIDtoArrayIndexMap.put(67, 23);
        buttonIDtoArrayIndexMap.put(36, 24);
        buttonIDtoArrayIndexMap.put(68, 25);
        buttonIDtoArrayIndexMap.put(37, 26);
        buttonIDtoArrayIndexMap.put(69, 27);
        buttonIDtoArrayIndexMap.put(38, 28);
        buttonIDtoArrayIndexMap.put(70, 29);
        buttonIDtoArrayIndexMap.put(39, 30);
        buttonIDtoArrayIndexMap.put(71, 31);
        buttonIDtoArrayIndexMap.put(43, 32);
        buttonIDtoArrayIndexMap.put(44, 33);
        buttonIDtoArrayIndexMap.put(42, 34);
        buttonIDtoArrayIndexMap.put(41, 35);
        buttonIDtoArrayIndexMap.put(45, 36);
        buttonIDtoArrayIndexMap.put(61, 37);
        buttonIDtoArrayIndexMap.put(62, 38);
    }

    //initialize special button name -> button ID
    static{
        specialButtonIDMap = new HashMap<String, Integer>();
        specialButtonIDMap.put("Fade", 16); //fade
        specialButtonIDMap.put("X_Skew", 17); //x skew
        specialButtonIDMap.put("Y_Skew", 18); //y skew
        specialButtonIDMap.put("Zoom", 0); //zoom
        specialButtonIDMap.put("X_Rotation", 1); //x rotation
        specialButtonIDMap.put("Y_Rotation", 2); //y rotation
        specialButtonIDMap.put("FFT_Smoother", 7); //fft smoother
        specialButtonIDMap.put("Previous_Sketch", 43); //previous sketch
        specialButtonIDMap.put("Next_Sketch", 44); //next sketch
        specialButtonIDMap.put("Freeze_Quad", 42); //fix sketch to 2d
        specialButtonIDMap.put("Start_Track", 41); //start audio track
        specialButtonIDMap.put("Live_Audio", 45); //switch to live audio.
        specialButtonIDMap.put("Decrease_Target_Freq", 61); //decrease target frequency of fft
        specialButtonIDMap.put("Increase_Target_Freq", 62); //increase target frequency of fft
        specialButtonIDMap.put("FFT_Sensitivity", 23); //change sensitivity
    }

    /*
     * Map buttons to the knobs they are closely connected to.
     * Mostly used to keep track of the buttons that control FFT for knobs.
     * Mapping: "S" button ID -> knob ID
     */
    public static Map<Integer,Integer> soundToInput() {
        return soundButtonToInputMap;
    }

    /*
     * Maps the button/knob ids on midi controller to their 
     * given positions for arrays. 
     * Mapping: Midi Button ID -> array index location ID
     */
    public static Map<Integer,Integer> buttonToArray() {
        return buttonIDtoArrayIndexMap;
    }

    /*
     * Maps the button/knob ids on midi controller to their 
     * given positions for arrays. 
     * Mapping: Midi Button ID -> array index location ID
     */
    public static Map<String,Integer> getSpecialButtons() {
        return specialButtonIDMap;
    }

}

/*
Mapping documentation:
This is the mapping that all inputs should follow. 
Specifically, all sketches will use array indices by following 
the index assignments.

Param Array Index Responsibilities & Midi mapping:
What Indices always hold what responsibility,
Which Midi buttons are mapped to those indices


Array Index ID,   Index Assignment,               ButtonID, ButtonName                                    
  00               sketch param 1                   19        slot4-knob
  01               sketch param 2                   03        slot4-slider
  02               sketch param 3                   20        slot5-knob
  03               sketch param 4                   04        slot5-slider
  04               sketch param 5                   21        slot6-knob
  05               sketch param 6                   05        slot6-slider
  06               sketch param 7                   22        slot7-knob             
  07               sketch param 8                   06        slot7-slider
  08               fft sensitivity                  23        slot8-knob
  09               fft smoother                     07        slot8-slider
  10               fade                             16        slot1-knob
  11               zoom                             00        slot1-slider
  12               x-axis skew                      17        slot2-knob
  13               x-axis rotation speed            01        slot2-slider
  14               y-axis skew                      18        slot2-knob
  15               y-axis rotation speed            02        slot2-slider
  16               fft toggle for fade              32        slot1-s
  17               fft toggle for zoom              64        slot1-r
  18               fft toggle for x-axis skew       33        slot2-s
  19               fft toggle for x rot speed       65        slot2-r
  20               fft toggle for y-axis skew       34        slot3-s
  21               fft toggle for y rot speed       66        slot3-r
  22               fft toggle for 00                35        slot4-s
  23               fft toggle for 01                67        slot4-r
  24               fft toggle for 02                36        slot5-s
  25               fft toggle for 03                68        slot5-r
  26               fft toggle for 04                37        slot6-s
  27               fft toggle for 05                69        slot6-r
  28               fft toggle for 06                38        slot7-s
  29               fft toggle for 07                70        slot7-r
  30               fft toggle for 08                39        slot8-s
  31               fft toggle for fft smoother      71        slot8-r
  32               prev sketch                      43        rewind
  33               next sketch                      44        fastforward
  34               freeze quad                      42        stop
  35               start/stop track                 41        start
  36               live audio                       45        record
  37               decrease target frequency        61        prev
  38               increase target frequency        62        next

*/