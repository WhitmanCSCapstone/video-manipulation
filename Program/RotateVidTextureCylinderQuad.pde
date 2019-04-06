

/*
1. Duplicate this file and rename it.
2. Rename the class declaration from "SketchNameQuad" to your sketch name.
3. Rename the constructor to the class name.
4. Add field variable declarations below the class declaration.
5. Add field variable initializations in the constructor.
6. Implement the sketch in the "runSketch" method between "beginDraw" and "endDraw".
7. Make sure to add your sketch the Quad by going to "QuadContainer.pde" and 
   adding it in the "createAllQuads" method.
*/

//*class declaration*
public class CylinderQuad extends QuadObject{

    //*field variable declarations*
    Movie vid; 
    int tubeRes = 36;
    float[] tubeX = new float[tubeRes];
    float[] tubeY = new float[tubeRes];
    //AudioIn mic;
    //Amplitude amp;
    float ry = 0.0;
    float ma = 0.0;
    float rx = 0.0;
    float mb = 0.0;
    boolean vidSkew = true;

    //*constructor*
    CylinderQuad(PApplet app, PGraphics buffer){
        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);

        vid = new Movie(app, RECORDED_VIDEO);
        vid.loop();
        //mic = new AudioIn(this,0);
        //mic.start();
        //amp = new Amplitude(this);
        //amp.input(mic);
        //img = loadImage("berlin-1.jpg");
        float angle = 372.0 / tubeRes;
        for (int i = 0; i < tubeRes; i++) {
            tubeX[i] = cos(radians(i * angle));
            tubeY[i] = sin(radians(i * angle));
        }
        tempBuffer.noStroke();
    }

    //*updateSketch method runs the sketch*
    @Override
    protected void runSketch(ArrayList<Float> params){

        tempBuffer.beginDraw();

        vid.read();
 
        tempBuffer.background(0);
        //translate(mouseX, mouseY);
        tempBuffer.translate(width/2,height/2);
            ma = map(params.get(4), inputMin,inputMax,0,PI);
            mb = map(params.get(2), 0,127,0,-PI);
            if(vidSkew){
            tempBuffer.rotateY (ma);
        tempBuffer.rotateX (mb);}
        else{
            tempBuffer.rotateY (ry);
        tempBuffer.rotateX (rx);
        ry = ry + ma;
        rx = rx + mb;
        }
        // rotateX(map(mouseY, 0, height, -PI, PI));
        // rotateY(map(mouseX, 0, width, -PI, PI));
        tempBuffer.beginShape(QUAD_STRIP);
        //float sz = map(amp.analyze(), 0.001, 0.2,.1,2.2);
        float sz = params.get(0);
        float a = map(params.get(3),0,127,100,600);
        float b = map(params.get(5),0,127,100,600);
        tempBuffer.texture(vid);
        for (int i = 0; i < tubeRes; i++) {
            float x = tubeX[i] * a;
            float z = tubeY[i] * b;
            float u = vid.width / tubeRes * i;
            tempBuffer.vertex(x *sz, -a*sz, z *sz, u, 0);
            tempBuffer.vertex(x*sz, b*sz, z*sz, u, vid.height);
        }
        tempBuffer.endShape();
        
        tempBuffer.endDraw();
    }
}
