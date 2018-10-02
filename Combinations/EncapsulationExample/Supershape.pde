class Supershape{
  PVector [][] globe;
  int total = 200;
  float m = 0.0;
  float mchange = 0.0;
  float sm = 0.0;
  float l = 0.0;
  float offset = 0;
  float xoffset = 400;
  float yoffset = 400;
  float a = 1;
  float b = 1;
  float id = random(0, 100);
  float polycount = random(0,60);
  float vibrations = random(0,60);
  float period = random(0,60);
  float timestep = random(0,60);
  float xvel = random(-5,5);
  float yvel = random(-5,5);

  Supershape(float xpos, float ypos){
    xoffset =xpos;
    yoffset = ypos;

    globe = new PVector[total+ 1][total+ 1];
  }
  float supershape(float theta, float m, float n1, float n2, float n3){
    float t1 = abs((1/a) * cos( m * theta /4));
    t1 = pow(t1,n2);
    float t2 = abs((1/b)*sin(m * theta/4));
    t2 = pow(t2,n3);
    float t3 = t1 + t2;
    float r = pow(t3, -1/ n1);
    return r;
  }

void update(){
  //g: for all sketches, save cc to variables for clarity before doing stuff on them
  
  //Identify variables:
  // float polycount = cc[16];
  // float vibrations = cc[17];
  // float period = cc[18];
  // float timestep = cc[19];
  xoffset += xvel;
  yoffset+= yvel;

  l = map(timestep,0,127,1,127);
  m = map(sin(mchange),-1,1,0,l);
  sm = map(period,0,127,0.0, 0.009);
  
  //timestep
  mchange += sm;
  // background(0);
  noStroke();
  //Generates shadows underfolds of polygons
  lights();
  
  float r = 200;
  total = round(map(polycount,0,127,2,128));

  for(int i = 0; i< total+1; i++){
      float lat = map( i,0, total,- HALF_PI,HALF_PI);
      float r2 = supershape(lat, m,10.0,10.0,10.0);
      for(int j = 0; j< total + 1; j++){
        float lon = map( j,0, total, - PI, PI);
        float r1 = supershape(lon,m,60.0,100.0,30.0);
        float x = r * r1 * cos(lon) * r2 * cos(lat);
        float y = r * r1 *sin(lon) * r1 * r2 * cos(lat);
        float z = r * r2 * sin(lat);
        globe[i][j] = new PVector(x,y,z);

        PVector v = PVector.random3D();
        int u = round(map(vibrations,0,127,0,127));
        v.mult(u);
        globe[i][j].add(v);
       }
    }
    offset+=5;
    //Swapping where i and j are used to calculate hu switches stripes
    //adding offset makes them flow in a cool way
  for(int i = 0; i< total; i++){
    beginShape(TRIANGLE_STRIP);
    float hu = map(i,0,total,0,255* 6);
    fill((hu+offset) % 255,255,255);
    for(int j = 0; j < total+ 1; j++){
      PVector v1 = globe[i][j];
      vertex(v1.x+xoffset,v1.y+yoffset,v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x+xoffset,v2.y+yoffset,v2.z);
    }
    endShape();
  }
}
}
