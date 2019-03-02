/*
  ColorMidi3DSupershapeTempStop: Generates a 3D image using midi controller. 
  This is accomplished by mapping a whole bunch of values to the arrays. 
  Visualization is done with peasycam. 
  There is a lot of room for optimizing and fine tuning.
  Ask Justin where he got this code. It would be cool for sliders to control camera.
  https://www.youtube.com/watch?v=akM4wMZIBWg
*/
// import peasy.*;
// PeasyCam cam;
class Supershape extends QUAD{
PVector [][] globe;
  int total;
  float m;
  float mchange;
  float sm;
  float l;
  float offset;
  float xoffset;
  float yoffset;
  float polycount;
  float vibrations;
  float period;
  float timestep;
  float a = 1;
  float b = 1;

void setup(PApplet app, PGraphics p){
  int total = 200;
    float m = 0.0;
    mchange = 0.0;
    sm = 0.0;
    l = 0.0;
    offset = 0;
    xoffset = p.width/3;
    yoffset = p.height/2;
    
    polycount = 20;
    vibrations = 20;
    period = 20;
    timestep = 20;

    a = 1;
    b = 1;
    
    p.colorMode(HSB);
    globe = new PVector[total+ 1][total+ 1];
    noStroke();
  print("Setting supershape\n\n\n");
}


private float supershape(float theta, float m, float n1, float n2, float n3){
  float t1 = abs((1/a) * cos( m * theta /4));
  t1 = pow(t1,n2);
  float t2 = abs((1/b)*sin(m * theta/4));
  t2 = pow(t2,n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1/ n1);
  return r;
}

void update( PGraphics p, float fft){
  //g: for all sketches, save cc to variables for clarity before doing stuff on them
  
  //Identify variables:
  float polycount = cc[21];
  float vibrations = cc[23];
  float period = cc[22];
  float timestep = cc[23]; //hmm
  //println(fft);
  l = map(timestep,0,127,1,127);
    m = map(sin(mchange),-1,1,0,l);
    sm = map(period,0,127,0.0, 0.2);
    if(bb[54]){
      float periodScaled = map(fft,0,60,0.0,0.4) + sm;
      sm = min(periodScaled,0.5);
    }
    //timestep
    mchange += sm;
    p.background(0);
    p.noStroke();
    //Generates shadows underfolds of polygons
    p.lights();
    
    float r = 200;
    
    total = round(map(polycount,0,127,2,60));
    if(bb[53])//poly sound
      total = min(int(fft) + total,60);
    
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
          int u = round(map(vibrations,0,127,0,2));
          if(bb[55])
          {
            v.mult(min(fft/8+u,2));
          }
          else
          v.mult(u);
          globe[i][j].add(v);
        }
      }
      offset+=5;
      //Swapping where i and j are used to calculate hu switches stripes
      //adding offset makes them flow in a cool way
    for(int i = 0; i< total; i++){
      p.beginShape(TRIANGLE_STRIP);
      float hu = map(i,0,total,0,255* 6);
      //print(hu);
      p.colorMode(HSB);
      p.fill((hu+offset) % 255,255,255);
      for(int j = 0; j < total+ 1; j++){
        PVector v1 = globe[i][j];
        p.vertex(v1.x+xoffset,v1.y+yoffset,v1.z);
        PVector v2 = globe[i+1][j];
        p.vertex(v2.x+xoffset,v2.y+yoffset,v2.z);
      }
      p.endShape();
    }
  }

}
