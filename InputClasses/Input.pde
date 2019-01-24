/**
* The Input class is an abstract class that represents
* a continuous value translate from one or multiple inputs
* such as sound, midi, or keyboard.
*/
class Input {

    /* UML DIAGRAM
    public int value;
    public int mapMin;
    public int mapMax;
    public void updateVal(){}
    */
    
    private double value;
    //private double mapMin;
    //private double mapMax;
    
    Input(){
      value = 0;
    }
    
    public void updateVal(double inputVal) {
      value = inputVal;
    }
    
    public double getVal(){
      return value;
    }

}
