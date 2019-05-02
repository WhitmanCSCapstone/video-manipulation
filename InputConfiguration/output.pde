/*
  ColorMidi3DSupershapeTempStop: Generates a 3D image using midi controller. 
  This is aparams.get()ccomplished by mapping a whole bunch of values to the arrays.  // Replaced:   This is accomplished by mapping a whole bunch of values to the arrays. 
  Visualization is done with peasycam. 
  There is a lot of room for optimizing and fine tuning.
  Ask Justin where he got this code. It would be cool for sliders to control camera.
  https://www.youtube.com/watch?v=akM4wMZIBWg
*/

//IMPORTS FOLLOW - Double check to make sure these are necessary!
import themidibus.*;

public class OutputQuad extends QuadObject{
	private HashMap<String, Integer> map = MidiMapper.getSpecialButtons();
	private PVector [][] globe;
	private int total = 200;
	private float m = 0.0;
	private float mchange = 0.0;
	private float sm = 0.0;
	private float l = 0.0;
	private float offset = 0;
	private float xoffset = 400;
	private float yoffset = 400;
	private float a = 1;
	private float b = 1;

	OutputQuad(PApplet app, PGraphics buffer){
	  MidiBus.list();  // Shows controllers in the console
		//Deleted new Midi initialization
	  
	  for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be reasonable @ start - will still jump
	    params.get(i) = 20; // Replaced: 	    cc[i] = 20;
	  }
	  // cam = new PeasyCam(this,1000); //room for optimizing camera location
	  globe = new PVector[total+ 1][total+ 1];
	}

	@Override
	protected void runSketch(Arraylist<Float> params){
		tempBuffer.beginDraw()
	  //g: for all sketches, save cc to variables for clarity before doing stuff on them
	  
	  //Identify variables:
	  float polycount = params.get(map.get("Fade")); // Replaced: 	  float polycount = cc[16];
	  float vibrations = params.get(map.get("X_Skew")); // Replaced: 	  float vibrations = cc[17];
	  float period = params.get(map.get("Y_Skew")); // Replaced: 	  float period = cc[18];
	  float timestep = params.get(19); // Replaced: 	  float timestep = cc[19];
	  
	  l = map(timestep,0,127,1,127);
	  m = map(sin(mchange),-1,1,0,l);
	  sm = map(period,0,127,0.0, 0.009);
	  
	  //timestep
	  mchange += sm;
	  tempBuffer.background(0);
	  tempBuffer.noStroke();
	  //Generates shadows underfolds of polygons
	  tempBuffer.lights();
	  
	  float r = 200;
	  total = round(map(polycount,0,127,2,128));
	
	  for(int i = 0; i< toatal+1; i++){
	      float lat = map( i,0, total,- HALF_PI,HALF_PI);
	      float r2 = supershape(lat, m,10.0,10.0,10.0);
	      for(int j = 0; j< total + 1; j++){
	        float lon = map( j,0, total, - PI, PI);
	        float r1 = supershape(lon,m,60.0,100.0,30.0);
	        float x = r * r1 * cos(lon) * r2 * cos(lat);
	        float y = r * r1 *sin(lon) * r1 * r2 * cos(lat);
	        float z = r * r2 * sin(lat);
	        globe[i][j] = new PVector(x,y,z);
	
	        PVector v = PVector.random3D();
	        int u = round(map(vibrations,0,127,0,127));
	        v.mult(u);
	        globe[i][j].add(v);
	       }
	    }
	    offset+=5;
	    //Swapping where i and j are used to calculate hu switches stripes
	    //adding offset makes them flow in a cool way
	  for(int i = 0; i< total; i++){
	    tempBuffer.beginShape(TRIANGLE_STRIP);
	    float hu = map(i,0,total,0,255* 6);
	tempBuffer.fill((hu+offset) % 255,255,255);
	    for(int j = 0; j < total+ 1; j++){
	      PVector v1 = globe[i][j];
	      tempBuffer.vertex(v1.x+xoffset,v1.y+yoffset,v1.z);
	      PVector v2 = globe[i+1][j];
	      tempBuffer.vertex(v2.x+xoffset,v2.y+yoffset,v2.z);
	    }
	    tempBuffer.endShape();
	  }
		tempBuffer.endDraw();
	}

	private float supershape(float theta, float m, float n1, float n2, float n3){
	  float t1 = abs((1/a) * cos( m * theta /4));
	  t1 = pow(t1,n2);
	  float t2 = abs((1/b)*sin(m * theta/4));
	  t2 = pow(t2,n3);
	  float t3 = t1 + t2;
	  float r = pow(t3, -1/ n1);
	  return r;
	}

}

