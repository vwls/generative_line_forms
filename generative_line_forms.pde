import controlP5.*;
import processing.pdf.*;


// These are the variable parameters that user can control
int SIZE_MIN = 50;
int SIZE_MAX = 250; 
int NUMBER_OF_LINES = 60;
int TRANSLATE_X = 0;
int TRANSLATE_Y = 6;
float CIRCLE_RESOLUTION = 0.1;

int backgroundColorR = 0;
int backgroundColorG = 0;
int backgroundColorB = 0;
int strokeColorR = 255;
int strokeColorG = 255;
int strokeColorB = 255;
int strokeColorA = 255;

// Use these to place parameter control UI
//int CONTROLS_POS_X = -550 + 550;
//int CONTROLS_POS_Y = -600 + 600;
int CONTROLS_POS_X = 50;
int CONTROLS_POS_Y = 50;
int CONTROLS_DISTANCE = 40;

color controlLabels = color(255, 255, 255);

ControlP5 cp5;

void setup() {
  size(1200, 800);
  beginRecord(PDF, "pdf_####.pdf");

  // Set up our UI parameter controls
  setupControls();
  
  // By default, hide parameter controls - to show press 's' key
  cp5.hide();
   
}

void draw() {
  background(backgroundColorR, backgroundColorG, backgroundColorB);
  
  pushMatrix();
  translate(width/2, height/3);
  //stroke(75, 100, 100);
  stroke(strokeColorR, strokeColorG, strokeColorB, strokeColorA);
  noFill();
  
  for(int i = 0; i < NUMBER_OF_LINES; i++){
    beginShape();
    for(float a = 0; a < TWO_PI; a += CIRCLE_RESOLUTION){
      float xoff = cos(a) + 1; // adding one to make positive as perlin noise only generates positive numbers
      float yoff = sin(a) + 1;
      float r = map(noise(xoff, yoff), 0, 1, SIZE_MIN, SIZE_MAX);
      float x = r * cos(a);
      float y = r * sin(a);
      vertex(x, y);  
    }
    endShape(CLOSE);
    translate(TRANSLATE_X, TRANSLATE_Y);
  }
  popMatrix();

}

// This function creates all of our parameter controls and sets their ranges and default settings
void setupControls(){
  cp5 = new ControlP5(this);
  cp5.addSlider("SIZE_MIN")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 0))
       .setSize(200, 20)
       .setRange(0, 500)
       .setValue(50)
       .setColorCaptionLabel(controlLabels);
       
   cp5.addSlider("SIZE_MAX")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 1))
       .setSize(200, 20)
       .setRange(0, 500)
       .setValue(250)
       .setColorCaptionLabel(controlLabels);
       
   // Default settings for NUMBER_OF_LINES paremeter
   cp5.addSlider("NUMBER_OF_LINES")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 2))
       .setSize(200, 20)
       .setRange(1, 100)
       .setValue(60)
       .setColorCaptionLabel(controlLabels);
       
   cp5.addSlider("TRANSLATE_X")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 3))
       .setSize(200, 20)
       .setRange(0, 25)
       .setValue(0)
       .setColorCaptionLabel(controlLabels);
       
   cp5.addSlider("TRANSLATE_Y")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 4))
       .setSize(200, 20)
       .setRange(0, 25)
       .setValue(6)
       .setColorCaptionLabel(controlLabels);
       
   cp5.addSlider("CIRCLE_RESOLUTION")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 5))
       .setSize(200, 20)
       .setRange(0, 1)
       .setValue(0.1)
       .setColorCaptionLabel(controlLabels);
   
   // Background color parameter controls
   cp5.addSlider("backgroundColorR")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 6))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(10)
       .setColorCaptionLabel(controlLabels);
   cp5.addSlider("backgroundColorG")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 7))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(10)
       .setColorCaptionLabel(controlLabels);
   cp5.addSlider("backgroundColorB")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 8))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(10)
       .setColorCaptionLabel(controlLabels);
       
   // Stroke color parameter controls
   cp5.addSlider("strokeColorR")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 9))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(255)
       .setColorCaptionLabel(controlLabels);
   cp5.addSlider("strokeColorG")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 10))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(255)
       .setColorCaptionLabel(controlLabels);
   cp5.addSlider("strokeColorB")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 11))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(255)
       .setColorCaptionLabel(controlLabels);
   cp5.addSlider("strokeColorA")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 12))
       .setSize(200, 20)
       .setRange(0, 255)
       .setValue(255)
       .setColorCaptionLabel(controlLabels);
       
   // Set up .tif capture button
   cp5.addButton("saveImage")
       .setPosition(CONTROLS_POS_X, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 13))
       .setSize(100, 40);
       
   // Set up .pdf capture button
   cp5.addButton("savePDF")
       .setPosition(CONTROLS_POS_X + 125, CONTROLS_POS_Y + (CONTROLS_DISTANCE * 13))
       .setSize(100, 40);
}

// This function manages our key events
// PRESS "s" KEY TO SHOW CONTROLS
// PRESS "h" KEY TO HIDE CONTROLS
// PRESS "P" KEY TO SAVE FRAME
// PRESS "R" KEY TO RERUN SKETCH
void keyPressed(){
  if(key == 's'){
    cp5.show();
    println("showing controls");
  } else if (key == 'h'){
    cp5.hide();
    println("hiding controls");
  } else if (key == 'P') {
    println("saving image via p key event");
    saveFrame();
  } else if (key == 'r'){
    println("GOT AN R KEY");
    //setup(); //Why doesn't this work?
  }
}

// This function creates a button for outputting current frame as image file
public void controlEvent(ControlEvent theEvent) {
  //println(theEvent.getController().getName());
  String eventIs = theEvent.getController().getName();
  if(eventIs == "saveImage"){
    println("time to save an image");
    cp5.hide();
    saveFrame();
  } else if (eventIs == "savePDF"){
    cp5.hide();
    println("time to save a pdf");
    endRecord();
  }
}
