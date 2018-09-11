class Drip {  // Make same name as the file
  float x;
  float y;
  
  int r;
  int g;
  int b;
  
  float l;
  float h;
  
  // function with same name as class: constructor. Function is called when "new car" calls function
  // Similar to setup: only called once
  Drip(float dripX, float dripY, int red, int green, int blue, float dripWidth, float dripHeight) {  // Receives variables, stores them in these properties
    x = dripX;
    y = dripY;
    r = red;
    g = green;
    b = blue;
    l = dripWidth;
    h = dripHeight;
  }
  
 // Like draw
 void fall(int speed, float direction) {
   y = y + speed*direction;  // how fast up or down
   
   if (y >= height+h)  // Flow back to top
     y = -h;
     
// MAKE ONE TO FLOW OVER TO BOTTOM
   //if (y < 0);
     //y = height;

   fill(r,g,b);
   ellipse(x, y, l, h);
 }
}