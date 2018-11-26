/*
 * This centralizes and begins all the controller behavior that happens in the program.
 * When procesing calls setup(), draw(), and controllerChange(), MasterController delegates responsibiliteis
 */



/* 
 * Request the input state as an array of values.
 * @return array of doubles containing all the input state values
 */
double[] fetchParams();

/* 
 * Tell the input object to update all its inputs. Some input types are not automatically
 * updated and must be provoked to do so.
 */
void updateInputs();

/* 
 * ?
 */
void notifyInputController(Input []);

/* 
 * Used to create an FFT object. 
 * @input AudioDevice an object that contains the audio source to FFT
 * @return FFT object created from the AudioDevice input
 */
FFT setupFFT(AudioDevice);

/*
 * Tell QuadContainer to switch the currently selected quad
 * @input quadIndex the number of the quad to switch to
 */
void switchQuad(int quadIndex);

/* 
 * Setup the Input object to hold input states
 * @return input object (shouldn't be a list. That was abstracted away)
 */
Input[] createInputs();

/* 
 * When processing recieves a controller change, it gets passed here which delegates 
 * responsibilities depending on the input sources.
 */
void handleControllerChange(int, int, int);

/* 
 * Handle everything neccesarry to draw the quad. Make inputs update, fetch inputs, pass to 
 * QuadContainer and have it draw with them.
 */
void drawQuad();