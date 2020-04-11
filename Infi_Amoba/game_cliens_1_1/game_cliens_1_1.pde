import hypermedia.net.*;
import java.util.Map;
import java.util.Set;
String serverIp = "localhost";
//Do myDo;
//ArrayList<Do> Dos = new ArrayList<Do>();
JSONObject incomingDataObject;
float mousex=0, mousey=0;
float mousex_=0, mousey_=0;
int[] coord = new int [2];
String playerName = "Balint";
Map<String, colour> coordsMap;
JSONObject firstSendingDataObject; 

UDP sender;
UDP resiver;

class colour{
  color rgb;
  colour(color rgb_){
    rgb = rgb_;
  }
}


void newElement(int x_, int y_, color colour_){   
      String strX = str(x_);
      String strY = str(y_);
      String coord = strX + "," + strY;
    
      coordsMap.put(coord, new colour(colour_));
}

color checkElementColor(int x_, int y_){
  String strX = str(x_);
  String strY = str(y_);
  String coord = strX + "," + strY;
  
  color szin = coordsMap.get(coord).rgb;
  return szin;
}

boolean checkElement(int x_, int y_){
   String strX = str(x_);
   String strY = str(y_);
   String coord = strX + "," + strY;
   
   boolean eredmeny = coordsMap.containsKey(coord);
   return eredmeny;
}


void drawElements(){
  for(int i = -1-int(mousex/25); i < 40-int(mousex/25); i++){
    for(int j = -1-int(mousey/25); j < 40-int(mousey/25); j++){
      if(checkElement(i,j)){
        rectMode(CORNER);
        fill(checkElementColor(i,j));
        rect(mousex + i*25,mousey + j*25,20,20,5);
        
    //rectMode(CENTER);
    //rect(mousex+12.5, mousey+12.5, 20, 20, 10);
      }
    }
  }
}

void setup() {
  size(1000, 1000);
  background(255);
  sender= new UDP( this, 25568 );
  /*firstSendingDataObject = new JSONObject();
   firstSendingDataObject.setString("name",playerName);
  String joinData=firstSendingDataObject.toString();
  sender.send(joinData,serverIp,25566);*/
  coordsMap = new HashMap<String, colour>();
}
void receive( byte[] data, String ip, int port) {
  //ip == serverIp
    println("asdfghjkl");
    incomingDataObject = new JSONObject();
    String incomingData = new String (data);
    incomingDataObject = parseJSONObject(incomingData);
    println(incomingDataObject);
    color playersColor = incomingDataObject.getInt("color");
    int getCoordX = incomingDataObject.getInt("X");
    int getCoordY = incomingDataObject.getInt("Y");
    println("wa"+ getCoordY);
    newElement(getCoordX,getCoordY,playersColor);
    //Dos.add(new Do(incomingDataObject.getInt("color"), incomingDataObject.getInt("X"), incomingDataObject.getInt("Y")));

}
void draw() {
  background(255);
   palya();
/*for (int i = 0; i < Dos.size(); i++) {
    
    Do part = Dos.get(i);
    part.display();
  }*/
  //rectMode(CENTER);
  drawElements();
 
}
void mouseDragged() {
  if (mouseButton == RIGHT) {
    mousex = mouseX-mousex_;
    mousey = mouseY-mousey_;
  }
}
void mousePressed() {
  if (mouseButton == RIGHT) {
    mousex_ = mouseX-mousex;
    mousey_ = mouseY-mousey;
    //println("------------------------");
    //println(mousex/25+" || "+mousey/25);
    //println((mouseX-mousex)/25+" || "+(mouseY-mousey)/25);
    //println("------------------------");
  }
  coord[0] = (int)Math.floor((mouseX-mousex)/25);
  coord[1] = (int)Math.floor((mouseY-mousey)/25);
  //println(coord[0]+" || "+coord[1]);
  
  if(mouseButton == LEFT){
   // Dos.add(new Do(color(222,212,43),(coord[0]*25)+mousex,(coord[1]*25)+mousey));
    JSONObject positionObject = new JSONObject();
     positionObject.setString("name",playerName).setInt("X",coord[0]).setInt("Y",coord[1]);
    // positionObject.setInt("X",coord[0]);
    // positionObject.setInt("Y",coord[1]);
     String data = positionObject.toString();
    // println(positionObject);
    // println(data);
     sender.send(data,serverIp,25569);
    
    
     //newElement(coord[0],coord[1],200);
    
  }
}

void palya() {
  for (int i=-5; i<45; i++) for (int j=-5; j<45; j++) {
    rectMode(CORNER);
    fill(255);
    rect(i*25+mousex%25, j*25+mousey%25, 25, 25);
    fill(120);
    rectMode(CENTER);
    rect(mousex+12.5, mousey+12.5, 20, 20, 10);
  }
}
