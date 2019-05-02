
//IMPORTS FOLLOW - Double check to make sure these are necessary!
import themidibus.*;

public class OutputQuad extends QuadObject{
	private HashMap<String, Integer> map = MidiMapper.getSpecialButtons();
	private float angle = 0.0;
	private float offset = 0.0;
	private float w = 24;
	private float a = angle + offset;
	private float h = map(sin(a),-1,1,0,700);

	OutputQuad(PApplet app, PGraphics buffer){
	  MidiBus.list();  // Shows controllers in the console
		//Deleted new Midi initialization
	  
	  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be max @ start
	    params.get(i) = 127; // Replaced: 	    cc[i] = 127;
	  }
	   background (255);
	   //noStroke();
	}

	@Override
	protected void runSketch(Arraylist<Float> params){
		tempBuffer.beginDraw()
	 float op = map(params.get(19),0,127,20,255); // Replaced: 	 float op = map(cc[19],0,127,20,255);
	  tempBuffer.translate(tempBuffer.width/2,tempBuffer.height/2);
	  tempBuffer.rectMode(CENTER);
	  tempBuffer.fill(255,op);
	rect(0,0,tempBuffer.width,tempBuffer.height);
	  
	  w = map(params.get(map.get("Y_Skew")),0,127,.1, 800); // Replaced: 	  w = map(cc[18],0,127,.1, 800);
	  for(float x = 0; x < tempBuffer.width; x +=w){
	    float a = angle + offset;
	  float h = map(sin(a),-1,1,0,700);
	  tempBuffer.fill(255);
	  float sW = map(params.get(20),0,127,.2,1.2); // Replaced: 	  float sW = map(cc[20],0,127,.2,1.2);
	  tempBuffer.strokeWeight(sW);
	  tempBuffer.ellipse(x- tempBuffer.width/2 + w/2,0,w, h);
	  offset += map(params.get(map.get("X_Skew")),0,127,.009,9); // Replaced: 	  offset += map(cc[17],0,127,.009,9);
	  }
	  angle += map(params.get(map.get("Fade")),0,127,.009,9); // Replaced: 	  angle += map(cc[16],0,127,.009,9);
	 
	
		tempBuffer.endDraw();
	}

}

