class ControlWindow extends PApplet
{
  
  BottomFeederHUD parent;
  
  ControlWindow(BottomFeederHUD myParent)
  {
    parent = myParent;
  }
  
  void settings()
  {
    size(400,400);
  }
  
  void setup()
  {
    surface.setTitle("Control Panel");
  }
  
  void draw()
  {
    background(0);
    ellipse(mouseX, mouseY, 20, 20);
  }
  
  // Quit if q is pressed while control panel has focus
  void keyPressed()
  {
    if( key == 'q' || key == 'Q')
    {
      parent.exit();
      this.exit();
    }
  }
  
}
