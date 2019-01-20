/**
* The Input Decorator is an abstract interface that contains
* reference to the decorated object (MIDI input).  Specific decorators
* like SoundInput add additional decorating behavior.
*/

class InputDecorator extends Input {

    public Input inputComponent;

}
