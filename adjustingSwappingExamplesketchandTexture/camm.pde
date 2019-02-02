/**
 * Texture Quad. 
 * 
 * Load an image and draw it onto a quad. The texture() function sets
 * the texture image. The vertex() function maps the image to the geometry.
 */
class UCAM extends QUAD{
  void setup(PApplet app, PGraphics p) {
    mov = new Movie(app,"4l.mov");
    mov.loop();
    noStroke();
    mov.stop();
    String[] cameras = Capture.list();
    cam = new Capture(app, cameras[0]);
    cam.start();
  }
  
  void update(PGraphics p) {
    
    if(camLive){//Camera
      if (cam.available() == true) {
        cam.read();
      }
      p.image(cam,0,0,p.width,p.height);
      filter(GRAY);
    }else{//video
      if (mov.available() == true) {
        mov.read();
      }
      p.image(mov,0,0,p.width,p.height);
    } 
}
  
}
