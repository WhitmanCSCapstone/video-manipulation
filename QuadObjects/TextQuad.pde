public class TextQuad extends QuadObject{
    
    //Todo think about fonts 
    TextQuad(){}
    //Final draw to real buffer - currently not using params
    //Params will be important here I think
    void drawToBuffer(PGraphics buffer, double[] params){
        buffer.image(tempBuffer,0,0,buffer.width,buffer.height);
    }
}
