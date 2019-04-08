Capture cam;
public class RealVidQuad extends QuadObject{
    
    RealVidQuad(PApplet app, PGraphics buffer){
        //TODO fix resolution thingy
        String[] cameras = Capture.list();
        cam = new Capture(app, cameras[0]);
        tempBuffer = createGraphics(buffer.width,buffer.height,P3D);
        cam.start();
    }
    @Override
    protected void runSketch(ArrayList<Float> params){
        cam.read();
        tempBuffer.beginDraw();
        // tempBuffer.beginShape();
        // tempBuffer.texture(cam);
        //tempBuffer.background(255);
        //tempBuffer.rect(10,10,10,10);
        tempBuffer.image(cam,0,0,tempBuffer.width,tempBuffer.height);
        // tempBuffer.vertex(0,0, 0, 0, 0); //params: x, y, z, u, v
		// tempBuffer.vertex(tempBuffer.width, 0, 0, tempBuffer.width, 0);
		// tempBuffer.vertex(tempBuffer.width, tempBuffer.height, 0, tempBuffer.width, tempBuffer.height);
		// tempBuffer.vertex(0, tempBuffer.height, 0, 0, tempBuffer.height);
        // tempBuffer.endShape();
        tempBuffer.endDraw();
    }

}
