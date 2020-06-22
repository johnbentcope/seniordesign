public class RiftDisp extends PApplet {

  Rift r;
  float scale = 2;
  float eyeX, eyeY, eyeZ;
  float centerX, centerY, centerZ;
  float upX, upY, upZ;
  int cameraToggle = 2;
  int vscale = 900;
  
  PGraphics[] s = new PGraphics[3]; // scenebuilder
  // Scene 0 left eye
  // Scene 1 right eye
  // Scene 2 meta
  
  float phi = (sqrt(5)+1)/2 - 1; // golden ratio
  float ga = phi*2*PI;           // golden angle
  
  int numPoints = 300;

  
  doubleWindow parent;
  
  RiftDisp(doubleWindow myParent) {
    parent = myParent;
  }

  void settings() {
    fullScreen(P2D, 2);
  }   
  
  void setup()
  {
    for (int i = 0; i < 3; i++)
    {
      s[i] = createGraphics(960, 1080, P3D);
    }
    r = new Rift();
  }

  void draw()
  {
  int vscale = 300;
  float ipd = 3;
    float[] quat = r.getRot();
 
  // Render each of the three scenes
  for(int i = 0; i < 3; i ++)
  {
    switch(i) {
      case 0:
        eyeX = ipd*sin(scale*quat[1])*cos(scale*quat[2]+PI); 
        eyeY = ipd*cos(scale*quat[1])*cos(scale*quat[2]+PI); 
        eyeZ = ipd*sin(scale*quat[2]+PI);
        centerX = vscale*cos(scale*quat[1])*cos(scale*quat[0]);
        centerY = -vscale*sin(scale*quat[1])*cos(scale*quat[0]);
        centerZ = vscale*sin(scale*quat[0]);
        break;
      case 1:
        eyeX = ipd*sin(scale*quat[1])*cos(scale*quat[2]); 
        eyeY = ipd*cos(scale*quat[1])*cos(scale*quat[2]); 
        eyeZ = ipd*sin(scale*quat[2]);
        centerX = vscale*cos(scale*quat[1])*cos(scale*quat[0]);
        centerY = -vscale*sin(scale*quat[1])*cos(scale*quat[0]);
        centerZ = vscale*sin(scale*quat[0]);
        break;
      case 2:
        eyeX = 500*sin(2*TWO_PI*mouseX/width+1.5*PI);
        eyeY = 500*cos(2*TWO_PI*mouseX/width+1.5*PI);
        eyeZ = (height/2.0-mouseY)*3;
        centerX = centerY = centerZ = 0.0;
        upX = upY = 0.0;
        upZ = -1.0;
        break;
      default:
        eyeX = eyeY = eyeZ = 0;
        centerX = vscale*cos(scale*quat[1])*cos(scale*quat[0]);
        centerY = -vscale*sin(scale*quat[1])*cos(scale*quat[0]);
        centerZ = vscale*sin(scale*quat[0]);
        break;
    }
    s[i].beginDraw();
      
    s[i].lights();
    s[i].background(0);
    s[i].camera(
      eyeX, eyeY, eyeZ, 
      centerX, centerY, centerZ, 
      upX, upY, upZ  
      );
      
    s[i].pushMatrix();
    if (i == 2)
    {
      
      s[i].stroke(0,255,255);
      s[i].line(ipd*sin(scale*quat[1])*cos(scale*quat[2]),
        ipd*cos(scale*quat[1])*cos(scale*quat[2]),
        ipd*sin(scale*quat[2]),
        vscale*cos(scale*quat[1])*cos(scale*quat[0]),
        -vscale*sin(scale*quat[1])*cos(scale*quat[0]),
        vscale*sin(scale*quat[0])
        );
      s[i].line(ipd*sin(scale*quat[1])*cos(scale*quat[2]+PI),
        ipd*cos(scale*quat[1])*cos(scale*quat[2]+PI),
        ipd*sin(scale*quat[2]+PI),
        vscale*cos(scale*quat[1])*cos(scale*quat[0]),
        -vscale*sin(scale*quat[1])*cos(scale*quat[0]),
        vscale*sin(scale*quat[0])
        );
      s[i].stroke(255,255,0);
      s[i].line(0,0,0,
        //vscale*cos(scale*quat[1])*cos(scale*quat[0]+HALF_PI),
        vscale,
        -vscale*sin(scale*quat[2]),
        //-vscale*sin(scale*quat[1])*cos(scale*quat[0]+HALF_PI)*cos(scale*quat[2]),
        vscale//*sin(scale*quat[0]+HALF_PI)
        );
        
      s[i].stroke(255, 0, 0);
      s[i].line(0, 0, 0, 300, 0, 0);
      s[i].stroke(0, 255, 0);
      s[i].line(0, 0, 0, 0, 300, 0);
      s[i].stroke(0, 0, 255);
      s[i].line(0, 0, 0, 0, 0, 300);
      s[i].rotateZ(-scale*quat[1]);
      s[i].rotateY(-scale*quat[0]);
      s[i].rotateX(scale*quat[2]);
      s[i].stroke(0);
      s[i].box(20, 300, 50);
    }
    s[i].popMatrix();
    
    s[i].pushMatrix();
    if (i == 2)
    {
      s[i].stroke(0);
      s[i].pushMatrix();
      s[i].translate(
        vscale*sin(scale*quat[1])*cos(scale*quat[2]), 
        vscale*cos(scale*quat[1])*cos(scale*quat[2]), 
        vscale*sin(scale*quat[2])
        );
      s[i].box(20);
      s[i].popMatrix();
      s[i].pushMatrix();
      s[i].translate(
        vscale*sin(scale*quat[1])*cos(scale*quat[2]+PI), 
        vscale*cos(scale*quat[1])*cos(scale*quat[2]+PI), 
        vscale*sin(scale*quat[2]+PI)
        );
      s[i].box(20);
      s[i].popMatrix();
    }
    s[i].popMatrix();
        
    for (int j = 0; j < numPoints; j++)
    {
      float rho = j*PI/numPoints;
      float theta = j*ga;
  
      s[i].pushMatrix();
      s[i].translate(
        vscale*sin(scale*theta)*cos(scale*rho),
        vscale*cos(scale*theta)*cos(scale*rho),
        vscale*sin(scale*rho));
      s[i].box(10);
      s[i].popMatrix();
      theta+= HALF_PI/8;
      s[i].pushMatrix();
      s[i].translate(
        1.5*vscale*sin(scale*theta)*cos(scale*rho),
        1.5*vscale*cos(scale*theta)*cos(scale*rho),
        1.5*vscale*sin(scale*rho));
      s[i].box(10);
      s[i].popMatrix();
      theta+= HALF_PI/8;
      s[i].pushMatrix();
      s[i].translate(
        1.5*1.5*vscale*sin(scale*theta)*cos(scale*rho),
        1.5*1.5*vscale*cos(scale*theta)*cos(scale*rho),
        1.5*1.5*vscale*sin(scale*rho));
      s[i].box(10);
      s[i].popMatrix();
    }
    s[i].endDraw();
  }
    
    // Draw once for each eye
    pushMatrix();
    translate(0,960*2);
    rotate(-HALF_PI);
    image(s[0], 0, 0);
    popMatrix();
    pushMatrix();
    translate(0,960);
    rotate(-HALF_PI);
    image(s[1], 0, 0);
    popMatrix();
  }
  
  void mousePressed()
  {
    println(mouseX, mouseY);
  }
}
