// John Cope
// For Senior Design
// June 29, 2020

// These imports are for Barrel Distortion for the Rift
import camera3D.Camera3D;
import camera3D.generators.*;
Camera3D camera3D;

PImage frontside; 

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
  //fullScreen(P3D, 2);
  size(900,450,P3D);
  // Initialize the Rift API
  r = new Rift();

  vector = new PVector(0, 0, 0);
  frontside = loadImage("frontside.png");
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
}


void preDraw() {
  //rot = vector.x;
  ro = r.getRot();
  // ro[0] is ROLL
  // ro[1] is 
  // ro[2] is PITCH
}
void draw()
{
  camera( 600, 600, 600, 
    0, 0, 0, 
    0, 0, -1);
  strokeWeight(4);
  stroke(0);

  // Draw to the rift in this draw() loop
  background(0);
  int boxSize = 700;
  int zDepth = -800;

  pushMatrix();
  fill(255, 0, 0);
  rotateZ(ro[0]);
  rotateY(ro[1]);
  rotateX(ro[2]);
  //box(boxSize);
  shape(screen());
  popMatrix();
}

PShape screen() {
  PShape ret;
  ret = createShape();

  ret.setFill(color(0, 0, 20));
  ret.setStroke(color(255));
  ret.beginShape(QUADS);
  int d = 40;
  for (int i = -10; i <= 10; i++)
  {
    for (int j = -10; j <= 10; j++)
    {
      int ii = i+1;
      int jj = j+1;

      ret.vertex( i*d, j*d, i*j);
      ret.vertex(ii*d, j*d, ii*j);
      ret.vertex(ii*d, jj*d, ii*jj);
      ret.vertex( i*d, jj*d, i*jj);
    }
  }

  ret.endShape();
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
