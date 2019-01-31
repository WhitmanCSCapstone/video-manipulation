

class Input {
  
  float val[];
  boolean midiPresent;
  int chanNum;
  
  Input(int channelNum){
    chanNum = channelNum;
  }  
  public void initialize(){
    MidiBus.list();
    myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
    val = new float[chanNum];
    if (myBus.attachedInputs().length > 0){
      midiPresent = true;
    }
    else {
      midiPresent = false;
    }
  }
  
  public float[] getVal(){
    if (midiPresent){
      val[0] = cc[17];
      val[1] = cc[18];
    }
    else {
      if (mousePressed){
        val[0] = mouseX;
        val[1] = mouseY;
      }
    }
    return val;
  }
  
}
