import processing.video.*;
Movie mov;
float looplength;
float t;
void setup() {
  //size(700,700);
  fullScreen();
  mov = new Movie(this, "MW45.mov");
  mov.loop();
}

void draw() {
imageMode(CENTER);
  if (mov.available()) {
    mov.read();
  } 
background(0);
  image(mov, width/2, height/2, width, height);
  
  if (mov.time() > t + looplength){
    mov.jump(t);
    mov.play();
  }
  textSize(30);
  fill(255);
// text("position in clip:  " + mov.time() + "  milliseconds" ,110,60);
  //text("loop length:  " + looplength + "  milliseconds" ,110,110);
   //text("adjusts with mouseClick on mouseX and mouseY. ", 110,750);
 
}


void mousePressed() {
  // A new time position is calculated using the current mouse location:
  float f = map(mouseX, 0, width, 0, 1);
  t = mov.duration() * f;
  looplength = map(mouseY, 0, height, 0, mov.duration()/10);
  mov.jump(t);
  mov.play();
  println(mov.duration(), t, looplength);
}
