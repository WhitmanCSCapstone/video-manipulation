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
	public abstract void drawToBuffer(PGraphics buffer, ArrayList<Float> params);

	/*
	 * Run the PropertyHandler objects to maniuplate this quad sketch.
	 */
	protected abstract void executeHandlers();


}
