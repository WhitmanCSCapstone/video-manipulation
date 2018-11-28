/*
 * This is an interface for all quad objects. It ensures that 
 * all quads can draw to a quad and utilize PropertyHandlers.
 */


/*
 * An array of objects which are used to manipulate how this quad gets drawn to the screen.
 * Allows for quick swapping behavior of sketches.
 */
private PropertyHandler handlers[];

/*
 *Use given params to draw this object to the given buffer.
 * @arg buffer Buffer to draw the quad contents too.
 * @arg params array of values that should be used to manipulate quad content parameters
 */
public void drawToBuffer(PGraphics buffer, double[] params);

/*
 * Run the PropertyHandler objects to maniuplate this quad sketch.
 */
private void executeHandlers();