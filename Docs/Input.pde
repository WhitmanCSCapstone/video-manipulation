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
    
    /* CHANGES FROM UML
    public double value;
    private double mapMin;
    private double mapMax;
    public void updateVal(double inputVal){}
    public double getVal(){}
    */

    /**
    * This virtual method maps an input into the field "value"
    */
    public void updateVal(){}
}