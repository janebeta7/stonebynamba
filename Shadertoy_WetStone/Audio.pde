import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

String audioFilePath = "11_Rueda_de_presos.mp3";
Boolean isPlayAudio = false;
Minim minim;
AudioPlayer player;
void setupAudio() {
  Minim minim = new Minim(this);

  int fftSize = 1024;
  player = minim.loadFile(audioFilePath);
  println("player:"+player);
}
void infoAudio() {
  if ( isPlayAudio) println("position:"+player.position()+" - lenght:"+player.length());
}
void playAudio() {
  player.rewind();
  isPlayAudio = true;
  player.play();
}
void play(int millis) {
  player.play(millis);
}


void stopAudio() {
  isPlayAudio = false;
  player.pause();
}
