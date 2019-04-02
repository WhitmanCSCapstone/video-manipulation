/*
 * Quad Objects contain a reference to a Property Handler object that helps them
 * do calculations that are common such as rotateX, rotateY, or zoom.
 * If you find any repeatable behavior, add it into a method in PropertyHandler so
 * that all quad objects have access to it.
 */
public class PropertyHandler {

	float inputMin = inputMap.INPUT_MIN;
	float inputMax = inputMap.INPUT_MAX;

	/*
	 * PropertyHandler methods will take this form
	 * @param val the input value that will be manipulated
	 */

	 /*
	public void handleProperty(float val){
		//return some calculation done on val
	}

	public void rotateX(float xSkewInput, float xRotationInput) {
		float xSkew = map(xSkewInput,inputMin,inputMax,radians(0),radians(360));
		float xSlope = map(xRotationInput,inputMin,inputMax,-.09,.09);
		xPrev += xSlope;
		rotateX(xSkew+xPrev);
	}

	public void rotateY(float ySkewInput, float yRotationInput) {
		float ySkew = map(ySkewInput,inputMin,inputMax,radians(0),radians(360));
		float ySlope = map(yRotationInput,inputMin,inputMax,-.09,.09);
		yPrev += ySlope;
		rotateY(ySkew+yPrev);
	}

	public void handleOpacity(float fadeInput) {
		float fillOpacity = map(fadeInput,inputMin,inputMax,0,255);
		tint(255,fillOpacity);
	}

	public void handleZoom(float zoomVal) {
		float zoom = map(zoomInput,inputMin,inputMax,8,4);
		camera(width/2, height/2, (height/2) / tan(PI/zoom), width/2, height/2, 0, 0, 1, 0);
	}
*/


}
