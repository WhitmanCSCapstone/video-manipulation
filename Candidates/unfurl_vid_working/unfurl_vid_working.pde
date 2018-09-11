final int nbW = 40;
int imageW, imageH, mode = 0;
float l, theta, i;
import processing.video.*;
Movie vid;
import processing.sound.*;
AudioIn mic;
Amplitude amp;

void setup()
{
  size(1280, 800, OPENGL);
  noStroke();
  //pi = loadImage("D1.png");
  vid = new Movie(this, "jjj.mov");
vid.loop();
 mic = new AudioIn(this,0);
mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
  imageW = width;
  imageH = height;
  l = width/nbW;
background(30);
}
void movieEvent(Movie vid) {
  vid.read();
}

void draw()
{ 
  //background(30);

  translate(0, 0, -10);
  PVector prev, curr;
  beginShape(QUAD);
  
  texture(vid);
  float u = map(amp.analyze(), 0.001, 0.2, 0,width);
 // tint(255, map(amp.analyze(), 0.001, 0.2, 120, 255));
  theta = 0;
  prev = new PVector(0, 0, 0);
  curr = prev.get();
  for (i = 0; i < nbW; i ++)
  {
    if (mode == 1 && i>u*nbW/width)
      theta += map(i, 0, nbW-1, PI/15, PI/6);
    else if (mode == 0)
      theta += i*map(amp.analyze(), 0.001, 0.1, HALF_PI*.6, 0)/nbW;

    curr.x = prev.x + l * cos(theta);
    curr.z = prev.z + l * sin(theta);

    vertex(prev.x, 0, prev.z, i*width/nbW, 0);
    vertex(curr.x, 0, curr.z, (i+1)*width/nbW, 0);
    vertex(curr.x, height, curr.z, (i+1)*width/nbW, height);
    vertex(prev.x, height, prev.z, i*width/nbW, height);

    prev = curr.get();
  }
  endShape();
}

void mousePressed()
{
  mode = (mode+1)%2; 
}
