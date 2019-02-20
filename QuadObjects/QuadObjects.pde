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

QuadContainer quadCont;
void setup() {
  size(1280,720,P3D);
  quadCont = new QuadContainer(this);
  quadCont.selectNewQuad(0);
}

void draw() {
  quadCont.drawToBuffer(new ArrayList<Float>());
  System.out.println("update");
}
