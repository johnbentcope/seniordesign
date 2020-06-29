import processing.video.*;

PImage label;
PShape can;
float angle;

PShader texShader;

Capture cam;

void setup()
{
  size(640,480,P3D);
  
  label = loadImage("lachoy.jpg");
  texShader = loadShader("texfrag.glsl", "texvert.glsl");
  
  cam = new Capture(this, "name=Integrated Camera,size=320x180,fps=30");
  
  cam.start();
}

void draw()
{
  
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0, width, height);
  
  background(0);
  label = cam;
  can = createCan(100, 200, 32, label);
  shader(texShader);
    
  translate(width/2, height/2);
  rotateY(angle);
  shape(can);
  angle += 0.01;
}

PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);
  }
  sh.endShape();
  return sh;
}
