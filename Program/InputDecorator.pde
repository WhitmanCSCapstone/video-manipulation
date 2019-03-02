/**
* The Input Decorator is an abstract class that contains a
* reference to the base InputObj.  Specific decorators
* like SoundDecorator add additional decorating behavior.
*/
class InputDecorator extends InputObj {

    //Reference to base InputObj object
    public InputObj inputComponent;

    //Value used to decorate 
    public double decorateVal;
    
    /**
    * Constructor initializes reference to base InputObj
    * @param inputCom : reference to base input object
    */
    InputDecorator(InputObj inputComp) {   
      inputComponent = inputComp;
      decorateVal = 0; 
    }
    
    /**
    * Returns value, overloads super class method
    * @return sum of base value and decorate value
    */
    public double getVal(){
      return (inputComponent.getVal()+decorateVal);
    }
    
}
