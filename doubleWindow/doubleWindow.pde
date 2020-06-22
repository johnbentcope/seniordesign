RiftDisp riftDisp;

PImage i;

void settings() {
  size(480, 540, P2D);
}

void setup()
{
  riftDisp = new RiftDisp(this);
  String[] args = {"Rift"};
  PApplet.runSketch(args, riftDisp);
  fill(255,0,255);
  rectMode(CENTER);
}

void draw() {
  background(0);
  rect(mouseX, mouseY, 25, 25);
  // I would like to call this here
  // image(rift.buffer,0,0,200,200);
}
  
  void mousePressed()
  {
    println(mouseX, mouseY);
  }
