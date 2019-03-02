/*
 * This object controls the different possible quads of the program.
 * It does things like pass values, tell to draw, construc them, decide which 
 * quad should be drawn.
 */
public class QuadContainer {

	/*
	 * Buffer that quads shoudld be drawn to. What eventually gets drawn to screen.
	 */
	private PGraphics buffer;

	/*
	 * The quad that is currently selected to draw to the screen.
	 */
	public QuadObject selectedQuad;

	/*
	 * Array of Quad objects that can be selected and drawn to to screen independently of each other.
	 */
	public QuadObject quads[];

	/*
	 * The ID of the quad that shoudl be selected and drawn from now on.
	 * @param selectID the id of the quad that should now be drawn on the screen
	 */
	public void selectNewQuad(int selectID);

	/*
	 * Deprecated: Update the properties using the values in a given list of Input objects
	 * @param params Array of input objects to pull update values from.
	 */
	public void updateProps(input[] params);

	/*
	 * Use given params to tell selected quad to draw to a specific buffer
	 * @param params array of doubles containing the paramaters the quad should use to draw.
	 */
	public void drawToBuffer(ArrayList<Float> params);

	/*
	 * Helper method to create the quads on startup.
	 */
	public void createAllQuads()

}