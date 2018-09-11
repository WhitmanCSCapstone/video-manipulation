
class drop {  // Make same name as the file
  float x;  // x pos, y pos, color
  float y;
  float l;
  float h;
 
  // function with same name as class: constructor. Function is called when "new drop" calls function
  // Similar to setup: only called once
  drop(float dropx, float dropy, float dropLength, float dropHeight) {  // Receives variables, stores them in these properties
    x = dropx;
    y = dropy;
    l = dropLength;
    h = dropHeight;
  }
  
 // Like draw
 void drive(int speed) {
   y = y + speed;
   if (y >= height+h)
   {
     y = -h;
   }
 }
 
 void display() {
   //color c = cam.get(int(x/2),int(y/2));
   color c = cam.get(int((width-x)/vidScale), int(y/vidScale));   // don't leave this hard-coded. Should depend on vidScale?
   fill(c);
   ellipse(x, y, l, h);
   
   float alpha = map(mouseX, 0, width, 0, 2);
   fill(0,alpha);
   rect(0,0,width,height);
 }
}