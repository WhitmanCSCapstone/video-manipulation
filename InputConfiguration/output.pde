/*
  keeptryingrotatingslats: First four midi knobs control the speed of rotating slats.
  They correspond top to bottom, first to last knob.
*/

//IMPORTS FOLLOW - Double check to make sure these are necessary!
import themidibus.*;
import processing.video.*;

public class OutputQuad extends QuadObject{
	private HashMap<String, Integer> map = MidiMapper.getSpecialButtons();
	private float rx1 = 0.0;
	private float rx2 = 0.0;
	private float rx3 = 0.0;
	private float rx4 = 0.0;
	private float rx5 = 0.0;
	private Movie cam;

	OutputQuad(PApplet app, PGraphics buffer){
	  //size(1280, 800, P2D);
	  MidiBus.list();  // Shows controllers in the console
		//Deleted new Midi initialization
	  
	  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
	    params.get(i) = 127/2; // Replaced: 	    cc[i] = 127/2;
	  }
	  cam = new Movie(this,"xxx.mov");
	  cam.loop();
	}

	@Override
	protected void runSketch(Arraylist<Float> params){
		tempBuffer.beginDraw()
	  if (cam.available() == true) {
	    cam.read();
	  }
	  tempBuffer.pushMatrix();
	  translate(0,tempBuffer.height *.1,0);
	  float ma = map(params.get(map.get("Fade")), 0,127,.0,.1); // Replaced: 	  float ma = map(cc[16], 0,127,.0,.1);
	  tempBuffer.rotateX (rx1);
	  rx1 = rx1 + ma;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, 0, 0, 0);
	  tempBuffer.vertex(tempBuffer.width, 0, cam.width,0);
	  vertex(width, tempBuffer.height*.2, cam.width, cam.height*.2);
	  vertex(0, tempBuffer.height *.2, 0, cam.height* .2);
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	
	
	
	
	
	
	
	
	
	
	
	
	
	  
	
	
	
	
	
	
	
	
	
	
	
	
	
	  
	
	
	
	
	
	
	
	
	
	
	
	
	
	  
	
	
	
	
	
	
	
	
	
	
	
	
	
	  
	  
	  
		tempBuffer.endDraw();
	}

}

