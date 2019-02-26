/*
 * This object controls the different possible quads of the program.
 * It does things like pass values, tell to draw, construct them, decide which 
 * quad should be drawn.
 */
public class QuadContainer {

	/*
	 * Buffer that quads should be drawn to. What eventually gets drawn to screen.

	 */
	private PGraphics buffer;

	/*
	 * The quad that is currently selected to draw to the screen.
	 */
	public QuadObject selectedQuad;

	/*
	 * Array of Quad objects that can be selected and drawn to to screen independently of each other.
	 */
	public ArrayList<QuadObject> quads;

	/*
	 * Constructor to setup QuadContainer and the quads it will hold.
	 * By default, the first quad constructed is selected.
	 * The buffer size is also hardcoded to global constants
	 */
	QuadContainer(PApplet app){
		buffer = createGraphics(BUFFERWIDTH, BUFFERHEIGHT, P3D); //BUFFERWIDTH and HEIGHT are temporary testing constants
		quads = new ArrayList<QuadObject>();
		createAllQuads(app);
		selectedQuad = quads.get(0);
	}

	/*
	 * A more flexible constructor to give greater precision to how the buffer should be created.
	 * Will construct the contained quads and select quad 0 by default.
	 */
	QuadContainer(PApplet app, int bufferWidth, int bufferHeight){
		buffer = createGraphics(bufferWidth, bufferHeight, P3D); //BUFFERWIDTH and HEIGHT are temporary testing constants
		quads = new ArrayList<QuadObject>();
		createAllQuads(app);
		selectedQuad = quads.get(0);
	}

	/*
	 * The ID of the quad that shoudl be selected and drawn from now on.
	 * @param selectID the id of the quad that should now be drawn on the screen
	 * Also calls start/stop on video/camera quads
	 */
	public void selectNewQuad(int selectID)
	{
		selectedQuad = quads.get(selectID);
	}

	/*
	 * Deprecated: Update the properties using the values in a given list of Input objects
	 * @param params Array of input objects to pull update values from.
	 */
	public void updateProps(ArrayList<Float> params){}

	/*
	 * Use given params to tell selected quad to draw to a specific buffer
	 * @param params array of doubles containing the paramaters the quad should use to draw.
	 */
	public void drawToBuffer(ArrayList<Float> params)
	{
		beginShape();

		buffer.beginDraw();
		selectedQuad.drawToBuffer(buffer,params);
		buffer.endDraw();

		//map contents of buffer to screen
		texture(buffer);
		vertex(-BUFFERWIDTH, -BUFFERHEIGHT, 0, 0, 0); //params: x, y, z, u, v
		vertex(BUFFERWIDTH, -BUFFERHEIGHT, 0, buffer.width, 0);
		vertex(BUFFERWIDTH, BUFFERHEIGHT, 0, buffer.width, buffer.height);
		vertex(-BUFFERWIDTH, BUFFERHEIGHT, 0, 0, buffer.height);

		endShape();

	}

	/*
	 * Helper method to create the quads on startup.
	 	Makes the quads and puts them in the quad array
	 */
	public void createAllQuads(PApplet app)
	{
		//quads.add(new TextQuad(buffer));
		quads.add(new SuperShapeQuad(buffer));
		// quads.add(new RealVidQuad(app, buffer));
		// quads.add(new RecordedVideoQuad(app, buffer));
	}

}
