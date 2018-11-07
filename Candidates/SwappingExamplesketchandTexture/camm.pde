/**
 * Texture Quad. 
 * 
 * Load an image and draw it onto a quad. The texture() function sets
 * the texture image. The vertex() function maps the image to the geometry.
 */

void ucam(PGraphics p) {
    
    float vs = map(cc[16], 0,127,.5,2);
    mov.speed(vs);
    if(s2){

      p.image(cam,0,0,p.width,p.height);
    }else{//video

      p.image(mov,0,0);
    } 
}