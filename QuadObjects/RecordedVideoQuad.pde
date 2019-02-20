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
    //Final draw to real buffer - currently not using params
    @Override
    void drawToBuffer(PGraphics buffer,ArrayList<Float> params){
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }

    @Override
    public void executeHandlers(ArrayList<Float> params){}

}
