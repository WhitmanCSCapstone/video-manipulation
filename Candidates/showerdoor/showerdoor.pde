
drop[] drops = new drop[400];
import processing.video.*;

Capture cam;

int vidScale = 4;

void setup() {  // The "factory"
//fullScreen();
//size(displayWidth, displayHeight);
size(1280,720);

String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, width/vidScale, height/vidScale);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, Capture.list()[6]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
    
    // Start capturing the images from the camera
    cam.start();
  }
 for(int i=0; i<drops.length; i++) {
   int h = round(map(mouseX,0,width,30,2));
   int w = round(map(mouseY,0,height,30,2));
   drops[i] = new drop(random(width),0, w, h);
 }
background(0);
noStroke();
}

void captureEvent(Capture video) {
  video.read();
}


void draw() {
  float alpha = map(mouseX, 0, width, 0, 8);
  fill(255, alpha);
  rect(0, 0, width, height);
  int divisor = int(map(mouseY, 0, height, 1, 80));
  
  for(int i=0; i<drops.length; i++) {
   drops[i].drive(i/divisor); 
   drops[i].display();
  }
}

  void mousePressed() {
    if (mousePressed) { 
      saveFrame("#####.png"); }
  }
