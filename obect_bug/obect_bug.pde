int[] random_color = new int[3];
int i,j,obj=0;
float[] [] obj_place = new float[1000000][2];
int dx,dy;
boolean[][] obj_true;



Rect myRect;
class Rect {
  float x;
  float y;
  
  Rect(float tempXpos, float tempYpos){
    x = tempXpos;
    y = tempYpos;
    }
  void display() {
    rectMode(CENTER);
    fill(random_color[0],random_color[1],random_color[2]);
    obj++;
    obj_place[obj][0] = x;
    obj_place[obj][1] = y;
    rect(x,y,50,50,5);
    
}
  }

void setup() {
    clear();
    size(600, 600);
    background(255);

  }
void mousePressed() {
    println("Mouse pressed");
    i = mouseX;
    j = mouseY;
    int n=1;
    if(obj>0){
      for(int k=obj; k!=0;k--){
        if(obj_place[k][0]<=i+25 && obj_place[k][0]>=i-25 && obj_place[k][1]<=j+25 && obj_place[k][1]>=j-25){
          println("Átfedés");
          k=1;
          n=0;
        }
        else{n=1;}
      }
    }
      if(n!=0){
        if (mouseButton == RIGHT){
          println("Jobb");
          clear();
          obj = 0;
          background(255);
      }
      if (mouseButton == LEFT){
        println("Bal");
        random_color();
        myRect = new Rect(i,j);
        myRect.display();
        println(obj_place[obj][0]);
        println(obj_place[obj][1]);
      
      
        }
      }
    }
void random_color() {
    for (int i=0; i<3; i++) {
      random_color[i]=(int)random(0, 255);
    }
  }

void draw(){}
