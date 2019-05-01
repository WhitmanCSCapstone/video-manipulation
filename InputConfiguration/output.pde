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
	  tempBuffer.translate(0,tempBuffer.height *.1,0);
	  float ma = map(params.get(map.get("Fade")), 0,127,.0,.1); // Replaced: 	  float ma = map(cc[16], 0,127,.0,.1);
	  tempBuffer.rotateX (rx1);
	  rx1 = rx1 + ma;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, 0, 0, 0);
	  tempBuffer.vertex(tempBuffer.width, 0, cam.width,0);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height*.2, cam.width, cam.height*.2);
	  tempBuffer.vertex(0, tempBuffer.height *.2, 0, cam.height* .2);
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	  tempBuffer.pushMatrix();
	  tempBuffer.translate(0,tempBuffer.height *.3,0);
	  float na = map(params.get(map.get("X_Skew")), 0,127,.0,.1); // Replaced: 	  float na = map(cc[17], 0,127,.0,.1);
	  tempBuffer.rotateX (rx2);
	  rx2 = rx2 + na;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, tempBuffer.height*.2, 0, cam.height *.2);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height *.2,cam.width, cam.height * .2);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height * .4, cam.width, cam.height *.4);
	  tempBuffer.vertex(0, tempBuffer.height * .4, 0, cam.height *.4);
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	  tempBuffer.pushMatrix();
	  tempBuffer.translate(0,tempBuffer.height *.5,0);
	  float oa = map(params.get(map.get("Y_Skew")), 0,127,.0,.1); // Replaced: 	  float oa = map(cc[18], 0,127,.0,.1);
	  tempBuffer.rotateX (rx3);
	  rx3 = rx3 + oa;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, tempBuffer.height * .4,0, cam.height *.4);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height * .4, cam.width, cam.height *.4);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height *.6, cam.width, cam.height *.6);
	  tempBuffer.vertex(0, tempBuffer.height *.6, 0,cam.height *.6);
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	  tempBuffer.pushMatrix();
	  tempBuffer.translate(0,tempBuffer.height *.7,0);
	  float pa = map(params.get(19), 0,127,.0,.1); // Replaced: 	  float pa = map(cc[19], 0,127,.0,.1);
	  tempBuffer.rotateX (rx4);
	  rx4 =rx4 +pa;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, tempBuffer.height *.6, 0, cam.height * .6);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height * .6, cam.width, cam.height * .6);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height * .8, cam.width, cam.height * .8);
	  tempBuffer.vertex(0, tempBuffer.height * .8, 0, cam.height * .8);
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	  tempBuffer.pushMatrix();
	  tempBuffer.translate(0,tempBuffer.height *.9,0);
	  float qa = map(params.get(20), 0,127,.0,.1); // Replaced: 	  float qa = map(cc[20], 0,127,.0,.1);
	  tempBuffer.rotateX (rx5);
	  rx5 =rx5 +qa;
	  tempBuffer.beginShape();
	  tempBuffer.texture(cam);
	  tempBuffer.vertex(0, tempBuffer.height *.8, 0, cam.height * .8);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height * .8, cam.width, cam.height * .8);
	  tempBuffer.vertex(tempBuffer.width, tempBuffer.height , cam.width, cam.height );
	  tempBuffer.vertex(0, tempBuffer.height, 0, cam.height );
	  tempBuffer.endShape();
	  tempBuffer.popMatrix();
	  
	  //Preview the whole image
	  tempBuffer.image(cam, 0, 0, cam.width/8, cam.height/8);
		tempBuffer.endDraw();
	}

}

