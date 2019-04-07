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
	private QuadObject selectedQuad;

	/*
	 * Array of Quad objects that can be selected and drawn to to screen independently of each other.
	 */
	private ArrayList<QuadObject> quads;

	/*
	 * Current rotation positions of the quad.
	 * Allows the quad to continuously spin
	 */
	private float xPrev = 0,yPrev = 0;

	private Map<Integer,Integer> INDEX_MAP = inputMap.buttonToArray();
	private Map<String,Integer> SPECIAL_MAP = inputMap.getSpecialButtons();

	private float inputMin = inputMap.INPUT_MIN;
	private float inputMax = inputMap.INPUT_MAX;

	private float fadeInput;
	private float xSkewInput;
	private float ySkewInput;
	private float xRotationInput;
	private float yRotationInput;
	private float zoomInput;

	private boolean isFixed;


	/*
	 * Constructor to setup QuadContainer and the quads it will hold.
	 * By default, the first quad constructed is selected.
	 * The buffer size is also hardcoded to global constants
	 */
	QuadContainer(PApplet app){
		buffer = createGraphics(app.width, app.height, P3D); //BUFFERWIDTH and HEIGHT are temporary testing constants
		quads = new ArrayList<QuadObject>();
		createAllQuads(app);
		selectedQuad = quads.get(0);
		isFixed = false;
		initializeProps();
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
		isFixed = false;
		initializeProps();
	}

	/*
	 * The ID of the quad that shoudl be selected and drawn from now on.
	 * @param selectID the id of the quad that should now be drawn on the screen
	 * Also calls start/stop on video/camera quads
	 * Negative arguments will not change the selectedQuad.
	 */
	public void selectNewQuad(int selectID) {
		int n = selectID;
		if (n >= quads.size()) {
			n = n % quads.size();
		}
		selectedQuad = quads.get(n);
	}

	/*
	 * In the array of quads, select the next one.
	 * If at the end of the array, start at index 0.
	 */
	public void selectNextQuad(){
		if (quads.size() <= 1) {
			return;
		}
		for (int i = 0; i < quads.size(); i++) {
			if (quads.get(i) == selectedQuad) {
				if (i == quads.size()-1) {
					selectNewQuad(0);
				} else{
					selectNewQuad(i+1);
				}
				return;
			}
		}
	} 

	/*
	 * In the array of quads, select the previous one.
	 * If at the start of the array, select the last element in quad.
	 */
	public void selectPrevQuad(){
		if (quads.size() <= 1) {
			return;
		}
		for (int i = 0; i < quads.size(); i++) {
			if (quads.get(i) == selectedQuad) {
				if (i == 0) {
					selectNewQuad(quads.size()-1);
				} else {
					selectNewQuad(i-1);
				}
				return;
			}
		}
	} 

	public void fixQuad(){
		isFixed = !isFixed;
		if (isFixed)
			initializeProps();
	}

	private void initializeProps(){
		float middle = inputMax - ((inputMax - inputMin)/2.0);
		xSkewInput = middle;
		ySkewInput = middle;
		xRotationInput = middle;
		yRotationInput = middle;
		fadeInput = inputMax;
		zoomInput = 60;
		xPrev = 0;
		yPrev = 0;
		handleRotateX();
		handleRotateY();
		handleZoom();
		if (!isFixed){
			handleOpacity();
		}
	}

	/*
	 * Deprecated: Update the properties using the values in a given list of Input objects
	 * @param params Array of input objects to pull update values from.
	 */
	private void updateProps(ArrayList<Float> params){

		fadeInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("Fade")));
		zoomInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("Zoom")));
		xSkewInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("X_Skew")));
		ySkewInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("Y_Skew")));
		xRotationInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("X_Rotation")));
		yRotationInput = params.get(INDEX_MAP.get(SPECIAL_MAP.get("Y_Rotation")));
	}

	/*
	 * Use given params to tell selected quad to draw to a specific buffer
	 * @param params array of doubles containing the paramaters the quad should use to draw.
	 */
	public void drawToScreen(ArrayList<Float> params)
	{
		updateProps(params);
		noStroke();
		handleOpacity();
		translate(width/2, height/2);
		if (!isFixed){
			handleRotateX();
			handleRotateY();
		}
		// //map contents of buffer to screen
		beginShape();
		buffer.beginDraw();
		selectedQuad.drawToBuffer(buffer,params);
		buffer.endDraw();
		texture(buffer);
		//topleft, topright, botright, botleft
		float quadHeight = buffer.height;
		float quadWidth = buffer.width;
		vertex(-quadWidth/2,-quadHeight/2, 0, 0, 0); //params: x, y, z, u, v
		vertex(quadWidth/2, -quadHeight/2, 0, quadWidth, 0);
		vertex(quadWidth/2, quadHeight/2, 0, quadWidth, quadHeight);
		vertex(-quadWidth/2, quadHeight/2, 0, 0, quadHeight);
		endShape();
		handleZoom();
	}

	/*
	 * Helper method to create the quads on startup.
	 	Makes the quads and puts them in the quad array
	 */
	public void createAllQuads(PApplet app)
	{
		//quads.add(new TextQuad(buffer));
		quads.add(new SuperShapeQuad(app,buffer));
		//quads.add(new SketchNameQuad(app,buffer));
		// quads.add(new RealVidQuad(app, buffer));
		// quads.add(new RecordedVideoQuad(app, buffer));
		quads.add(new circleQuad(app,buffer));
		quads.add(new CylinderQuad(app,buffer));
		quads.trimToSize();
	}

	private void handleRotateX() {
		float xSkew = map(xSkewInput,inputMin,inputMax,radians(0),radians(360));
		float xSlope = map(xRotationInput,inputMin,inputMax,-.09,.09);
		xPrev += xSlope;
		rotateX(xSkew+xPrev);
	}

	private void handleRotateY() {
		float ySkew = map(ySkewInput,inputMin,inputMax,radians(0),radians(360));
		float ySlope = map(yRotationInput,inputMin,inputMax,-.09,.09);
		yPrev += ySlope;
		rotateY(ySkew+yPrev);
	}

	public void handleOpacity() {
		
		float fillOpacity = map(fadeInput,inputMin,inputMax,0,255);
		tint(255,fillOpacity);
	}

	public void handleZoom() {
		float zoom = map(zoomInput,inputMin,inputMax,8,4);
		camera(width/2, height/2, (height/2) / tan(PI/zoom), width/2, height/2, 0, 0, 1, 0);
	}
}
