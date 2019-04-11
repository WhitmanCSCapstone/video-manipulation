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
        return true;
    }
    public void display(Boolean mouseOn){
        //point(location.x,location.y);
        fill(0);
        text(bText,location.x,location.y);
    }
    public void printMe(){
        println("Loc",location,"Str",bText,"val",value);
    }
}