/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Németh Bálint - processing háziszerűség
Utolsó módosítás: 2019. 03. 31.
A program készült: Processing 3.5.3
Programról: 
  Üres területen: bal egérgomb létrehoz egy új négyzet objektumot, jobb egérgomb kitörli az összes létrehozott objektumot.
  Objektumba kattintva: bal gomb mozgathatóvá teszi, és az egeret követi, jobb klikk véglegesen átszínezi.
  Gombok: 'DELET' gomb vglegesen törli a legutoljára létrehozott objektumot, 'a/A' gomb bal klikkel ideiglenes átszínezi az objectumot (az 'aktív' objektum ez alatt is mozgatható)
  +"Végtelen" létrehozható négyzet
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


int[] random_color = new int[3]; //szín tárolás
Rect myRect;
ArrayList<Rect> Rects = new ArrayList<Rect>(); //objektumok
int i,j,m,n; //pozíció és egybéb globlis ciklus változók
boolean atfedes_bool, hmove=false; //egér kattintás és objektum mozás helyére
int total; //össz objektum szám
//float atfed_x,atfed_y; //ha ötközik az objectum letételi helye egy másikéval
boolean active = false; //actív állapotba kell-e tennni az objectumot
boolean new_obj = false; //indexelési javító


public class Rect {
  float x; //obj helye
  float y;
  int r,g,b; //obj aktuális színe
  int r_temp,g_temp,b_temp; //obj alapszíne
  
  
  Rect(float tempXpos, float tempYpos, int tempr,int tempg, int tempb){
    x = tempXpos;
    y = tempYpos;
    r = tempr;
    g = tempg;
    b = tempb;
    }
  void display() { //megjelenítés
    rectMode(CENTER);
    fill(r,g,b);
    rect(x,y,50,50,5);
    
}
  void atfedes(){ //átfedés ellenörzés
    println(x+" || "+i);
    println(y+" || "+j);
    if(x<=i+25 && x>=i-25 && y<=j+25 && y>=j-25){
      //atfed_x = x;
      //atfed_y = y;
      n=m; //hogy tudja a program, melyik objektummal kell foglalkozni(egérrel ki lett jelölve)
      m=1; //cikluból való mindenkori kiléptető érték
      atfedes_bool = true; 
      println("Átfedés");
    }
  }
  void move(){ //obj egr követése
    x=mouseX;
    y=mouseY;
  }
  void active(){ //ideiglenes szín || eredeti mentse
    r_temp=r;
    g_temp=g;
    b_temp=b;
    r=random_color[0];
    g=random_color[1];
    b=random_color[2];
  }
  void deactive(){ //szín visszaállítása
    r= r_temp;
    g= g_temp;
    b= b_temp;
  }
}

void setup() { //base ablak
    clear();
    size(600, 600);
    background(255);
}

void mousePressed() {
    new_obj = false;
    hmove = false;
    atfedes_bool = false; 
    println("Mouse pressed");
    i = mouseX; //egr helye
    j = mouseY;
    total = Rects.size();
    println(total);
    if(total > 0){
      for(m = total; m!=0; m--){ //ha már van obj, ellenőrzi, hogy az új obj nem ütközik-e másikkal
          Rect position = Rects.get(m-1);
          position.atfedes();
      }
    }
    if (mouseButton == RIGHT && atfedes_bool==false){ //minden törlése
      for(int i = total; i!=0; i--){
        Rects.remove(i-1);
      }
      clear();
      background(255);
    }
    if (mouseButton == RIGHT && atfedes_bool==true){ //végleges átszínezés (meglévő obj adatok átírásával)
      new_obj = true;
      //Rects.remove(n-1);
      random_color();
      //Rects.add(new Rect(atfed_x,atfed_y,random_color[0],random_color[1],random_color[2]));
      Rect activation = Rects.get(n-1);
      activation.active();
      
    }
    if (mouseButton == LEFT && atfedes_bool==false){ // új objetumkszítés
          println("Bal");
          random_color();
          Rects.add(new Rect(i,j,random_color[0],random_color[1],random_color[2]));
        }
    if (mouseButton == LEFT && atfedes_bool==true){ //obj mozgatás/aktivlás
      new_obj = true;
      hmove = true;
          if(keyPressed){
            if(key == 'a' || key == 'A'){
                active=true;
                random_color();
                Rect activation = Rects.get(n-1);
                activation.active();
            } 
            /*if(key == DELETE) {
                 //Rects.remove(n-1);
              }*/
            }
          
          
      }
    
}
void mouseReleased(){ //obj deaktiválsa
  if(active){
    active = false;
    Rect deactivation = Rects.get(n-1);
    deactivation.deactive();
  }
       
  
}
void keyPressed(){ //utolsó obj törlése
  if(key == DELETE && total>=0){
    if(!new_obj){
      Rects.remove(total);
      total = Rects.size()-1;
    }
    else{
      new_obj = false;
      Rects.remove(total-1); //arrayList-beni lyuk kikerülése
      total = Rects.size()-1;
    }
  }
}
void mouseDragged(){ //obj mozgatása, ha az obj gomb kattintás alatt van
  if(hmove){
    Rect moving = Rects.get(n-1);
    moving.move();
    
  /*if(mousePressed == false){
    hmove=false;
    
  }*/
    
  }
}
   
void random_color() { // szín készítés
    for (int i=0; i<3; i++) {
      random_color[i]=(int)random(0, 255);
      println(random_color[i]);
    }
}

void draw(){ //folyamatos rajzolás (fps nincs lockolva)
  background(255);
  for (int i = 0; i < Rects.size(); i++) {
  Rect part = Rects.get(i);
  part.display();
  }
}
