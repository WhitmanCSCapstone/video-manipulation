/**
 * Texture Quad. 
 * 
 * Load an image and draw it onto a quad. The texture() function sets
 * the texture image. The vertex() function maps the image to the geometry.
 */

void ucam(PGraphics p) {
    
    float vs = map(cc[16], 0,127,.5,2);
    mov.speed(vs);
    //float fillOpacity =  map(cc[20], 0, 127,0, 255);
    //p.tint(255,fillOpacity);
    //p.translate(width / 2, height/2);
    ////rotateX(map(amp.analyze(), 0.001, 0.2, -PI/2 +20, PI/2-20));
    ////rotateZ(PI/8);
    
    //ma = map(cc[17], 0,127,-.2,.2);
    //rotateX (rx);
    //rx = rx + ma;
    //float rY = map(cc[18], 0,127,radians(0),radians(360));
    //rotateY(rY);
    //float rZ = map(cc[19], 0,127,radians(0),radians(360));
    //rotateZ(rZ);
    //beginShape();
    if(camTime){
      p.background(0);
      p.image(cam,-500,-500,p.width,p.height);
}else{
      p.background(255);
      p.image(mov,0,0);
    } 
}