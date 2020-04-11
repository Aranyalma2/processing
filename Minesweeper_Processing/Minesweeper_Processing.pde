/****************
Aknakereső 1.0
Processing 2.21
Németh Bálint
****************/

int N=15; //Pálya terület root2
int side=25; //mező méret
int menu,temp;  

int k=0; //x kezd
int l=0; //y kezd
int f=0; // x veg
int g=0; //y veg

int numbers[][];
boolean start=false,end=false;
boolean mines[][];
boolean exposed[][];
boolean select[][];

int step = 0;
int mines_ammount=20;
int flag_ammount;
PImage img_f,img_b_1,img_b_2,img_field,img_notMine;

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
  img_notMine=loadImage("Images/notMine.png");
//Pálya készítése
  //menü méret
  menu=N+side+20;
  size(N*side+1,N*side+menu+1);
  background(255);
  rect(0,0,N*side,menu);
  rect(0,menu,N*side,N*side);
  
  mines = new boolean[N][N];
  exposed = new boolean[N][N];
  select = new boolean[N][N];
  numbers = new int[N][N];
  println("Setupped");
  palya(menu); //Pálya kszítése
  println("Map was generate");
  flag_ammount=mines_ammount;
  
  
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
  if(!end){
  if(j<=N-1 && j>=0){
  if(start==false){
    //első lefutás/ akna elhelyezs
    start=true;
    mine(i,j);
    println("Bombs have been set.");
  }
    
    //for (int l=0; l<N; l++) for(int k=0; k<N; k++){number(l,k);}

    if(mouseButton == LEFT && select[i][j]==false){ //bal kattintás
    step++;
  if(exposed[i][j]){allFlag(i,j);}//auto feloldás 2. kattra
  else{exposed[i][j] = true;}
    //fill(170);
    //rect(i*side,j*side,side,side);
    number(i,j);
    if (done()) { 
    println("Nyertél");
    end=true; }
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
  println(i);
  println(j);
  if(mines[i][j]){
    showAll();
    backgroundcell(i,j);
    imageMode(CENTER);
    image(img_b_2,i*side+side/2,j*side+side/2+menu+1,side,side);
    println("Vesztettél");
    end=true;
  
  }
  else{
  int n;
  char c[] = new char[1];
  n = neighbor(i,j);
  numbers[i][j]=n;
  c[0] = char('0' + n);
  println(c[0]);
  backgroundcell(i,j);
  switch(c[0]){
    case '0' : /*value[i][j]=0;*/if(!end){calsZeros(i,j);}fill(200);break;
    case '1' : /*value[i][j]=1;*/fill(55,23,255);break;
    case '2' : /*value[i][j]=2;*/fill(74,234,58);break;
    case '3' : /*value[i][j]=3;*/fill(252,0,0);break;
    case '4' : /*value[i][j]=4;*/fill(0,10,127);break;
    case '5' : /*value[i][j]=5;*/fill(127,51,51);break;
    case '6' : /*value[i][j]=6;*/fill(245,181,181);break;
    case '7' : /*value[i][j]=7;*/fill(248,255,60);break;
    case '8' : /*value[i][j]=8;*/fill(126,253,255);break;
    default : println("Hát eez nem jó ha lefut");break;}
  
    textSize(21);
    textAlign(CENTER,CENTER);
    text(new String(c),i*side+side/2,j*side+side/2+menu);
  

  }
}
void backgroundcell(int i, int j){
  fill(200);
    stroke(150);
    rect(i*side-1,j*side+menu-1,side,side);
}
void calsZeros(int i, int j)
{  


  if(i>0 && mines[i-1][j]==false && select[i-1][j]==false && exposed[i-1][j]==false){
    exposed[i-1][j]=true;
    number(i-1, j);
    
  }
  if(i<N-1 && mines[i+1][j]==false && select[i+1][j]==false && exposed[i+1][j]==false &&!end){
    exposed[i+1][j]=true;
    number(i+1, j);
    
  }
  if(j>0 && mines[i][j-1]==false && select[i][j-1]==false && exposed[i][j-1]==false &&!end){
    exposed[i][j-1]=true;
    number(i, j-1);
    
  }
  if(j<N-1 && mines[i][j+1]==false && select[i][j+1]==false && exposed[i][j+1]==false &&!end){
    exposed[i][j+1]=true;
    number(i, j+1);
    
  }
  if(i>0 &&j>0 && mines[i-1][j-1]==false && select[i-1][j-1]==false && exposed[i-1][j-1]==false &&!end){
    exposed[i-1][j-1]=true;
    number(i-1, j-1);
    
  }
  if(i<N-1 && j<N-1 && mines[i+1][j+1]==false && select[i+1][j+1]==false && exposed[i+1][j+1]==false &&!end){
    exposed[i+1][j+1]=true;
    number(i+1, j+1);
    
  }
  if(i>0 && j<N-1 && mines[i-1][j+1]==false && select[i-1][j+1]==false && exposed[i-1][j+1]==false &&!end){
    exposed[i-1][j+1]=true;
    number(i-1, j+1);
    
  }
  if(i<N-1 && j>0 && mines[i+1][j-1]==false && select[i+1][j-1]==false && exposed[i+1][j-1]==false &&!end){
    exposed[i+1][j-1]=true;
    number(i+1, j-1);
    
  }

}
void allFlag(int i, int j)
{
if(!end){
  temp=0;
if(i>0 && j>0 && i<N-1 && j<N-1){
  for(int k=i-1;k<=i+1;k++) for(int l=j-1;l<=j+1;l++){
    if(select[k][l]){temp++;}}
}
println(temp);
println(numbers[i][j]);
if(temp>=numbers[i][j]){


  if(i>0 && !select[i-1][j] &&!end){
    exposed[i-1][j]=true;
    number(i-1, j);
    
  }
  if(i<N-1 && !select[i+1][j] &&!end){
    exposed[i+1][j]=true;
    number(i+1, j);
    
  }
  if(j>0 && !select[i][j-1] &&!end){
    exposed[i][j-1]=true;
    number(i, j-1);
    
  }
  if(j<N-1 && !select[i][j+1] &&!end){
    exposed[i][j+1]=true;
    number(i, j+1);
    
  }
  if(i>0 &&j>0 && !select[i-1][j-1] &&!end){
    exposed[i-1][j-1]=true;
    number(i-1, j-1);
    
  }
  if(i<N-1 && j<N-1 && !select[i+1][j+1] &&!end){
    exposed[i+1][j+1]=true;
    number(i+1, j+1);
    
  }
  if(i>0 && j<N-1 && !select[i-1][j+1] &&!end){
    exposed[i-1][j+1]=true;
    number(i-1, j+1);
    
  }
  if(i<N-1 && j>0 && !select[i+1][j-1] &&!end){
    exposed[i+1][j-1]=true;
    number(i+1, j-1);
    
  }
}
  println("--");
  int k=-1; //x kezd
  int l=-1; //y kezd
  int f=1; // x veg
  int g=1; //y veg
  int m;
  
if(i==0){
  k=0;
  f=1;}

if(j==0){
  l=0;
  g=1;}
  
if(i==N-1){
  f=0;
  k=-1;}
  
if(j==N-1){
  g=0;
  l=-1;}
  
  println("k="+k);
  println("l="+l);
  println("f="+f);
  println("g="+g);
 println("--");
 ###########################
for(;k<f;k++){ for(m=l;m<g;m++){
  println("k="+k);
  println("m="+m);
  if(!select[i+k][j+m]){
  exposed[i+k][j+m]=true;
  number(i+k,j+m);
}
}
}
}

}
void showAll(){
  for (int f=0; f < N; f++) for (int g=0; g < N; g++){
    if(mines[f][g]){
      backgroundcell(f,g);
      imageMode(CENTER);
      image(img_b_1,f*side+side/2,g*side+side/2+menu+1,side,side);}
    else{number(f,g);}
    if(select[f][g]){
    if(mines[f][g]){
      imageMode(CENTER);
      image(img_f,f*side+side/2,g*side+side/2+menu,side,side);
    }
    else{
      imageMode(CENTER);
      image(img_notMine,f*side+side/2,g*side+side/2+menu,side,side);
    }
  }
  }
}
void draw(){}
