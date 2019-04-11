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

    public void updateController(String controller){
        if(controller == "nanoKontroller"){

        }
        else
            println("Controller not supported");
    }
    public Boolean checkCollision(){
        if(mouseX > location.x - bwidth/2 && mouseX < location.x + bwidth/2)
            if(mouseY > location.y - bheight/2 && mouseY < location.y +bheight/2)
                return true;
        return false;
    }
    public void display(Boolean mouseOn){
        //point(location.x,location.y);
        strokeWeight(2);
        rectMode(CENTER);
        if (checkCollision())
            fill(100,150,200);
        else
            fill(230,230,100);
        rect(location.x,location.y,bwidth,bheight);
        fill(0);
        if(bText != "Padding")
            text(bText,location.x,location.y);
        if(value != -1)
            text(value,location.x,location.y + 30);
    }
    public void printMe(){
        println("Loc",location,"Str",bText,"val",value);
    }
}