float angle, speed;
float l0, l1, l2;
int n = 5;
boolean first = true;

void setup() {
  size(800, 800);
  angle = 0;
  speed = 0.01;
  background(0);
}

void draw() {  
  fill(0, 10);
  rect(0, 0, width, height);

  translate(width/2, height/2);
  rotate(angle);
  
  l0 = map(mouseX, 0, width, 50, 200);
  l1 = map(mouseY, 0, width, 37, 150);
  l2 = map(mouseX+mouseY, 0, width+height, 25, 100);
  
  for (int i=0; i<n; i++) {
    fill(150, 100);
    pushMatrix();
    rotate(i*TWO_PI/n);
    translate(0, l0);
    ellipse(0, 0, 15, 15);

    for (int j=0; j<n; j++) {
      fill(200, 100);
      pushMatrix();
      rotate(j*TWO_PI/n);
      translate(0, l1);
      ellipse(0, 0, 10, 10);

      for (int k=0; k<n; k++) {
        fill(250, 100);
        pushMatrix();
        rotate(k*TWO_PI/n);
        translate(0, l2);    
        ellipse(0, 0, 5, 5);
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
  angle = (angle+speed)%TWO_PI;
}
