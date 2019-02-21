/*
 * These objects are for containing the behavior of manipulating a quad.
 * They should be able to conenct to some quads and modify the way they are drawn to the screen.
 */
public interface PropertyHandler {
	/*
	 * The value of the slot that this parameter object is fit into.
	 * Useful for checking which parameter value should be sent to this object.
	 */
	//public int paramSlot;

	/*
	 * Call this function to tell this object to modify the behavior of the QuadObject its connected to.
	 * @param val the input value that this object will use to maniuplate the QuadObject from its current state.
	 */
	public void handleInput(double val);

}
