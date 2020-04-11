import java.awt.Color;
float a = 0.5, b = 1;
int scale = 150;
int iterations = 1;
int offsetx, offsety;
void setup(){
  background(0);
 size(1920, 1080);
 render();
 text("WASD - mozgatás", 50, 50);
 text("SPACE - zoomolás (középre)", 50, 75);
 text("Iteráció: "+iterations, 50, 100);
}

void render(){
 for(int x = 0; x < width; x++){
  for(int y = 0; y < height; y++){
   set(x, y, (int)(calculate(((x-width/2f-offsetx)/scale), (y-height/2f-offsety)/scale)));
  }
 }
}

int calculate(float x, float y){
  //float cx = x;
  //float cy = y;
  int i=0;
  for(; i <iterations; i++){
   float nx = x*x - y*y -a;
   float ny = 2*x*y -b;
   if(nx*nx+ny*ny > 4)break;
   
   
   x = nx;
   y = ny;
  }
  if(i == iterations)return Color.HSBtoRGB(x/y, 0.7f, 0);
  return Color.HSBtoRGB((float)i*2/iterations, 0.7f, 1.2);
}

void draw(){
  iterations++;
  render();
  text("WASD - mozgatás", 50, 50);
 text("SPACE - zoomolás (középre)", 50, 75);
 text("Iteráció: "+iterations, 50, 100);
  delay(0);
}

void keyPressed(){
 if(key == 'd'){
   offsetx -=50;
 }
 if(key == 'a'){
  offsetx +=50; 
 }
 if(key == 's'){
  offsety-=50; 
 }
 if(key=='w'){
  offsety+=50; 
 }
 
 if(key==' '){scale+=1000;}
 render();
 
}
