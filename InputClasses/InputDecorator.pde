/**
* The Input Decorator is an abstract interface that contains
* reference to the decorated object (MIDI input).  Specific decorators
* like SoundInput add additional decorating behavior.
*/

class InputDecorator extends input {

    public input inputComponent;

    public float decorateVal;
    
    InputDecorator(input inputComp) {   
      inputComponent = inputComp;
      decorateVal = 0; 
    }
    
    public float getVal(){
      return (inputComponent.getVal()+decorateVal);
    }
    
}
