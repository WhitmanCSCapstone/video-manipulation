/**
* The Input class is an abstract class that represents
* a continuous value translate from one or multiple inputs
* such as sound, midi, or keyboard.
*/
class input {
    
    public float value;
    
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
