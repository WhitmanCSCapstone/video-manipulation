public class RecordedVideoQuad extends VideoQuad{

    private Movie mov;
    
    RecordedVideoQuad(PApplet app, PGraphics buffer){
        //TODO fix resolution thingy
        mov = new Movie(app, RECORDED_VIDEO);
        tempBuffer = createGraphics(buffer.width,buffer.height);
        mov.loop();
        mov.pause();
    }
    void readData(){
        if (mov.available() == true) {
            mov.read();
      }
    }
    //Also draw to tempbuffer
    @Override
    void applyFilters(){
        tempBuffer.image(mov,0,0);
    }

    @Override
    public void runSketch(ArrayList<Float> params){}

}
