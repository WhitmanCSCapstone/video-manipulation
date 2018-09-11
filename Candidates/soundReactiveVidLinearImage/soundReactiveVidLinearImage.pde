import processing.video.*;
Movie video;

import processing.sound.*;
float inc = 0;
float amplitude = 0.0001;
float frequency = 20.0;
AudioIn mic;
Amplitude amp;
int direction = 1;
float signal;

void setup() {
fullScreen(P2D);
    video = new Movie (this, "Makemespellitout4u.mov");
  video.loop();

  video.loadPixels();
  loadPixels();
  //stroke(255);
    mic = new AudioIn(this,0);
  mic.start();
amp = new Amplitude(this);
amp.input(mic);


  frameRate(10);
}

void videoEvent(Movie video) {

  video.read();


  // return video;
}

void draw() {
  video.read();
  //video.loop();
  video.speed(.9);

  if (signal > video.height-1 || signal < 0) { 
    direction = direction * -1;
  }
  if (mousePressed == true) {
    signal = abs(mouseY % video.height);
  } else {
    signal += (0.3*direction);
  }

  if ((amp.analyze() >= 0.009) == true) {
    set(0, 0, video);
    //line(0, signal, video.width, signal);
  } else {
    int signalOffset = int(signal)*video.width;
    for (int y = 0; y < video.height; y++) {
      arrayCopy(video.pixels, signalOffset, pixels, y*width, video.width);
    }

    updatePixels();
  }
}
