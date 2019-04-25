//TODO nested loops.
//Another global comment

//IMPORTS FOLLOW - Double check to make sure these are necessary!
import processing.lib;
import another.processing.lib;
import themidibus.*;

public class OutputQuad extends QuadObject{
	private PVector [][] globe;
m
	private float f1 = 0.01;
	private int i1 = 1;
	private int laterGlobal = 2;
	private float globalWithComment = 3.0; // Comment on global
	private String[] stringarray;
	private PGraphics fifthGlobal;

	OutputQuad(PApplet app, PGraphics buffer){
	    size(200,200);
	    //Comment in setup()
	     myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");  // input and output g:-- Changed from SLIDER/KNOB for windows
	        for (int i = 16; i < 24; i++) {  // Sets only the knobs (16-23) to be reasonable @ start - will still jump
m
	        }
	}

	@Override
	protected void runSketch(Arraylist<Float> params){
		tempBuffer.beginDraw()
	    /* Multi line comment in 
	    draw
	    */
m
	    rect(mouseX,mouseY,10,10);/*Multi in one after text*/
	    i1 = i1 + 1;//Comment with {{}
	    //and with }}}
	    println(i1);
	}

	private int anotherfunc(){
	    int x = 0;
	    return x;
	}

	private float funcWithParams(float b)
	{//New line scope
	    return b;
	}

}

