/*
 * Buttons are displayed on the input screen.
 * A user can mouse over them, and by changing input
 * on the controller they are using, update the output value.
 */
public class Button{
    PVector location = new PVector();
    int bwidth,bheight;
    String bText;
    int value;

    Button(String text, int val, PVector loc, int wsplit,int hsplit){
        location = loc;
        bwidth = wsplit;
        bheight = hsplit;
        bText = text;
        value = val;
    }
    
    /*
     * Sets button value if it is not padding or generator.
    */
    public void updateValue(int number){
        if(bText != "Padding" && bText != "Generate"){
            value = number;
        }
    }

    /*
     * Finds mouse location and returns whether it is in the square.
    */
    public Boolean checkCollision(){
        if(mouseX > location.x - bwidth/2 && mouseX < location.x + bwidth/2)
            if(mouseY > location.y - bheight/2 && mouseY < location.y +bheight/2)
                return true;
        return false;
    }

    /*
     * Draws a rectangle and corresponding text of the button.
    */
    public void display(Boolean mouseOn){
        int textSize = 40;
        strokeWeight(2);
        rectMode(CENTER);
        if (checkCollision())
            fill(100,150,200);
        else
            fill(230,230,100);
        rect(location.x,location.y,bwidth,bheight);
        fill(0);
        textSize(textSize);
        float textWidth = textWidth(bText);
        while(textWidth > bwidth -50){
            textSize(--textSize); 
            textWidth = textWidth(bText);
        }
        float textHeight = textDescent() + textAscent();

        if(bText != "Padding")
            text(bText,location.x,location.y);
        if(value != -1)
            text(value,location.x,location.y + textHeight + 5);
    }

    public void printMe(){
        println("Loc",location,"Str",bText,"val",value);
    }
}
