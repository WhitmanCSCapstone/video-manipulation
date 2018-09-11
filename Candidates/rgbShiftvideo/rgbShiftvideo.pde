PShader shader;
PImage img;
boolean enabled = true;
import processing.video.*;
Movie movie;

void setup(){
  size(1280,800, P2D);
  shader = loadShader("rgbShift.glsl");
  movie = new Movie(this, "84.mov");
  //img = loadImage("img.jpg");
  shader.set("srcTex", movie);
movie.loop();
  noStroke();
}

void draw(){  

    movie.read();
  
  image(movie, 0, 0, width, height);
  shader.set("shift", map(mouseX, 0, width, -0.2,0.2));
  shader(shader);
  //rect(0,0,width, height);
  //saveFrame("blogmix" + "######" + ".tiff");

}
