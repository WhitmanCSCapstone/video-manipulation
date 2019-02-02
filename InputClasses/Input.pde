/**
* The Input class is an abstract class that represents
* a continuous value translate from one or multiple inputs
* such as sound, midi, or keyboard.
*/
class input {

    /* UML DIAGRAM
    public int value;
    public int mapMin;
    public int mapMax;
    public void updateVal(){}xq
    */
    
    private float value;
    //private double mapMin;
    //private double mapMax;
    
    input(){
      value = 0;
    }
    
    public void updateVal(float inputVal) {
      value = inputVal;
    }
    
    public float getVal(){
      return value;
    }
}
