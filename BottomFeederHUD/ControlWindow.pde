class ControlWindow extends PApplet
{
  float theta = 0;
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
    rectMode(CORNERS);
  }
  
  void draw()
  {
    background(0);
    ellipse(mouseX, mouseY, 20, 20);
    parent.vector = new PVector(mouseX, mouseY, 0);
    translate(width/2,height/2);
    rotate(theta);
    rect(-20,-20,20,20);
    rect(-10,-25,10,20);
  }
  
  void mousePressed()
  {
    theta = -parent.ro[1];
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
