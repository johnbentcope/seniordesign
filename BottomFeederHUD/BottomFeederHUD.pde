// John Cope
// For Senior Design
// June 29, 2020

// These imports are for Barrel Distortion for the Rift
import camera3D.Camera3D;
import camera3D.generators.*;
Camera3D camera3D;

// Create a window on the main desktop
ControlWindow controlPanel;

// This is the Java Binding for the Oculus Rift's API
Rift r;

void settings()
{
  // This sets the Oculus Rift's headset up.
  // It must be the secondary monitor, and it must be oriented as landscape
  fullScreen(P3D, 2);
  
  // Initialize the Rift API
  r = new Rift();
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
  camera3D.enableSaveFrame('s',"debug");

}

void draw()
{
  // Draw to the rift in this draw() loop
  background(0);
}

// Quit if q is pressed while the Rift display has focus
void keyPressed()
{
  if( key == 'q' || key == 'Q')
  {
    controlPanel.exit();
    this.exit();
  }
}
