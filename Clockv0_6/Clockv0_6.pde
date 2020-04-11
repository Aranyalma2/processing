int ArectX = 30;
int ABrectY = 30;    //harommal oszthato kell legyen!!!
int Aspace = 10;
int Bspace = 10;
int ABshape = 7;

int AXCoords[][] = {{0,0},{0,0},{0,0},{0,0},{0,0}};
int ABYCoords[] = {0,0};
int BXCoords[] = {0,0};

int trashX = 35;
int trashY = 35;


int selectedItem = 0;
int red = 255;
int green = 255;
int blue = 255;
int S = 0;
int G = 0;


void setup()
{
  size(700,500);
  background(255);
  
  //calculating rects Coords
  
  //Y
  ABYCoords[0] = trashY;
  ABYCoords[1] = trashY + ABrectY;
  
  int first = 0;
  int second = 0;
  
  //AX
  for(int j = 0; j < 9; j++){
    
    AXCoords[first][second] = trashX;
    if(j%2 == 0){
      trashX = trashX + ArectX;
    }else{
      trashX = trashX + Aspace;
    }
    
    if(j%2 == 1){
      second = 0;
      first++;
    } else{
      second = 1;
    }
  }
  
  //BX
  trashX = trashX + Bspace;
  for(int j = 0; j < 1; j++){BXCoords[j] = trashX; trashX = trashX + 4*Bspace + 3*ArectX;}
  
}


boolean mouseMenu(int minX, int maxX, int minY, int maxY)
{
  boolean Mc = mousePressed == true;
  boolean MouseMenuResult = mouseX > minX && mouseX < maxX && mouseY > minY && mouseY < maxY && Mc;
  return MouseMenuResult;
}


void backgroundMenuRGB(int xCoord,int yCoord){
  S = xCoord; 
  G = yCoord;
  for(int j = 0; j < 3; j++){
     /*S = S + 5;
     triangle(S,G+10,S+30,G+10,S+15,G+3);
     rect();
     triangle();//////////////////////////////////////////////////////////////////
     S =*/ 
  }
}

void backgroundMenu()
{ 
  clear();
  //int selectedItem = 0;
  color[] colors = {#00ffdc,#009984,#00d4b7,#32ff8a,#94ffff};
  
  if(selectedItem == 5){
    background(red,green,blue);
  } else{
    background(colors[selectedItem]);
  }
  
  for(int i = 0; i < 5; i++)
  {
    strokeWeight(1);
    if(i == selectedItem){
      strokeWeight(2);
      stroke(#000000);
    }
    
    switch(i){
      case 0:
        fill(colors[0]);
        break;
      case 1:
        fill(colors[1]);
        break;
      case 2:
        fill(colors[2]);
        break;
      case 3:
        fill(colors[3]);
        break;
      case 4:
        fill(colors[4]);
        break;
      case 5:
        noFill();
    }
    
    if(i == 5){
      backgroundMenuRGB(235,35);
      rect(AXCoords[0][0],ABYCoords[0],BXCoords[1]-BXCoords[0],ArectX,ABshape);
    } else{
      rect(AXCoords[i][0],ABYCoords[0],ArectX,ABrectY,ABshape);
    }
  }
  if(mouseMenu(35,65,35,65)){
    selectedItem = 0; 
  } else if(mouseMenu(75,105,35,65)){
    selectedItem = 1;
  } else if(mouseMenu(115,145,35,65)){
    selectedItem = 2; 
  } else if(mouseMenu(155,185,35,65)){
    selectedItem = 3;
  } else if(mouseMenu(195,225,35,65)){
    selectedItem = 4; 
  } else if(mouseMenu(235,345,35,65)){
    selectedItem = 5; 
  }
}

void draw(){
  
  
  backgroundMenu(); 
}
