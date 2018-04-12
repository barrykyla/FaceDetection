
import oscP5.*;
OscP5 oscP5;
import processing.video.*;
import gab.opencv.*;

Capture webcam;              // webcam input
OpenCV cv;                   // instance of the OpenCV library
ArrayList<Contour> blobs;    // list of blob contours
int camWidth =  640;   // we'll use a smaller camera resolution, since
int camHeight = 360;   // HD video might bog down our computer

int gridSize =  5; 
boolean debug = false;    // use 'd' key to enable debug mode



// num faces found
int found =0;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;
float scalenum;
float x;
float y;
void setting() {
  fullScreen(P2D, 1);
}


void setup() {
  //size(640, 480);
  size(1280, 720);
  //frameRate(30);
  scalenum = 2;
  cv = new OpenCV(this, 640, 480);
  String[] inputs = Capture.list();
  if (inputs.length == 0) {
    println("Couldn't detect any webcams connected!");
    exit();
  }
  webcam = new Capture(this, inputs[0]);
  webcam.start();

  textSize(20);
  textAlign(LEFT, BOTTOM);
  println("DISPLAY INFO:");
  noFill();

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
}





void draw() {
  //background(255);

  if (webcam.available()) {

    webcam.read();
    image(webcam, 0, 0, width, height);
  }
  //println("scale: " + s);
  //poseScale = s * 0.9;
  //public void posePosition(float x, float y) {

  }



void keyPressed() {
      println("pose position\tX: " + x + " Y: " + y );
    posePosition.set(x, y, 0);
    found = 1;
  }

  public void poseOrientation(float x, float y, float z) {
    println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
    poseOrientation.set(x, y, z);
  }

  public void mouthWidthReceived(float w) {
    println("mouth Width: " + w);
    mouthWidth = w;
  }

  public void mouthHeightReceived(float h) {
    println("mouth height: " + h);
    mouthHeight = h;
  }

  public void eyeLeftReceived(float f) {
    println("eye left: " + f);
    eyeLeft = f;
  }

  public void eyeRightReceived(float f) {
    println("eye right: " + f);
    eyeRight = f;
  }

  public void eyebrowLeftReceived(float f) {
    println("eyebrow left: " + f);
    eyebrowLeft = f;
  }

  public void eyebrowRightReceived(float f) {
    println("eyebrow right: " + f);
    eyebrowRight = f;
  }

  public void jawReceived(float f) {
    println("jaw: " + f);
    jaw = f;
  }

  public void nostrilsReceived(float f) {
    println("nostrils: " + f);
    nostrils = f;
  }

  // all other OSC messages end up here
  void oscEvent(OscMessage m) {
    if (m.isPlugged() == false) {
      println("UNPLUGGED: " + m);
      found = 0;
    }
  //if (found == 0){
  //  translate((posePosition.x)*2, (posePosition.y)*1.5);
  //  scale(poseScale*1.25);
  //  noFill();
  //  stroke(165, 42, 42);
  //  ellipse(-20, eyeRight*-9, 30, 30);
  //  stroke(205, 133, 63);
  //  ellipse(-20, eyeLeft * -9, 20, 20);
  //  stroke(165, 42, 42);
  //  ellipse(-20, eyeLeft * -9, 10, 10);
  //  stroke(165, 42, 42);
  //  ellipse(20, eyeRight * -9, 30, 30);
  //  stroke(205, 133, 63);
  //  ellipse(20, eyeRight * -9, 20, 20);
  //  stroke(165, 42, 42);
  //  ellipse(20, eyeRight * -9, 10, 10);
  //  stroke(218, 165, 32);
  //  quad(0, mouthWidth* 3, 20, 10, 0, mouthHeight, -20, 20);
  //  rect(-1, nostrils * -3, 3, 40);
  //  //rect(5, nostrils * -1, 7, 3);
  //  rectMode(CENTER);
  //  stroke(107, 142, 35);
  //  rect(36, 10, jaw *-1, 5); 
  //  rect(-44, 20, jaw *-1, 5);
  //  stroke(240, 230, 140);
  //  rect(36, 10, jaw /-1, 2);
  //  rect(-44, 20, jaw /-1, 2);
  //  //rect(20, eyebrowRight * -5, 25, 5);
  //}else{
    translate((posePosition.x)*2, (posePosition.y)*1.5);
    scale(poseScale*1.25);
    noFill();
    stroke(165, 42, 42);
    rect(-20, eyeRight*-9, 30, 30);
    stroke(205, 133, 63);
    rect(-20, eyeLeft * -9, 20, 20);
    stroke(165, 42, 42);
    rect(-20, eyeLeft * -9, 10, 10);
    stroke(165, 42, 42);
    rect(20, eyeRight * -9, 30, 30);
    stroke(205, 133, 63);
    rect(20, eyeRight * -9, 20, 20);
    stroke(165, 42, 42);
    rect(20, eyeRight * -9, 10, 10);
    stroke(218, 165, 32);
    triangle(0, mouthWidth* 3, 20, 10, 0, mouthHeight);
    rect(-1, nostrils * -3, 3, 40);
    //rect(5, nostrils * -1, 7, 3);
    rectMode(CENTER);
    stroke(107, 142, 35);
    ellipse(36, 10, jaw *-1, 5); 
    rect(-44, 20, jaw *-1, 5);
    stroke(240, 230, 140);
    rect(36, 10, jaw /-1, 2);
   rect(-44, 20, jaw /-1, 2);
//  }
   

//}