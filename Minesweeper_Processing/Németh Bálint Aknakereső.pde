/****************
Aknakereső 1.0
Processing 2.21
Németh Bálint
****************/

int N=15;
int side=25;
int menu,temp;
boolean start=false,end=true;
boolean mines[][];
boolean exposed[][];
boolean select[][];

int step = 0;
int mines_ammount=35;
int flag_ammount;
PImage img_f,img_b_1,img_b_2,img_field;

float ver= 0.9;

void reset(){
  setup();
}
void setup(){
  clear();
  flag_ammount=mines_ammount;
  img_field=loadImage("Images/field.png");
  img_b_1=loadImage("Images/bomb_1.png");
  img_b_2=loadImage("Images/bomb_2.png");
  img_f=loadImage("Images/flag.png");

   menu=N+side+20;
  size(N*side+1,N*side+menu+1);
  background(255);
  rect(0,0,N*side,menu);
  rect(0,menu,N*side,N*side);
  
  mines = new boolean[N][N];
  exposed = new boolean[N][N];
  select = new boolean[N][N];
  println("Setupped");
  palya(menu);
  println("Map was generate");
  flag_ammount=mines_ammount;
  
  println(temp);
  
  // println(temp);
  
}
void palya(int menu){
  for (int i=0; i<N; i++) for(int j=0; j<N; j++){
        imageMode(CENTER);
        image(img_field,i*side+side/2,j*side+side/2+menu,side,side);
    mines[i][j]=false;
    select[i][j]= false;
  exposed[i][j] = false;
  }
}
void mine(int i, int j){
  for(;mines_ammount!=0;){
  float x=random(0,N);
  float y=random(0,N);
  int f=int(x);
  int g=int(y);
  //println(i);
  //println(j);
  if(mines[f][g]==false){
    println("loop");
  mines[f][g]=true;
     mines_ammount--;
   println(mines_ammount);
    if(mines[i][j]){
      mines[i][j]=false;
      mines_ammount++;
      continue;
    }
  
  }
  }
}

void mousePressed () {
  println("Mouse pressed");
    int i = mouseX/side;
    int j =(mouseY-menu)/side;
    println("x=",i);
    println("y=",j);
    println("--------");
  if(end){
  if(j<=N-1){
  if(start==false){
    start=true;
    mine(i,j);
    println("Bombs have been set.");
  }
    
    //for (int l=0; l<N; l++) for(int k=0; k<N; k++){number(l,k);}

    if(mouseButton == LEFT && select[i][j]==false){
    step++;
    exposed[i][j] = true;
    //fill(170);
    //rect(i*side,j*side,side,side);
    
    if (mines[i][j]) {
        println("Vesztettél");
        imageMode(CENTER);
        image(img_b_2,i*side+side/2,j*side+side/2+menu,side,side);
        end=false;
        
      
    }
    else {number(i,j);}
    if (done()) { 
    println("Nyertél");
    end=false; }
    }
    else if(mouseButton == RIGHT){
      if(exposed[i][j]==false){
        step++;
      if(select[i][j]==false && flag_ammount!=0 ){
      select[i][j]=true;
      flag_ammount--;
      imageMode(CENTER);
      image(img_f,i*side+side/2,j*side+side/2+menu,side,side);
      println(select[i][j]);

    if(mines[i][j]){println("Jó tipp");mines_ammount--;println(mines_ammount);}
    else{println("EZ félre ment");}
      }
      else if(select[i][j]==true){
           select[i][j]=false;
       if(mines[i][j]){mines_ammount++;}
           flag_ammount++;
           println(select[i][j]);
           imageMode(CENTER);
           image(img_field,i*side+side/2,j*side+side/2+menu,side,side);
         }
      }
    }
  }
}
}
boolean done() {
  for (int i=0; i < N; i++) for (int j=0; j < N; j++) {
    if (exposed[i][j] == false && mines[i][j] == false) return(false);
  }
  return(true);
}
int neighbor(int i, int j) {
  int t=0;
  for (int ii=i-1; ii <= i+1; ii++) {
    if (ii < 0 || ii >= N) continue;
    for (int jj = j-1; jj <= j+1; jj++) {
      if (jj < 0 || jj >= N) continue;
      if (mines[ii][jj]) t++;
    }
  }
  return(t);
}
void number(int i, int j) {
  if(mines[i][j]){
    backgroundcell(i,j);
    imageMode(CENTER);
    image(img_b_1,i*side+side/2,j*side+side/2+menu,side,side);}
  else{
  int n;
  char c[] = new char[1];
  n = neighbor(i,j);
  c[0] = char('0' + n);
  println(c[0]);
  backgroundcell(i,j);
  switch(c[0]){
    case '0' : /*value[i][j]=0;*/fill(200);break;
    case '1' : /*value[i][j]=1;*/fill(55,23,255);break;
    case '2' : /*value[i][j]=2;*/fill(74,234,58);break;
    case '3' : /*value[i][j]=3;*/fill(252,0,0);break;
    case '4' : /*value[i][j]=4;*/fill(0,10,127);break;
    case '5' : /*value[i][j]=5;*/fill(127,51,51);break;
    case '6' : /*value[i][j]=6;*/fill(245,181,181);break;
    case '7' : /*value[i][j]=7;*/fill(248,255,60);break;
    case '8' : /*value[i][j]=8;*/fill(126,253,255);break;
    default : println("Hát eez nem jó ha lefut");break;}
  
  if(c[0]>0){
    textSize(21);
    textAlign(CENTER,CENTER);
    text(new String(c),i*side+side/2,j*side+side/2+menu);
  }
  }
}
void backgroundcell(int i, int j){
  fill(200);
    stroke(150);
    rect(i*side-1,j*side+menu-1,side,side);
}

void draw(){}
