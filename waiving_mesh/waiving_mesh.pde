import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

final int W = 160;
final int H = 160;
final int SIZE = 1;
final int NOISE_AMPLITUDE = SIZE * 10;

float zNoise = 0;
boolean fill = false;

float getNoise(int i, int j) {
  return noise(i / 10f, j / 10f, zNoise) * NOISE_AMPLITUDE;
}

void setup() {
  size(640, 640, P3D);
  smooth(8);
  PeasyCam cam = new PeasyCam(this, W * SIZE / 2, H * SIZE / 2, 0, W * SIZE / 2);
  cam.rotateX(-PI / 4);
  cam.rotateY(PI / 4);
  cam.rotateZ(-PI / 4);
}

void draw() {
  background(0);
  
  if(!fill) {
    noFill();
    stroke(#37AEA5);
    strokeWeight(0.5);
  } else {
    fill(#37AEA5);
    noStroke();
    lights();
  }
    
  translate(SIZE, SIZE);
  for(int i = 0 ; i < W-1 ; i++) {
    beginShape(QUAD_STRIP);
    for(int j = 0 ; j < H ; j++) {
      vertex(i, j, getNoise(i, j));
      vertex(i+1, j, getNoise(i+1, j));
    }
    endShape();
  }
  zNoise += 0.5/frameRate;
}

void keyPressed() {
  fill = !fill;
}