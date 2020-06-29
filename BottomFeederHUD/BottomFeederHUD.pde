ControlWindow controlPanel;

void settings()
{
  fullScreen(P3D, 2);
}

void setup()
{
  controlPanel = new ControlWindow(this);
  String[] args = {"Rift"};
  PApplet.runSketch(args, controlPanel);
}

void draw()
{
  background(0);
}
  
void keyPressed()
{
  if( key == 'q' || key == 'Q')
  {
    controlPanel.exit();
    this.exit();
  }
}
