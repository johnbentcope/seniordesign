import processing.video.*;
Movie movie;

void setup() {
  size(1280, 720, P2D);
  Movie.supportedProtocols[0] = "rtsp";
  println(Movie.supportedProtocols[0]);
  try {
    movie = new Movie(this, "rtsp://10.42.0.166:8554/test");
    movie.play();
  } 
  catch (Exception e) {
    println(e);
  }
}

void movieEvent(Movie m) {
  try {
    m.read();
  }
  catch (Exception e)
  {
    println(e);
  }
}

void draw() {
  background(0);
  PImage i;
  
  try {
    i = movie;
  }
  catch (Exception e) {
    println(e);
  }
  
  image(movie, 0, 0, width, height);
}
