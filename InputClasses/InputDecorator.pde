/**
* The Input Decorator is an abstract class that contains a
* reference to the base input object.  Specific decorators
* like SoundDecorator add additional decorating behavior.
*/
class InputDecorator extends input {

    //Reference to base input object
    public input inputComponent;

    //Value used to decorate 
    public double decorateVal;
    
    /**
    * Constructor initializes reference to base input
    * @param inputCom : reference to base input object
    */
    InputDecorator(input inputComp) {   
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
