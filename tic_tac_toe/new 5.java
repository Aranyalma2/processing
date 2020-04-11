/*
Client connected -> it get an ID
Client want to disconnect -> it has to send 'exit' to 'msg' part of JSONObject
SO The 'msg' part will contain the type of JSONObject

CLIENT'S 'MSG'
-------------------------------------------------------------------------
--> exit : disconnect <delete user id>  (id)                        || the client will get a String 'dc' msg
--> move : normal new step (id; posX; posY;)                
--> pause : a player wanna get a break <if the player still has 'pause point'
--> abandon : give up but still store the ID
--> joining : client send all back groung info about player (id; name; mode)
-------------------------------------------------------------------------

SERVER'S 'MSG'
-------------------------------------------------------------------------
--> move : new step (id; posX; posY; nextPlayerID)
--> joining : contains all players (id; color; name;)
--> pause : freeze the game for 30 sec <or unlimited time>
--> skip : if last player did not take a new object, skip him from this turn
--> finished : contains the winner (id)
*/


import hypermedia.net.*;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Lock;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.HashSet;
import processing.net.*;

//--------------COLOR-----------------

color c1 = #FF0000;
color c2 = #00FF00;
color c3 = #0000FF;
color c4 = #FFFF00;
color c5 = #FF00FF;
color c6 = #00FFFF;
color c7 = #7F00FF;
color c8 = #FF8000;
color[] colours = {
  c1, c2, c3, c4, c5, c6, c7, c8 //color array
                      };
//-------------CLASS--------------
class Players {         //Player object, contains name, choosen gamemode, generated color
  String name;
  String mode;
  color colorP;
  
  Players(String name_, String mode_, color colorP_){    //constructor
    name = name_;
    mode = mode_;
    colorP = colorP_;
  }
  
}

//-----------OTHERS-------------

Server myServer;
JSONObject incoming; //contaning income data
int PORT = 36420; // server port
Set<String> allID = new TreeSet<String>(); //all id what connected
Map<String,Players> playersPROP = new HashMap<String, Players>(); //all players data


//-----------VOIDs---------------
void setup(){
      myServer = new Server(this, PORT); //create new server object
      incoming = new JSONObject(); //new JSONObj to income
}

void draw() {
  
  Client thisClient;   //TCP CLIENT definition
  thisClient = myServer.available();    //get last unread message
   while(thisClient!=null){           //if has new unread msg
    String message=thisClient.readString();   //read it out
  JSONObject incomig = parseJSONObject(message);     //convert it to JSONObject
  String jsonMSG = incoming.getString("msg");
  if(jsonMSG.equals("move")){
    //if the user took his move
    
  }
  else if(jsonMSG.equals("joining")){
    //if the client send all information about the user
    
  //JSONObject's part
  String ID = incoming.getString("id");
  String name = incoming.getString("name");
  String mode = incoming.getString("mode");
  color newColor = colours[randomColor()];
  playersPROP.put(ID,new Players(name,mode,newColor));
  }
  else if(jsonMSG.equals("pause")){
    //user wanna a break
    
  }
  else if(jsonMSG.equals("abandon")){
    //give up with no ID delete
    
  }
  
  else if(jsonMSG.equals("exit")){
    //if the user close the client and delete his ID
    
    thisClient.write("You will be disconnected now.rn");
    println(thisClient.ip() + "t has been disconnected");
    myServer.disconnect(thisClient);  //disconnect client from the tcp com protocol
    allID.remove(incoming.getString("id"));  //remove disconnected user's id
  }
    
    
    thisClient = myServer.available();
  }
}

void serverEvent(Server someServer, Client someClient){  //run if new client is connected
  println("connection: "+ someClient.ip());
  String clientID;
  for(int i = 0; i < allID.size()+1; i++){  //add new user id the the SET table
      if(!allID.contains(Integer.toString(i))){
        clientID = Integer.toString(i);
        someClient.write(Integer.toString(i));
        allID.add(clientID);
      }
  }
}

//-------------RETURNS----------------

int randomColor(){
  boolean choosen = false;
  int colorID = -1; 
  while(!choosen){
    colorID = int(random(0,colours.length-1));
    for(Map.Entry<String,Players> elem : playersPROP.entrySet()){
      if(colours[colorID] == elem.getValue().colorP){
        choosen = false;
        break;
      }
      else{
        choosen = true;
      }  
    }  
  }
  if(colorID == -1){
    println("Colour initializing error");
    exit();
  }
  return colorID;
  
}