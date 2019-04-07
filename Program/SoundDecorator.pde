/**
* Sound Input is an implemented decorator that uses a Fast Fourier
* Transformation to update (decorate) InputObj values without being
* noticed by the clien (InputController)
*/

class SoundDecorator extends InputDecorator{
  
    private boolean isOn;
    /**
    * Constructor initializes field values
    * @param inputComp : reference to base InputObj value
    */
    SoundDecorator(InputObj inputComp) {
      super(inputComp);
      isOn=false;
    }

    /**
    * Update base value, overloads super class method
    * @param inputVal : raw InputObj value
    */
    public void updateVal(double inputVal) {
      //setDecorateVal();
      inputComponent.updateVal(inputVal);
    }

    /**
    * Update decorate value
    */
    public void setDecorateVal(float fftAvg, float sensitivity){
      if (isOn){
        float sensitivityAdjust = map(sensitivity,inputMap.INPUT_MIN,inputMap.INPUT_MAX,0.0,8.0);
        decorateVal = (double) map(fftAvg,0.0,60.0,inputMap.INPUT_MIN,inputMap.INPUT_MAX*sensitivityAdjust);
      }else {
        decorateVal = 0;
      }
    }

    /**
    * Flip active switch
    */
    public void toggleOn() {
      isOn = !isOn;
    }
}
