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
  
  void setup(){}
  
  void draw()
  {
    background(0);
    ellipse(mouseX,mouseY, 20,20);
  }
  
  void mousePressed()
  {
    println(mouseX, mouseY);
  }
  
  void keyPressed()
  {
    if( key == 'q' || key == 'Q')
    {
      parent.exit();
      this.exit();
    }
  }
  
}
