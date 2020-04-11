import hypermedia.net.*;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Lock;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
//import processing.net.*;
UDP receiver;
UDP sender;
int playernum = 0;
JSONObject json;
//Set<String> myIps;
StringList allplayer;
JSONObject map;
JSONObject incomingDataObject;
JSONObject newIncomingDataObject;
JSONObject sendingDataObject;
int players=0;
String nextPlayer = "192";
String name;
boolean[][] array = new boolean[10][10];
Map<String, colour> coordsMap;
Map<String, players> myIps;
int[] random_color = new int[3];
int x=0, y=0;

void setup() {
  map = new JSONObject();
  receiver= new UDP( this, 25569 );
  receiver.listen(true);
  json = new JSONObject();
  myIps = new HashMap<String, players>();
  coordsMap = new HashMap<String, colour>();
  allplayer = new StringList();
}

void draw() {
}

void receive( byte[] data, String ip, int port) {
  
  println("A");
  int total = allplayer.size();
  if (!myIps.containsKey(ip)) {
    //println(data);
    println("B");
    allplayer.append (ip);
    String newincomingData = new String (data);
    newIncomingDataObject= parseJSONObject(newincomingData);
    println(newIncomingDataObject);
    String name = newIncomingDataObject.getString("name");
    //println(name);
    //x = newIncomingDataObject.getInt("X");
    //y = newIncomingDataObject.getInt("Y");
    myIps.put(ip, new players(name, random_color()));
    println(random_color());
  }
  println(ip);
  println(allplayer.get(playernum));
  println(total);
  println(playernum);
  if (ip == allplayer.get(playernum)) {
    println("C");
    playernum++;
    if(playernum == total+1){playernum=0;}
    String incomingData = new String (data);
    incomingDataObject = parseJSONObject(incomingData);
    //String name = json.getString("name");
    x = incomingDataObject.getInt("X");
    y = incomingDataObject.getInt("Y");
  }
  sendingDataObject = new JSONObject();
  sendingDataObject.setInt("color", myIps.get(ip).c).setInt("X", x).setInt("Y", y);
  //sendingDataObject.setInt("X",x);
  //sendingDataObject.setInt("Y",y);
  String outdata=sendingDataObject.toString();
  //println("ssa");
  for (Map.Entry<String, players> place : myIps.entrySet()) {
    receiver.send(outdata, place.getKey(), 25568);
    println(outdata);
  }

  win(x, y, myIps.get(ip).c);




  //String message = new String( data );
  //Map<String, positions>   =   new HashMap<String, positions>();
  //println(message);
  //json = parseJSONObject(message);
  //println(json);
}
void win(int i, int j, color c) {
  for (int k= -4; k<=4; k++) for (int l = -4; l<=4; l++) {
    array[k+4][l+4] = checkElement(i+k, j+l) && (checkElementColor(i+k, j+l) == c);
  }
}
class players {
  String name;
  color c;
  players(String name_, color c_) {
    name=name_;
    c = c_;
  }
}
class colour {
  color rgb;
  colour(color rgb_) {
    rgb = rgb_;
  }
}
color checkElementColor(int x_, int y_) {
  String strX = str(x_);
  String strY = str(y_);
  String coord = strX + "," + strY;

  color szin = coordsMap.get(coord).rgb;
  return szin;
}
boolean checkElement(int x_, int y_) {
  String strX = str(x_);
  String strY = str(y_);
  String coord = strX + "," + strY;

  boolean eredmeny = coordsMap.containsKey(coord);
  return eredmeny;
}

void newElement(int x_, int y_, color colour_) {
  String strX = str(x_);
  String strY = str(y_);
  String coord = strX + "," + strY;

  coordsMap.put(coord, new colour(colour_));
}
color random_color() { // szín készítés
  for (int i=0; i<3; i++) {
    random_color[i]=(int)random(0, 255);
  }
  color newC = color(random_color[0],random_color[1],random_color[2]);
  //for(int i = 0; i<1;){}
  return newC;
  
}
