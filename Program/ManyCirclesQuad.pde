public class ManyCirclesQuad extends QuadObject {
    float angle = 0.0;
  float offset = 0.0;
float w = 24;
ManyCirclesQuad (PGraphics buffer){

        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);
    // tempBuffer.background(255);
}
@Override
     protected void executeHandlers(ArrayList<Float> params){
         tempBuffer.beginDraw();
        float op = map(params.get(19),0,127,20,255);
         tempBuffer.translate(width/2,height/2);
         tempBuffer.rectMode(CENTER);
         tempBuffer.fill(255,op);
         tempBuffer.rect(0,0,width,height);
        
        w = map(params.get(19),0,127,.1, 800);
        for(float x = 0; x < width; x +=w){
            float a = angle + offset;
        float h = map(sin(a),-1,1,0,700);
         tempBuffer.fill(255);
        float sW = map(params.get(20),0,127,.2,1.2);
         tempBuffer.strokeWeight(sW);
         tempBuffer.ellipse(x- width/2 + w/2,0,w, h);
        offset += map(params.get(17),0,127,.009,9);
        }
        angle += map(params.get(16),0,127,.009,9);
 





         tempBuffer.endDraw();
     }
}
