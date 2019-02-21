public class MidiMapper {

    /*
     * Map buttons to the knobs they are closely connected to.
     * Mostly used to keep track of the buttons that control FFT for knobs.
     */
    public static Map<Integer,Integer> buttonToKnob() {
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        map.put(32,16);
        map.put(33,17);
        map.put(34,18);
        map.put(35,19);
        return map;
    }

    /*
     * Maps the button/knob ids on midi controller to their 
     * given positions for arrays. 
     */
    public static Map<Integer,Integer> buttonToArray() {
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        map.put(16,0);
        map.put(17,1);
        map.put(18,2);
        map.put(19,3);
        return map;
    }


}
