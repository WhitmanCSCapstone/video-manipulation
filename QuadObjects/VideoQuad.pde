//I removed abstract here because our quad array needs quadobjects
public class VideoQuad extends QuadObject{
    void readData(){}
    //Also draw to tempbuffer
    void applyFilters(){}
    //Final draw to real buffer
    void drawToBuffer(PGraphics buffer, double[] params){}
}
