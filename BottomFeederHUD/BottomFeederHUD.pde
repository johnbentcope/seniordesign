// John Cope
// For Senior Design
// June 29, 2020

// These imports are for Barrel Distortion for the Rift
import camera3D.Camera3D;
import camera3D.generators.*;
Camera3D camera3D;

PFont f;

PImage frontside; 
PImage backside; 

// Create a window on the main desktop
ControlWindow controlPanel;

// This is the Java Binding for the Oculus Rift's API
Rift r;

float rot = 75f;
float rotX = rot * 0.5f;
float rotY = rot * 0.1f;
float rotZ = rot * 0.3f;

PVector vector;

float[] ro;

void settings()
{
  // This sets the Oculus Rift's headset up.
  // It must be the secondary monitor, and it must be oriented as landscape
  fullScreen(P3D, 2);
  //size(900,450,P3D);
  // Initialize the Rift API
  r = new Rift();

  vector = new PVector(0, 0, 0);
  frontside = loadImage("frontside.png");
  backside = loadImage("backside.png");
}

void setup()
{
  // Initialize the control panel
  controlPanel = new ControlWindow(this);
  String[] args = {"Rift"};
  PApplet.runSketch(args, controlPanel);

  // Set up a new Barrel Distortion Shader
  camera3D = new Camera3D(this);
  BarrelDistortionGenerator generator = camera3D.renderBarrelDistortion().setDivergence(1);
  // Change these numbers to learn how this works. Set them to 0, 0 for no distortion.
  generator.setBarrelDistortionCoefficients(0.22, 0.24);

  camera3D.setBackgroundColor(255);
  camera3D.enableSaveFrame('s', "debug");
  f = createFont("Lato-Heavy-48.vlw", 48);
  textFont(f);
}


void preDraw() {
  //rot = vector.x;
  ro = r.getRot();
  // ro[0] is ROLL
  // ro[1] is PITCH
  // ro[2] is YAW
}
void draw()
{
  camera( 0, 0, 0, 
    100, 0, 0, 
    0, 0, 1);

  // Draw to the rift in this draw() loop
  background(0);
  int boxSize = 700;
  int zDepth = -800;
  pushMatrix();
  //fill(255, 0, 0);
  rotateY(-ro[1]);
  rotateZ(-ro[2]);
  rotateY(PI/2);
  rotateZ(PI/2);
  fill(200,200,0);
  pushMatrix();
  translate(200,200,400);
  rotateX((width/2+mouseX)*PI/width);  
  rotateZ((width/2+mouseX)*PI/width);
  box(50,50,100);
  popMatrix();
  
  fill(255);
  pushMatrix();
  rotateY((width/2+mouseY)*4*PI/width);

  pushMatrix();
  translate(0, 0, 500);
  rotateY(PI);
  text("N", 0, 0);
  popMatrix();
  pushMatrix();
  rotateY(HALF_PI);
  translate(0, 0, 500);
  rotateY(PI);
  text("W", 0, 0);
  popMatrix();
  pushMatrix();
  rotateY(PI);
  translate(0, 0, 500);
  rotateY(PI);
  text("S", 0, 0);
  popMatrix();
  pushMatrix();
  rotateY(HALF_PI + PI);
  translate(0, 0, 500);
  rotateY(PI);
  text("E", 0, 0);
  popMatrix();


  popMatrix();
  pushMatrix();
  scale(-1, 1, 1);
  shape(screen(frontside));
  popMatrix();
  pushMatrix();
  scale(1, 1, -1);
  shape(screen(backside));
  popMatrix();
  popMatrix();
}

PShape screen(PImage image) {
  PShape ret;
  ret = createShape();

  float step = image.height/20;

  ret.setFill(color(0, 0, 20));
  ret.setStrokeWeight(2);
  ret.setStroke(color(255));
  ret.beginShape(QUADS);
  ret.texture(image);
  int d = 200;
  int r = 1900;
  for (int i = -10; i <= 10; i++)
  {
    for (int j = -10; j <= 10; j++)
    {
      int ii = i+1;
      int jj = j+1;

      ret.vertex( i*d, j*d, scrZ(r, i*d, j*d), i*step+image.width/2, j*step+image.height/2);
      ret.vertex(ii*d, j*d, scrZ(r, ii*d, j*d), ii*step+image.width/2, j*step+image.height/2);
      ret.vertex(ii*d, jj*d, scrZ(r, ii*d, jj*d), ii*step+image.width/2, jj*step+image.height/2);
      ret.vertex( i*d, jj*d, scrZ(r, i*d, jj*d), i*step+image.width/2, jj*step+image.height/2);
    }
  }

  ret.endShape();
  return ret;
}

float scrZ(float rad, float x, float y)
{
  float spherepoint = rad*rad - (x*x + y*y);
  spherepoint = (spherepoint > 0) ? spherepoint : 0;
  float ret = sqrt(spherepoint);
  //println(ret);
  return ret;
}

// Quit if q is pressed while the Rift display has focus
void keyPressed()
{
  if ( key == 'q' || key == 'Q')
  {
    controlPanel.exit();
    this.exit();
  }
}
