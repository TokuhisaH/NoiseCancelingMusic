import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import controlP5.*;
import ddf.minim.*;

int progress = 0;
int PROG_MAX = 90;
int CORRECTION = 33;
boolean isStarted = false;
PFont pfont;

ControlP5 cp5;
Minim minim;
AudioPlayer music, noise;
AudioSnippet count;
boolean isTurnOfMusic = true;
boolean musicIsPlayingBefore = false;

String[] rows;
int[][] IDpears = new int[PROG_MAX][2];
PrintWriter writer;


void setup(){  
  size(800, 400);
  
  addUI();
  minim = new Minim(this);
  //count = minim.loadSnippet("chime06.mp3");
  //count = minim.loadSnippet("onepoint15.mp3");
  count = minim.loadSnippet("system35.mp3");

  count.setGain(-23);
  
  textFont(pfont);
  textSize(40);
}


void draw(){
  validateMusicIsFinished();

  background(204);
  fill(0);
  
  if( isStarted ){
    text((progress+1) +"/"+ PROG_MAX, 100, 350);

 
  }
  
   
  
  if(music != null && music.isPlaying()){

    text("Playing Music...", 250, 350);
  }
}


void loadMP3(){
  
  music = minim.loadFile("music"+ IDpears[progress][0] +".wav");
  noise = minim.loadFile("noise"+ IDpears[progress][1] +".wav");
  music.setGain(-13);

  noise.setGain(-13);
  println("第"+ (progress+1) +"試行のwavペアをロード");
  println("music"+ IDpears[progress][0] +" noise"+IDpears[progress][1]);
  isTurnOfMusic = true;
}


void validateMusicIsFinished(){
  if( music == null ) return;
  if( musicIsPlayingBefore && !music.isPlaying() ){
    println("再生が終了しました");
    isTurnOfMusic = false;
              noise.pause();
              delay(1000);
          for(int i = 0; i < 2; i ++){
            
          count.rewind();
          count.play();
          delay(1000);
        }
        noise.play();
  }
  musicIsPlayingBefore = music.isPlaying();
}
