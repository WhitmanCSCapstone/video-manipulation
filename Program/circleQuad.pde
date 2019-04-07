/*
  iteratedMidiLotsOfSpinCycleCircle: Control spinning circle with midi controller.
  VERY COOL. Lots of room for fine tuning. Possible adding of textures/lighting?
  Talk about video crashing.
*/

//import processing.video.*;

//Movie vid;
MidiBus myBus;

public class circleQuad extends QuadObject{
    float ry = 0.0;
    float rx =0.0;

    circleQuad(PApplet app, PGraphics buffer){
        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);
        tempBuffer.fill(0);
    }

    @Override
    protected void runSketch(ArrayList<Float> params){
        tempBuffer.beginDraw();
        tempBuffer.noStroke();
        float bop = map(params.get(0),0,127,255,5);
        tempBuffer.fill(0,bop);
        tempBuffer.rect(0,0,0,width,height);
        tempBuffer.stroke(255);
        float w = map(params.get(1),0,127,10,2);
        tempBuffer.strokeWeight(w);
        tempBuffer.translate(width / 2, height/2);
        float ma = map(params.get(2), 0,127,0,65);
        float mb = map(params.get(3), 0,127,0,65);
        tempBuffer.rotateY (ry);
        ry = ry + ma;
        tempBuffer.rotateX (rx);
        rx = rx + mb;
        tempBuffer.beginShape();
        // tint(255,120);
        //texture(vid);
        float cw = map(params.get(4),0,127,-height/2,height/2);
        float co = map(params.get(5),0,127,255,5);
        float s = map(params.get(6),0,127,.2,2);
        tempBuffer.fill(0,co);
        tempBuffer.ellipse(cw,0,height *s,height *s);
        tempBuffer.vertex(-width/2, - height/2, 0, 0, 0);
        tempBuffer.vertex(width/2, -height/2, 0, width, 0);
        tempBuffer.vertex(width/2, height/2, 0, width, height);
        tempBuffer.vertex(-width/2, height/2, 0, 0, height);
        tempBuffer.endShape();
        tempBuffer.endDraw();
    }

}


