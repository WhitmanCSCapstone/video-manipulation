/*
 * This interface provides a uniform way to create quad object factories.
 */
public interface QuadFactory {

	/*
	 * Call this method to construct object.
	 * @return the constructed QuadObject.
	 */
	public QuadObject buildQuadObj();

}