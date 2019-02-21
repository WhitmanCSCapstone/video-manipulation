/**
* The Input class is an abstract class that represents
* a continuous value translate from one or multiple inputs
* such as sound, midi, or keyboard.
*/
class InputObj {
  
    //Base value
    public double value;
    
    /**
    * Constructor sets initial value
    */
    InputObj(){
      value = 0;
    }
    
    /**
    * Sets value
    * @param inputVal : new value
    */
    public void updateVal(double inputVal) {
      value = inputVal;
    }
    
    /**
    * Returns value
    * @return value
    */
    public double getVal(){
      return value;
    }
}
