/*
 * Future implementation could add another class which holds
 * controllers. Allow for somewhat easier setup of controls
 * without much modifications.
*/
import javafx.util.Pair; 
import java.util.Queue;
import java.util.LinkedList;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import themidibus.*;
import java.nio.file.Path;
import java.nio.file.Paths;

MidiBus myBus;

nanoKontroller b;
int buttonsToDisplay;
int wsplit,hsplit;
ArrayList<Button> buttonList;

String inputController = "nanoKontroller";

Path currentRelativePath = Paths.get("");
String s = currentRelativePath.toAbsolutePath().toString();


void setup() {
    textAlign(CENTER);
    textSize(20);
    size(1280,700);
    println("Current relative path is: " + s);
    if (inputController == "nanoKontroller")
    {
        setupMidi();
        b = new nanoKontroller();
        buttonsToDisplay = b.totalButtons + 1;
    }
    else
        print("Other controllers can be added later");
    b.fillDefaults();
    Queue<PVector> locations = partitionSpace(buttonsToDisplay);
    buttonList = populateButtons(locations);
}

/*
* Calculates a reasonable partition of the screen
* based on the number of segments needed.
* current implementation uses 3 difference as restraint.
*/
Queue<PVector> partitionSpace(int containers){
    ArrayList<Integer> factors = new ArrayList<Integer>();
    Queue<PVector> locations = new LinkedList<PVector>();
    int target = containers;
    int h = 100, w = 0, diff = 3;
    //Slow factoring method is not a bottleneck. 
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
    strokeWeight(40);
    for(Button p : buttonList){
        p.display(true);
    }
}

/*
 * Checks for collision and updates the button under the mouse.
*/
void updateButton(int number){
    for(Button p : buttonList)
        if (p.checkCollision())
            p.updateValue(number);
}

/*
 * Creates file for translator to map buttons from cc array to params.
 * https://bit.ly/2IYHu9l
*/
void writeBufferToFile(ArrayList<String> buffer){
    BufferedWriter bw = null;
    String joined = String.join("", buffer);    
    try {
        //Specify the file name and path here
	    File file = new File("D:\\Programming\\video-manipulation1\\InputConfiguration\\" + "Map.csv");

        /* This logic will make sure that the file 
        * gets created if it is not present at the
        * specified location*/
        if (!file.exists()) {
            file.createNewFile();
        }

        FileWriter fw = new FileWriter(file);
        bw = new BufferedWriter(fw);
        bw.write(joined);
        System.out.println("File written Successfully");

    } catch (IOException ioe) {
	    ioe.printStackTrace();
	}
	finally
	{ 
	    try{
	        if(bw!=null)
		    bw.close();
	    }catch(Exception ex){
	        System.out.println("Error in closing the BufferedWriter"+ex);
	    }
	}
}
/*
 * Produces and prints (So far) the static array to be put into
 * the midiMapper configuration file.
*/
void generateOutput(){
    ArrayList<String> buffer = new ArrayList<String>();
    ArrayList<String> bufferToFile = new ArrayList<String>();
    buffer.add("static{\n" + 
               "\tspecialButtonIDMap = new HashMap<String, Integer>();\n");
    for(Button p : buttonList){
        if(p.bText != "Padding" && p.bText != "Generate"){
            bufferToFile.add(p.bText + "," + p.value + "\n");
            buffer.add("\tspecialButtonIDMap.put(\"" + p.bText + "\", " + p.value + ");\n");
        }
    }
    buffer.add("}\n");
    for(String a : buffer){
        print(a);
    }
    writeBufferToFile(bufferToFile);
}

/*
 * Checks if the mouse is on generate and generates, if so.
*/
void mousePressed() {
    for(Button p : buttonList)
        if (p.bText == "Generate")
            if(p.checkCollision())
                generateOutput();
}

/*
 * Checks if mouse is on top of a button and updates its value.
 * Deprecated in favor of doing the same with the midi.
*/
// void keyPressed() {
//     updateButton(key);
// }

void setupMidi() {
    String osName = System.getProperty("os.name").toLowerCase();
    boolean isMacOs = osName.startsWith("mac");
    if (isMacOs) 
    {
        myBus = new MidiBus(this, "SLIDER/KNOB","CTRL");
    }
    else
    {
        myBus = new MidiBus(this, "nanoKONTROL2","nanoKONTROL2");
    }
}
/*
 * New controller changes update the button the mouse is over.
*/
public void controllerChange(int channel, int number, int value) {
    updateButton(number);
}
