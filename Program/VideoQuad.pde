//I removed abstract here because our quad array needs quadobjects
public abstract class VideoQuad extends QuadObject{
    public abstract void readData();
    //Also draw to tempbuffer
    public abstract void applyFilters();

}
