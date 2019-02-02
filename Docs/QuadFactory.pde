/*
 * This interface provides a uniform way to create quad object factories.
 */
public abstract class QuadFactory {

	/*
	 * Variable to hold the quad object as it is being constructed.
	 */
	private QuadObject quadObj;

	/*
	 * Call this method to construct object.
	 * @return the constructed QuadObject.
	 */
	public QuadObject buildQuadObj();


}