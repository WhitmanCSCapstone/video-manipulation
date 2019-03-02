public static class MidiMapper {

    final static HashMap<Integer, Integer> buttonToKnobMap;
    final static HashMap<Integer, Integer> buttonToSliderMap;
    final static HashMap<Integer, Integer> buttonIDtoArrayIndexMap;

    //Static block is run when this object is pulled into memory.
    //These blocks will initialize the mapping fields above
    static{ //Initialize "S" button ID -> knob ID mapping
        buttonToKnobMap = new HashMap<Integer, Integer>();
        buttonToKnobMap.put(32, 16);
        buttonToKnobMap.put(33, 17);
        buttonToKnobMap.put(34, 18);
        buttonToKnobMap.put(35, 19);
        buttonToKnobMap.put(36, 20);
        buttonToKnobMap.put(37, 21);
        buttonToKnobMap.put(38, 22);
        buttonToKnobMap.put(39, 23);
    }
    //Initialize "R" button ID -> slider ID mapping
    static{
        buttonToSliderMap = new HashMap<Integer, Integer>();
        buttonToSliderMap.put(64, 0);
        buttonToSliderMap.put(65, 1);
        buttonToSliderMap.put(66, 2);
        buttonToSliderMap.put(67, 3);
        buttonToSliderMap.put(68, 4);
        buttonToSliderMap.put(69, 5);
        buttonToSliderMap.put(70, 6);
        buttonToSliderMap.put(71, 7);
    }
    //initialize button ID -> array index mapping
    static{
        buttonIDtoArrayIndexMap = new HashMap<Integer, Integer>();
        buttonIDtoArrayIndexMap.put(58, 0);
        buttonIDtoArrayIndexMap.put(59, 1);
        buttonIDtoArrayIndexMap.put(46, 2);
        buttonIDtoArrayIndexMap.put(60, 3);
        buttonIDtoArrayIndexMap.put(61, 4);
        buttonIDtoArrayIndexMap.put(62, 5);
        buttonIDtoArrayIndexMap.put(43, 6);
        buttonIDtoArrayIndexMap.put(44, 7);
        buttonIDtoArrayIndexMap.put(42, 8);
        buttonIDtoArrayIndexMap.put(41, 9);
        buttonIDtoArrayIndexMap.put(45, 10);
        buttonIDtoArrayIndexMap.put(16, 11);
        buttonIDtoArrayIndexMap.put(00, 12);
        buttonIDtoArrayIndexMap.put(32, 13);
        buttonIDtoArrayIndexMap.put(48, 14);
        buttonIDtoArrayIndexMap.put(64, 15);
        buttonIDtoArrayIndexMap.put(17, 16);
        buttonIDtoArrayIndexMap.put(01, 17);
        buttonIDtoArrayIndexMap.put(33, 18);
        buttonIDtoArrayIndexMap.put(49, 19);
        buttonIDtoArrayIndexMap.put(65, 20);
        buttonIDtoArrayIndexMap.put(18, 21);
        buttonIDtoArrayIndexMap.put(02, 22);
        buttonIDtoArrayIndexMap.put(34, 23);
        buttonIDtoArrayIndexMap.put(50, 24);
        buttonIDtoArrayIndexMap.put(66, 25);
        buttonIDtoArrayIndexMap.put(19, 26);
        buttonIDtoArrayIndexMap.put(03, 27);
        buttonIDtoArrayIndexMap.put(35, 28);
        buttonIDtoArrayIndexMap.put(51, 29);
        buttonIDtoArrayIndexMap.put(67, 30);
        buttonIDtoArrayIndexMap.put(20, 31);
        buttonIDtoArrayIndexMap.put(04, 32);
        buttonIDtoArrayIndexMap.put(36, 33);
        buttonIDtoArrayIndexMap.put(52, 34);
        buttonIDtoArrayIndexMap.put(68, 35);
        buttonIDtoArrayIndexMap.put(21, 36);
        buttonIDtoArrayIndexMap.put(05, 37);
        buttonIDtoArrayIndexMap.put(37, 38);
        buttonIDtoArrayIndexMap.put(53, 39);
        buttonIDtoArrayIndexMap.put(69, 40);
        buttonIDtoArrayIndexMap.put(22, 41);
        buttonIDtoArrayIndexMap.put(06, 42);
        buttonIDtoArrayIndexMap.put(38, 43);
        buttonIDtoArrayIndexMap.put(54, 44);
        buttonIDtoArrayIndexMap.put(70, 45);
        buttonIDtoArrayIndexMap.put(23, 46);
        buttonIDtoArrayIndexMap.put(07, 47);
        buttonIDtoArrayIndexMap.put(39, 48);
        buttonIDtoArrayIndexMap.put(55, 49);
        buttonIDtoArrayIndexMap.put( 7, 50);
    }
    /*
     * Map buttons to the knobs they are closely connected to.
     * Mostly used to keep track of the buttons that control FFT for knobs.
     * Mapping: "S" button ID -> knob ID
     */
    public static Map<Integer,Integer> buttonToKnob() {
        return buttonToKnobMap;
    }

    /*
     * Map "R" buttons to the sliders they are closest to.
     * Mostly used to keep track of the buttons that control FFT for sliders.
     * Mapping: "R" button ID -> slider ID
     */
    public static Map<Integer,Integer> buttonToSlider() {
        return buttonToSliderMap;
    }

    /*
     * Maps the button/knob ids on midi controller to their 
     * given positions for arrays. 
     * Mapping: Midi Button ID -> array index location ID
     */
    public static Map<Integer,Integer> buttonToArray() {
        return buttonIDtoArrayIndexMap;

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
  00                                                58        trackleft
  01                                                59        trackright
  02                                                46        cycle
  03                                                60        marker-set
  04                                                61        marker-left
  05                                                62        marker-right
  06               Switch to previous sketch        43        rewind
  07               Switch to next sketch            44        fastworward
  08               Cycle through input source       42        stop
  09               Stop sound                       41        play
  10                                                45        record
  11               quad x-axis rotation speed       16        slot1-knob
  12               quad zoom                        00        slot1-slider
  13               fft toggle for 11                32        slot1-s
  14                                                48        slot1-m
  15               fft toggle for 12                64        slot1-r
  16               quad y-axis rotation speed       17        slot2-knob
  17                                                01        slot2-slider
  18               fft toggle for 16                33        slot2-s
  19                                                49        slot2-m
  20               fft toggle for 17                65        slot2-r
  21                                                18        slot3-knob
  22                                                02        slot3-slider
  23               fft toggle for 21                34        slot3-s
  24                                                50        slot3-m
  25               fft toggle for 22                66        slot3-r
  26                                                19        slot4-knob
  27                                                03        slot4-slider
  28               fft toggle for 26                35        lot4-s
  29                                                51        slot4-m
  30               fft toggle for 27                67        slot4-r
  31                                                20        slot5-knob
  32                                                04        slot5-slider
  33               fft toggle for 31                36        slot5-s
  34                                                52        slot5-m
  35               fft toggle for 32                68        slot5-r
  36                                                21        slot6-knob
  37                                                05        slot6-slider
  38               fft toggle for 36                37        slot6-s
  39                                                53        slot6-m
  40               fft toggle for 37                69        slot6-r
  41                                                22        slot7-knob
  42                                                06        slot7-slider
  43               fft toggle for 41                38        slot7-s
  44                                                54        slot7-m
  45               fft toggle for 42                70        slot7-r
  46                                                23        slot8-knob
  47                                                07        slot8-slider
  48               fft toggle for 46                39        slot8-s
  49                                                55        slot8-m
  50               fft toggle for 47                71        slot8-r





*/