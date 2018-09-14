// Edited by george - Not finished
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * Generates an image based on combined screenshots of a movie file. 
 * Time steps in the move file are based on the X and Y resolution, with smaller
 * resolution resulting in more pictures.
 *
 * KEYS
 * s                  : save png
 */

import processing.video.*;
import java.util.Calendar;

Movie movie;

// horizontal and vertical grid count
// take care of the aspect ratio ... here 4:3
int tileCountX = 6;
int tileCountY = 9;
float tileWidth, tileHeight;
int imageCount = tileCountX*tileCountY; 
int currentImage = 0;
int gridX = 0;
int gridY = 0;


void setup() {
  fullScreen();
  
  // Used for drawing geometry with antialiasing 
  // (Hard to tell if this does anything on high resolution monitors)
  smooth();
  
  //Start the sketh with a black background
  background(0); 

  // Specify a path or use selectInput() to load a video or 
  // simply put it into the data folder
  movie = new Movie(this, "2.mov");
  movie.play();

  tileWidth = width / (float)tileCountX;
  tileHeight = height / (float)tileCountY;
}


void draw() {

  // Calculate the current time in movieclip
  float moviePos = map(currentImage, 0,imageCount, 0,movie.duration());
  
  // Jump to frame of movie and read it
  movie.jump(moviePos);
  movie.read();
  
  // Location of tiles
  float posX = tileWidth*gridX;
  float posY = tileHeight*gridY;
  
  // Draw image on canvas
  image(movie, posX, posY, tileWidth, tileHeight);

  // Move grid position to next tile
  gridX++;
  if (gridX >= tileCountX) {
    gridX = 0;
    gridY++;
  }

  currentImage++;
  if (currentImage >= imageCount) noLoop();
}

void keyReleased() {
  //Save screenshot
  if (key == 's' || key == 'S') saveFrame(timestamp()+"article" + "_####.tiff");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}