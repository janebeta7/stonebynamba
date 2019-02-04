/*---------------------------------teclado----------------------------------*/
import controlP5.*; //<>//

void keyPressed() {
  println("key"+key);
  // try {

  println(java.awt.event.KeyEvent.getKeyText(keyCode));
  String tecla = java.awt.event.KeyEvent.getKeyText(keyCode);
  println("tecla: "+tecla);

  if (key == CODED) {
    if (keyCode == UP) {
      displayY = displayY-100;
      surface.setLocation(displayX, displayY);
    } else if (keyCode == DOWN) {
      displayY = displayY+100;
      surface.setLocation(displayX, displayY);
    } else if (keyCode == LEFT) {
      displayX = displayX-100;
      surface.setLocation(displayX, displayY);
    } else if (keyCode == RIGHT) {
      displayX = displayX+100;
      surface.setLocation(displayX, displayY);
    }
  }
  if (keyPressed) {
    switch (key) {


    case 'n':

      stopAudio();
      break; 

    case 'p':
      // playAudio();
      println("play audio");
      playAudio();
      //play();

      break;
    }
  }
}
/* catch(Exception e) {
 
 println("***************EXCEPTION EVENTOS: "+e.toString()+"\n");
 }*/
