

/*
1. Duplicate this file and rename it.
2. Rename the class declaration from "SketchNameQuad" to your sketch name.
3. Rename the constructor to the class name.
4. Add field variable declarations below the class declaration.
5. Add field variable initializations in the constructor.
6. Implement the sketch in the "updateSketch" method between "beginDraw" and "endDraw".
7. Make sure to add your sketch the Quad by going to "QuadContainer.pde" and 
   adding it in the "createAllQuads" method.
*/

//*class declaration*
public class SketchNameQuad extends QuadObject{

    //*field variable declarations*
    //int importantField1;
    //float importantField2

    //*constructor*
    SketchNameQuad(PGraphics buffer){
        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);

        //*field variable initializations*
        //importantField1 = 0;
        //importantField2 = 0.0;
    }

    //*updateSketch method runs the sketch*
    @Override
    protected void runSketch(ArrayList<Float> params){
        tempBuffer.beginDraw();
        tempBuffer.ellipse(mouseX,mouseY,params.get(21),params.get(26));
        tempBuffer.endDraw();
    }
}
