class Quaternion
{
  float w, x, y, z;
  
  Quaternion(float[] xyzw){
    x = xyzw[0];
    y = xyzw[1];
    z = xyzw[2];
    w = xyzw[3];
  }
  
  float[] GetEulerAngles()
  {
      float[] angles;
      angles = new float[3];
      float w2 = w*w;
      float x2 = x*x;
      float y2 = y*y;
      float z2 = z*z;
      float unitLength = w2 + x2 + y2 + z2;    // Normalised == 1, otherwise correction divisor.
      float abcd = w*x + y*z;
      float eps = 1e-7;    // TODO: pick from your math lib instead of hardcoding.
      float pi = 3.14159265358979323846;   // TODO: pick from your math lib instead of hardcoding.
      if (abcd > (0.5-eps)*unitLength)
      {
          angles[0] = 2 * atan2(y, w);
          angles[1] = pi;
          angles[2] = 0;
      }
      else if (abcd < (-0.5+eps)*unitLength)
      {
          angles[0] = -2 * atan2(y, w);
          angles[1] = -pi;
          angles[2] = 0;
      }
      else
      {
          float adbc = w*z - x*y;
          float acbd = w*y - x*z;
          angles[0] = atan2(2*adbc, 1 - 2*(z2+x2)); // ROLL
          angles[1] = asin(2*abcd/unitLength);      // 
          angles[2] = atan2(2*acbd, 1 - 2*(y2+x2)); // PITCH
      }
      
      println("yaw: " + angles[0] + "| pitch: " + angles[1] + "| roll: " + angles[2] );
      
      return angles;
  }
}
