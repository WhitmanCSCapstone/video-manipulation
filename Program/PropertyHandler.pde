/*
 * Quad Objects contain a reference to a Property Handler object that helps them
 * do calculations that are common such as rotateX, rotateY, or zoom.
 * If you find any repeatable behavior, add it into a method in PropertyHandler so
 * that all quad objects have access to it.
 */
public class PropertyHandler {
	/*
	 * PropertyHandler methods will take this form
	 * @param val the input value that will be manipulated
	 */
	public void handleProperty(float val){
		//return some calculation done on val
	}

	public void rotateX(float rawVal, PGraphics buffer) {
		buffer.translate(buffer.width / 2, buffer.height/2);
		float rotation = map(rawVal, INPUT_MIN, INPUT_MAX, radians(0),radians(360));
		buffer.rotateX(rotation);
	}

	public void rotateY(float rawVal, PGraphics buffer) {
		buffer.translate(buffer.width / 2, buffer.height/2);
		float rotation = map(rawVal, INPUT_MIN, INPUT_MAX, radians(0),radians(360));
		buffer.rotateY(rotation);
	}

	public void rotateZ(float rawVal, PGraphics buffer) {
		buffer.translate(buffer.width / 2, buffer.height/2);
		float rotation = map(rawVal, INPUT_MIN, INPUT_MAX, radians(0),radians(360));
		buffer.rotateZ(rotation);
	}

	public void handleOpacity(float rawVal, PGraphics buffer) {
		float fillOpacity =  map(rawVal, INPUT_MIN, INPUT_MAX, 0, 255);
  		buffer.tint(255,fillOpacity);
	}

}
