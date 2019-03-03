

public class TestSketch extends QuadObject{

    //int importantField;

    TestSketch(PGraphics buffer){
        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);
        //importantField = 0;
    }

    @Override
    protected void executeHandlers(ArrayList<Float> params){
        tempBuffer.beginDraw();
        tempBuffer.ellipse(mouseX,mouseY,params.get(21),params.get(26));
        tempBuffer.endDraw();
    }
}