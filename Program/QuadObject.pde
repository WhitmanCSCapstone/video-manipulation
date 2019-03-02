/*
 * This is an interface for all quad objects. It ensures that 
 * all quads can draw to a quad and utilize PropertyHandlers.
 */
public abstract class QuadObject {

	/* NOT THIS ANYMORE ----->>> SEE NEW DESIGN
	 * An array of objects which are used to manipulate how this quad gets drawn to the screen.
	 * Allows for quick swapping behavior of sketches.
	 */
	//private PropertyHandler handlers[];

	/*
	*  Temporary buffer for intermediate filters.
	*/
	protected PGraphics tempBuffer;

	//NEW DESIGN
	/*
	 * Every QuadObject has an object that it can use to do basic universal calculations
	 * involved in the handling of certin universal properties such as rotateX, zoom, rotateY.
	 */
	protected PropertyHandler propHandler;

	/*
	 *Use given params to draw this object to the given buffer.
	 * @param buffer Buffer to draw the quad contents too.
	 * @param params array of values that should be used to manipulate quad content parameters
	 */
	public void drawToBuffer(PGraphics buffer, ArrayList<Float> params) {
		buffer.beginShape();

		executeHandlers(params);

		buffer.texture(tempBuffer);
		//topleft, topright, botright, botleft
		float quadHeight = buffer.height;
		float quadWidth = buffer.width;
		buffer.vertex(0,0, 0, 0, 0); //params: x, y, z, u, v
		buffer.vertex(quadWidth, 0, 0, quadWidth, 0);
		buffer.vertex(quadWidth, quadHeight, 0, quadWidth, quadHeight);
		buffer.vertex(0, quadHeight, 0, 0, quadHeight);

		buffer.endShape();

        // buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
	}

	/*
	 * Run the PropertyHandler methods to manipulate this quad sketch.
	 */
	protected void executeHandlers() {
		//pass an empty ArrayList
		executeHandlers(new ArrayList<Float>());
	}

	/*
	 * Run the PropertyHandler methods to manipulate the quad.
	 * @param params - array of values to use when manipulating sketch
	 */
	 protected abstract void executeHandlers(ArrayList<Float> params);


}
