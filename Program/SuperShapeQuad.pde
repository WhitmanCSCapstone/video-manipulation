
public class SuperShapeQuad extends QuadObject {

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
    float a;
    float b;

    SuperShapeQuad(PGraphics buffer){

        tempBuffer = createGraphics(buffer.width, buffer.height, P3D);
        
        total = 200;
        m = 0.0;
        mchange = 0.0;
        sm = 0.0;
        l = 0.0;
        offset = 0;
        xoffset = 400;
        yoffset = 400;
    
        polycount = 20;
        vibrations = 20;
        period = 20;
        timestep = 20;

        a = 1;
        b = 1;
    
        tempBuffer.colorMode(HSB);
        globe = new PVector[total+ 1][total+ 1];
        tempBuffer.noStroke();

    }

    private float supershape(float theta, float m, float n1, float n2, float n3){
        float t1 = abs((1/a) * cos( (m * theta /4)));
        t1 = pow(t1,n2);
        float t2 = abs((1/b)*sin(m * theta/4));
        t2 = pow(t2,n3);
        float t3 = t1 + t2;
        float r = pow(t3, -1/ n1);
        return r;
    }

    /*
     * Handle all behavior to get the sketch drawn to tempBuffer.
     */
     @Override
     protected void executeHandlers(ArrayList<Float> params){   
        //g: for all sketches, save cc to variables for clarity before doing stuff on them
    
        //Identify variables:

        tempBuffer.beginDraw();

        polycount = params.get(21);
        vibrations = params.get(26);
        period = params.get(31);
        timestep = params.get(36);
        
        l = map(timestep,0,127,1,127);
        m = map(sin(mchange),-1,1,0,l);
        sm = map(period,0,127,0.0, 0.009);
        
        //timestep
        mchange += sm;
        tempBuffer.background(0);
        tempBuffer.noStroke();
        //Generates shadows underfolds of polygons
        tempBuffer.lights();
        
        float r = 200;
        total = round(map(polycount,0,127,2,128));

        for(int i = 0; i< total+1; i++){
            float lat = map( i,0, total,- HALF_PI,HALF_PI);
            float r2 = supershape(lat, m,10.0,10.0,10.0);
            for(int j = 0; j< total + 1; j++) {
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
            tempBuffer.beginShape(TRIANGLE_STRIP);
            float hu = map(i,0,total,0,255* 6);
            tempBuffer.fill((hu+offset) % 255,255,255);
            for(int j = 0; j < total+ 1; j++){
                PVector v1 = globe[i][j];
                tempBuffer.vertex(v1.x+xoffset,v1.y+yoffset,v1.z);
                PVector v2 = globe[i+1][j];
                tempBuffer.vertex(v2.x+xoffset,v2.y+yoffset,v2.z);
            }
            tempBuffer.endShape();
        }
        tempBuffer.endDraw();
     }

}
