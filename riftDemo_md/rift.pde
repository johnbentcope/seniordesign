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
    ohmd_ctx_update(ctx);
    float[] rot = ohmd_device_getf(dev, 1);
    //for (float f : rot)
    //System.out.println(f + ", " + frameCount);
    return rot;
  }
}
