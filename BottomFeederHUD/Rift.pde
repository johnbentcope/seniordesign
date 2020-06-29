public class Rift extends OpenHMD
{
  long ctx;
  long dev;
  
  Rift()
  {
    ctx = ohmd_ctx_create();
    System.out.println("ctx: " + ctx);
    
    int numDevices = ohmd_ctx_probe(ctx);
    System.out.println("numDevices (probe): " + numDevices);
    
    dev = ohmd_list_open_device(ctx, 0);
    System.out.println("dev: " + dev);
  
    ohmd_ctx_update(ctx);
  }
  
  public float[] getRot()
  {
    // Ping the Rift and tell it to get data ready for us (maybe, I think that's what ctx_update does)
    ohmd_ctx_update(ctx);
    
    // getf() gets a quaternion representing headset position
    Quaternion q = new Quaternion(ohmd_device_getf(dev, 1));
    
    
    //for (float f : rot)
    //System.out.println(f + ", " + frameCount);
    
    // Convert that quaternion into euler angles
    
  return q.GetEulerAngles();
  }
}
