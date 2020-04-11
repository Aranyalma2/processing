import com.jogamp.newt.opengl.GLWindow;
import java.util.*;

GLWindow r;

int meret=30;
Set<Integer> mazer = new HashSet<Integer>();
boolean mazecheck;
int checkX,checkZ;
int[][] labirintus = new int[meret][meret];
int i,c,j,d=1,endX,endZ;
boolean[] igaz = new boolean[4]; 
float pozX,pozZ,angH,angV;
int rand;
String state="jatek",secret="ace7e92bf00cb002b9bb1907ddf74604",pass;
PFont font1,font2;

void setup()
{
  smooth(8);
  fullScreen(P3D);
  //size(1500,800,P3D);
  font1 = loadFont(dataPath("Minecraft300.vlw"));
  font2 = loadFont(dataPath("Minecraft30.vlw"));
  r = (GLWindow)surface.getNative();
  r.confinePointer(true);
  r.setPointerVisible(false);
  /*String[] maze = loadStrings(dataPath("maze.txt"));
  for (i=0;i<meret;i++) {
    for (c=0;c<meret;c++) if (maze[i].charAt(c)=='x') {labirintus[i][c]=1;}
  }*/  
  pozX=500; pozZ=500; endX=meret-2; endZ=meret-2;;
  mazegen();
 /* for (i=0;i<meret;i++) labirintus[i] = 1;
  for (i=90;i<meret*meret;i++) labirintus[i] = 1;
  for (i=0;i<meret;i++) labirintus[i*10] = 1;
  for (i=1;i<meret+1;i++) labirintus[i*10-1] = 1; */
  for (i=0;i<4;i++) igaz[i]=false;
}

void mazegen()
{
  for (i=0;i<meret;i++) {
    for (c=0;c<meret;c++) {labirintus[i][c]=1;}
  }
  labirintus[1][1]=0;
  do {
  mazer= new HashSet<Integer>();
  for (i=1;i<meret-2;i++) {
    for (c=1;c<meret-2;c++) {
      if (labirintus[i][c]==0 && labirintus[i-1][c]==1 && i-1!=0) {
        checkX=i-1;checkZ=c; mazechecking();
        if (mazecheck) {mazer.add((i-1)*meret+c); println(i-1,' ',c);}
      }
      if (labirintus[i][c]==0 && labirintus[i+1][c]==1 && i+1!=meret) {
        checkX=i+1;checkZ=c; mazechecking();
        if (mazecheck) {mazer.add((i+1)*meret+c); println(i+1,' ',c);}
      }
      if (labirintus[i][c]==0 && labirintus[i][c+1]==1 && c+1!=meret) {
        checkX=i;checkZ=c+1; mazechecking();
        if (mazecheck) {mazer.add(i*meret+c+1); println(i,' ',c+1);}
      }
      if (labirintus[i][c]==0 && labirintus[i][c-1]==1 && c-1!=0) {
        checkX=i;checkZ=c-1; mazechecking();
        if (mazecheck) {mazer.add(i*meret+c-1); println(i,' ',c-1);}
      }
    }
  }
  rand=(int)(Math.random()*mazer.size()+1);
  println("rand:",rand);
  for (i=1;i<meret-1;i++) {
    for (c=1;c<meret-1;c++) {
      if (mazer.contains(i*meret+c)) {rand--;}
      if (rand==0) {labirintus[i][c]=0; rand--;}
    }
  }
  println("size:",mazer.size());
  } while (mazer.size()!=0);
  labirintus[endX][endZ]=0;
}

void mazechecking()
{
  j=0;
  mazecheck=false;
  if (labirintus[checkX-1][checkZ]==0) {j++;}
  if (labirintus[checkX+1][checkZ]==0) {j++;}
  if (labirintus[checkX][checkZ+1]==0) {j++;}
  if (labirintus[checkX][checkZ-1]==0) {j++;}
  if (j==1) {mazecheck=true;}
}

void draw()
{
  if (frameCount<3) {angH=0; angV=0;}
  if (state=="jatek") {jatek(); if (state=="input") {filter(BLUR, 10);} cheat();}
  if (state=="win") {win();}
  if (state=="input") {jatek(); input();}
}

