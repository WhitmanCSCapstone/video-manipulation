public class RealVidQuad extends VideoQuad{

    private Capture cam;
    
    RealVidQuad(PApplet app){
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
    //Draw to final buffer, currently not using params
    void drawToBuffer(PGraphics buffer, double[] params){
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }
}
