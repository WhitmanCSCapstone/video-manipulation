import javafx.util.Pair; 
import java.util.Queue;
import java.util.LinkedList;
nanoKontroller b;
int buttonsToDisplay;
int wsplit,hsplit;
void setup() {
    textAlign(CENTER);
    textSize(20);
    
    size(1280,700);
    
    b = new nanoKontroller();
    //b.generateFunction();
    b.fillDefaults();
    //b.generateFunction();
    buttonsToDisplay = b.valToDesc.size();
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
    ArrayList<Button> buttons = new ArrayList<Button>();
    Queue<Pair<Integer,String>> pairs = new LinkedList<Pair<Integer,String>>();
    for (int key : b.valToDesc.keySet()) {
        pairs.add(new Pair<Integer,String>(key,b.valToDesc.get(key)));
    }
    while(locations.size()!=0){
        PVector tempVec = locations.remove();
        if(pairs.size()!=0){
            Pair<Integer,String> tempPair = pairs.remove();
            buttons.add(new Button(tempPair.getValue(),tempPair.getKey(),tempVec,w,h));
        }
        else{
            buttons.add(new Button("No input",-1,tempVec,w,h));
        }
    }
    return buttons;
}
void draw() {
    background(255);
    Queue<PVector> locations = partitionSpace(buttonsToDisplay);
    //populateButtons(locations);
    strokeWeight(40);
    ArrayList<Button> bus = populateButtons(locations);
    for(Button p : bus){
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
