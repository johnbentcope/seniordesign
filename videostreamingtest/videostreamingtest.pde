/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */
import java.lang.reflect.Method;

//import processing.video.*;
import org.freedesktop.gstreamer.*;
import org.freedesktop.gstreamer.Buffer;
import org.freedesktop.gstreamer.device.*;
import org.freedesktop.gstreamer.elements.*;
import org.freedesktop.gstreamer.event.SeekFlags;
import org.freedesktop.gstreamer.event.SeekType;

Capture cam;
Bin bin;

String commandString = "tee name=t t. ! " +
                          "queue ! " +
                          "videoconvert ! " +
                          "autovideosink t. ! " +
                          "queue ! " +
                          "videoconvert ! " +
                          "videoscale ! " +
                          "capsfilter caps=video/x-raw,width=640,height=480 ! " +
                          "appsink name=appsink";

String commandStringFromT = "udpsrc port=5000 ! application/x-rtp,encoding-name=H264,payload=96 ! rtph264depay ! h264parse ! queue ! avdec_h264 ! xvimagesink sync=false async=false -e";

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  Gst.init();
  
  bin = Gst.parseBinFromDescription(commandString, true);
  //Method[] methods = Bin.class.getDeclaredMethods(); int nMethod = 1;
  //System.out.println("1. List of all methods of Person class");
  //for (Method method : methods) {
  //    System.out.printf("%d. %s", ++nMethod, method);
  //    System.out.println();
  //}
  //System.out.printf("%d. End - all  methods of Person class", ++nMethod);
  
  println(bin);
  bin.getElementByName("appsink");
}

void draw() {
  exit();
}
