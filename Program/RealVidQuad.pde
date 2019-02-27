public class RealVidQuad extends VideoQuad{

    private Capture cam;
    
    RealVidQuad(PApplet app, PGraphics buffer){
        //TODO fix resolution thingy
        String[] cameras = Capture.list();
        cam = new Capture(app, cameras[0]);
        tempBuffer = createGraphics(buffer.width,buffer.height);
    }
    void readData(){
        if (cam.available())
            cam.read();
    }
    void applyFilters(){
        tempBuffer.image(cam,0,0);
    }

    @Override
    protected void executeHandlers(ArrayList<Float> params){}

}
