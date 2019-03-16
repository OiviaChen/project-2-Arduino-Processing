//import deadpixel.keystone.*;
import processing.video.*;
import processing.serial.*;

//Keystone ks;
Serial myPort;
int val;
Movie train,hill,sun;
boolean isPlaying = false;
int val2;
color maskColor = color(0);
float maskBrightness =48;
boolean testMode;
final int numElectrodes = 12;
String[] splitString;
int[] status,lastStatus;
int val1;

void updateArraySerial(int[] array) {
  if (array == null) {
    return;
  }

  for(int i = 0; i < min(array.length, splitString.length - 1); i++){
    try {
      array[i] = Integer.parseInt(trim(splitString[i + 1]));
    } catch (NumberFormatException e) {
      array[i] = 0;
    }
  }
}

void setup(){
  size(1728,1220);
  //ks = new Keystone(this);
  status = new int[numElectrodes];
  lastStatus = new int[numElectrodes];
  
  hill= new Movie(this,"hill.mov");
  train= new Movie(this,"train.mov");
  sun= new Movie(this,"sun.mov");
  
  //myMovie.loop();
  hill.pause();
  sun.pause();
  train.pause();
  myPort = new Serial(this, Serial.list()[1],57600);
  myPort.bufferUntil('\n');
}

void movieEvent(Movie m){
 m.read(); 
}
void draw(){
  image(hill,0,0,width,height);
    image(sun,0,0,width,height);
      image(train,0,0,width,height);
  if ( myPort.available() > 0) {
    //val = myPort.readStringUntil('f');  
    val = myPort.read();
    //val1 = int(val);
    // read it and store it in val
  } 
  switch(val){
    case 49:
      hill.stop();
      hill.play();
      break;
    case 50:
      sun.stop();
      sun.play();
      break;
    case 51:
      train.stop();
      train.play();
      break;
    default:
      println("none entered");
      break;
  }

 println(val); 
}

boolean testPixel(int pixel){
  if(testMode){ // exact match only
    return pixel!=maskColor;
  }
  return brightness(pixel) > maskBrightness; // loose match
}