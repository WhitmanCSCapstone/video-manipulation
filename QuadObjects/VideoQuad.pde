//I removed abstract here because our quad array needs quadobjects
public abstract class VideoQuad extends QuadObject{
    public abstract void readData();
    //Also draw to tempbuffer
    public abstract void applyFilters();
    //Final draw to real buffer
    // abstract void drawToBuffer(PGraphics buffer, ArrayList<Float> params);

    // public abstract void executeHandlers(){}

}
