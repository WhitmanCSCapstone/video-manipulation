public class RealVidQuad extends VideoQuad{

    private Camera cam;
    
    RealVidQuad(){
        //TODO fix resolution thingy
        String[] cameras = Capture.list();
        cam = new Capture(app, cameras[0]);
        tempBuffer = createGraphics(buffer.width,buffer.height);
    }
    readData(){
        if (cam.available())
            cam.read();
    }
    applyFilters(){
        tempBuffer.image(cam,0,0);
    }
    drawToBuffer(PGraphics buffer, ArrayList<double> params){
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }
}