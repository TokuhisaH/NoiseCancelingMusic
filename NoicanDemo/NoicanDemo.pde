import ddf.minim.*;
import controlP5.*;

ControlP5 cp5;

Minim minim;
AudioPlayer[] noises = new AudioPlayer[7];
AudioPlayer[] musics = new AudioPlayer[7];

int playingNoiseID = 0;
int playingMusicID = 0;

void setup() {
  size(920, 400);

  cp5 = new ControlP5(this);

  RadioButton r = cp5.addRadioButton("Noise")
    .setPosition(20, 60)
    .setSize(80, 80)
    .setColorForeground(color(0, 153, 255))
    .setColorActive(color(255, 153, 0))
    .setColorLabel(color(255))
    .setItemsPerRow(7)
    .setSpacingColumn(50)
    .addItem("noise mute", 0)
    .addItem("noise1", 1)
    .addItem("noise2", 2)
    .addItem("noise3", 3)
    .addItem("noise4", 4)
    .addItem("noise5", 5)
    .addItem("noise6", 6);
 
  RadioButton r2 = cp5.addRadioButton("Music")
    .setPosition(20, 260)
    .setSize(80, 80)
    .setColorForeground(color(0, 153, 255))
    .setColorActive(color(255, 153, 0))
    .setColorLabel(color(255))
    .setItemsPerRow(7)
    .setSpacingColumn(50)
    .addItem("music mute", 0)
    .addItem("music1", 1)
    .addItem("music2", 2)
    .addItem("music3", 3)
    .addItem("music4", 4)
    .addItem("music5", 5)
    .addItem("music6", 6);

  minim = new Minim(this);
  for (int i=0; i<noises.length; i++) {
    noises[i] = minim.loadFile("noise"+i+".mp3");
    musics[i] = minim.loadFile("music"+i+".mp3");
  }
}



void controlEvent(ControlEvent theEvent) {
  
  for(int i=0; i<noises.length; i++){
    boolean isPressed = cp5.get(RadioButton.class, "Noise").getState(i);
    if(isPressed & i != playingNoiseID){
      noises[playingNoiseID].pause();
      noises[playingNoiseID].rewind();
      noises[i].play();
      
      playingNoiseID = i;
      break;
    }
  }
  
  
  for(int i=0; i<noises.length; i++){
    boolean isPressed = cp5.get(RadioButton.class, "Music").getState(i);
    if(isPressed & i != playingMusicID){
      musics[playingMusicID].pause();
      musics[playingMusicID].rewind();
      musics[i].play();
      
      playingMusicID = i;
      break;
    }
  }
}

void draw() {
  background(153);
}
