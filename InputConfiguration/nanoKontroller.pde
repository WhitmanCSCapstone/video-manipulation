/* 
 * Write Midi configuration to new MidiMapper.pde file.
 * Called in InputConfiguration.
*/
public static class nanoKontroller{

    //Stores the input pairs of strings and values
    public static HashMap<Integer,String> valToDesc = new HashMap<Integer,String>();
    public static HashMap<Integer,String> defaults;
    public static int totalButtons = 15;

    static{
        defaults = new HashMap<Integer,String>();
        defaults.put(16,"Fade"); //fade
        defaults.put(17,"X_Skew"); //x skew
        defaults.put(18,"Y_Skew"); //y skew
        defaults.put(0,"Zoom"); //zoom
        defaults.put(1,"X_Rotation"); //x rotation
        defaults.put(2,"Y_Rotation"); //y rotation
        defaults.put(7,"FFT_Smoother"); //fft smoother
        defaults.put(43,"Previous_Sketch"); //previous sketch
        defaults.put(44,"Next_Sketch"); //next sketch
        defaults.put(42,"Freeze_Quad"); //fix sketch to 2d
        defaults.put(41,"Start_Track"); //start audio track
        defaults.put(45,"Live_Audio"); //switch to live audio.
        defaults.put(61,"Decrease_Target_Freq"); //decrease target frequency of fft
        defaults.put(62,"Increase_Target_Freq"); //increase target frequency of fft
        defaults.put(23,"FFT_Sensitivity"); //change sensitivity
    }
    
    public static void fillDefaults(){
        for (int key : defaults.keySet()) {
            if(!valToDesc.containsKey(key)){
                valToDesc.put(key,defaults.get(key));
            }
        }
    }

    public static void updateMapping(int in,String functionality){
        valToDesc.put(in,functionality);
    }

    public static void generateFunction(){
        for (int key : valToDesc.keySet()) {
            println("Key: " + key + " Value: " + valToDesc.get(key));
        }
    }

}