void jatek()
{
  background(255);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  /*perspective(fov, width*1.0/height, cameraZ/10.0, 50000);
  camera( meret/2.0*500-250,25000,meret/2.0*500-250,
         meret/2.0*500-251,0,meret/2.0*500-250,
         0,-1,0
  );*/
  if (igaz[0]==true && labirintus[floor((pozX+cos(angH)*10+250)/500)][floor((pozZ+sin(angH)*10+250)/500)]!=1) {pozX+=cos(angH)*10;}
  if (igaz[0]==true && labirintus[floor((pozX+cos(angH)*10+250)/500)][floor((pozZ+sin(angH)*10+250)/500)]!=1) {pozZ+=sin(angH)*10;}
  if (igaz[1]==true) {pozX-=cos(angH)*10; pozZ-=sin(angH)*10;}
  if (igaz[2]==true) {pozX-=sin(angH)*10; pozZ+=cos(angH)*10;}
  if (igaz[3]==true) {pozX+=sin(angH)*10; pozZ-=cos(angH)*10;}
  perspective(fov, width*1.0/height, cameraZ/100000.0, 20000);
  camera(pozX,100,pozZ,
         pozX + cos(angH) * cos(angV), sin(angV)+100, sin(angH) * cos(angV) + pozZ,
         0,-1,0
  );
  fill(180,0,180);
  for (i=0;i<meret;i++) {
    for (c=0;c<meret;c++) {
      if (labirintus[i][c]==1) {
        pushMatrix();
        translate(i*500,0,c*500);
        box(500);
        popMatrix();
      }
    }
  }  
  fill(0,255,0);
  pushMatrix();
  translate(500,-375,500);
  box(250);
  popMatrix();
  
  fill(255,0,0);
  pushMatrix();
  translate(endX*500,-375,endZ*500);
  box(250);
  popMatrix();
  hint(DISABLE_DEPTH_TEST);
  camera();
  fill(0);
  textFont(font2, 30);
  textAlign(LEFT,TOP);
  text(floor(frameRate),20,20,0);
  hint(ENABLE_DEPTH_TEST);
  if (round(pozX/500)==endX && round(pozZ/500)==endZ) {state="win";}
  //if (abs((floor((angH)/PI*4))%8)==7 || abs((floor((angH)/PI*4))%8)==2) {d=1;}
  //if (abs((floor((angH)/PI*4))%8)==3 || abs((floor((angH)/PI*4))%8)==6) {d=-1;}
  //println(angH,' ',abs((floor((angH)/PI*4))%8),' ',d);
}

void input()
{
  
}

void cheat()
{
  camera();
  hint(DISABLE_DEPTH_TEST);
  for (i=0;i<meret;i++) {
    for (c=0;c<meret;c++) {
      fill(255);
      if (labirintus[i][c]==1) {fill(0);}
      if (i==1 && c==1) {fill(0,255,0);}
      if (i==endX && c==endZ) {fill(255,0,0);}
      if (i==round(pozX/500) && c==round(pozZ/500)) {fill(255,198,0);}
      rect(width-meret*10+(meret-c-1)*10,height-meret*10+(meret-i-1)*10,10,10);
    }
  }
  hint(ENABLE_DEPTH_TEST);
}

void win()
{
  background(255);
  camera();
  fill(0);
  textAlign(CENTER,CENTER);
  textFont(font1, 300);
  text("YOU WON",width/2,height/2);
}

void keyPressed()
{
 if (key == 'w') igaz[0] = true;  
 if (key == 's') igaz[1] = true; 
 if (key == 'a') igaz[2] = true; 
 if (key == 'd') igaz[3] = true; 
}

void keyReleased()
{
  if (state=="jatek") {
    if (key == 'w') igaz[0] = false;  
    if (key == 's') igaz[1] = false; 
    if (key == 'a') igaz[2] = false; 
    if (key == 'd') igaz[3] = false; 
    if (key=='r') {state="jatek"; pozX=500; pozZ=500;}
    if (key=='P' && state=="jatek") {state="input";}
  }
  if (state=="input") {
    if (keyCode!=ENTER) {pass+=key;}
    if (keyCode==ENTER) {}
  }
  println(key);
}

void mouseMoved() {
  angH-=(mouseX-(width/2))/200.0;
  //if (angV>)
  angV-=(mouseY-(height/2))/200.0;
  if (angH>2*PI) {angH-=2*PI;}
  if (angH<0) {angH=2*PI+angH;}
  r.warpPointer(width/2,height/2);
}
