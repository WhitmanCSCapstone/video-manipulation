/*
 * Testing file for the QuadObjects folder
 * Not to be confused with the QuadObject class.
 */
import java.util.Arrays;
import java.util.ArrayList;
import java.io.FileNotFoundException;
import processing.video.*;

String RECORDED_VIDEO = "less.mp4";
int BUFFERHEIGHT = 720;
int BUFFERWIDTH = 1280;

QuadContainer quadcontainer;
void setup() {
  size(1280,720,P3D);
  quadcontainer = new QuadContainer(this);
  
  //TextQuad q = new TextQuad();
  System.out.println("good");

}

void draw() {
  
}
