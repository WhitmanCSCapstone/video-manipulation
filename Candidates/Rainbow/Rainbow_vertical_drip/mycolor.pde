class randomcolor {  // Make same name as the file
  float x;  // x pos, y pos, color
  float y;
  
  int r;
  int g;
  int b;
  
  float l;
  float h;
  
  // function with same name as class: constructor. Function is called when "new randomcolor" calls function
  // Similar to setup: only called once
  randomcolor(float randomcolorx, float randomcolory, int red, int green, int blue, float randomcolorLength, float randomcolorHeight) {  // Receives variables, stores them in these properties
    x = randomcolorx;
    y = randomcolory;
    r = red;
    g = green;
    b = blue;
    l = randomcolorLength;
    h = randomcolorHeight;
  }
  
 // Like draw
 void drive(int speed) {
   y = y + speed;
   if (y >= height+h)
   {
     y = -h;
   }
   fill(r,g,b);
   ellipse(x, y, l, h);
 }
}