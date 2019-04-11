/*
 * Future implementation could add another class which holds
 * controllers. Allow for somewhat easier setup of controls
 * without much modifications.
*/

import javafx.util.Pair; 
import java.util.Queue;
import java.util.LinkedList;
nanoKontroller b;
int buttonsToDisplay;
int wsplit,hsplit;
ArrayList<Button> buttonList;

String inputController = "nanoKontroller";

void setup() {
    textAlign(CENTER);
    textSize(20);
    
    size(1280,700);
    if (inputController == "nanoKontroller")
    {
        b = new nanoKontroller();
        buttonsToDisplay = b.totalButtons + 1;
    }
    else
        print("Other controllers can be added later");
    b.fillDefaults();
    Queue<PVector> locations = partitionSpace(buttonsToDisplay);
    buttonList = populateButtons(locations);
}

Queue<PVector> partitionSpace(int containers){
    /*
     * Calculates a reasonable partition of the screen
     * based on the number of segments needed.
     * current implementation uses 3 difference as restraint.
     */
    ArrayList<Integer> factors = new ArrayList<Integer>();
    Queue<PVector> locations = new LinkedList<PVector>();
    int target = containers;
    int h = 100, w = 0, diff = 3;
    while(abs(h-w) >= diff){
        factors.clear();
        target++;
        for(int i = 1; i <= target;i++){
            if (target% i == 0){
                factors.add(i);
            }
        }
        if(factors.size() < 2)
            continue;
        h = factors.get((factors.size()-1)/2);
        w = factors.get((factors.size()-1)/2 + 1);
    }
    wsplit = width/w;
    hsplit = height/h;
    for(int i = 0;i < h;i++){
        for(int j = 0;j < w;j++){
            PVector temp = new PVector(j * wsplit + wsplit/2,
                                       i * hsplit + hsplit/2);
            locations.add(temp);
        }
    }
    return locations;
}
/*
 * Fills array of buttons with their locations and the strings
 * that they display.
 * we will always have more locations than pairs.
 */
ArrayList<Button> populateButtons(Queue<PVector> locations){
    int w = int(locations.peek().x*2);
    int h = int(locations.peek().y*2);
    PVector tempVec;
    ArrayList<Button> buttons = new ArrayList<Button>();
    Queue<Pair<Integer,String>> pairs = new LinkedList<Pair<Integer,String>>();
    for (int key : b.valToDesc.keySet()) {
        pairs.add(new Pair<Integer,String>(key,b.valToDesc.get(key)));
    }
    while(locations.size()!=1){
        tempVec = locations.remove();
        if(pairs.size()!=0){
            Pair<Integer,String> tempPair = pairs.remove();
            buttons.add(new Button(tempPair.getValue(),tempPair.getKey(),tempVec,w,h));
        }
        else{
            buttons.add(new Button("Padding",-1,tempVec,w,h));
        }
    }
    tempVec = locations.remove();
    buttons.add(new Button("Generate",-1,tempVec,w,h));            
    return buttons;
}
void draw() {
    background(255);
    
    //populateButtons(locations);
    strokeWeight(40);
    
    for(Button p : buttonList){
        p.display(true);
        //p.printMe();
    }

}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      buttonsToDisplay++;
    } else if (keyCode == DOWN) {
      buttonsToDisplay--;
    } 
  }
}
