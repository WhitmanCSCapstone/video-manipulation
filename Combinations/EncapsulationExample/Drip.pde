class Drip {  // Make same name as the file
  PVector loc;
  int r;
  int g;
  int b;

  float l;
  float h;
  Supershape s;
  Drip(float dripX, float dripY, Supershape z) {  // Receives variables, stores them in these properties
    s = z;
    loc = new PVector(dripX,dripY);
  }
  void updateArray(){
    s.polycount = dd[16];
    s.vibrations =dd[17];
    s.period = dd[18];
    s.timestep = dd[19];
  }
  // Like draw
  void fall(int speed, PVector direction) {
    direction.mult(speed);
    loc.add(direction);  // how fast up or down
    
    if (loc.y > height)  // Flow back to top
      loc.y = 0;
    if (loc.y < 0)
      loc.y = height;
    if (loc.x > width)
      loc.x = 0;
    if (loc.x < 0)
      loc.x = width;
      
    s.update(loc.x,loc.y);
  }
}
