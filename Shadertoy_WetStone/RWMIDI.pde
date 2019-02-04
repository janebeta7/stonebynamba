/////////////////////////////////////////////
//----------------------CONTROL_1----------------
float KNOB_1 = 100;
float KNOB_12 = 100;
float FADER_1 =100;
float FADER_11 =100;
float FADER_12 =100;
float FADER_13 =100;
Boolean BT_11 = false;
Boolean BT_12 = false;
Boolean BT_13 = false;
//----------------------CONTROL_2---------------- 
float KNOB_2 = 100;
float FADER_2 =100; 
Boolean BT_21 = false;
Boolean BT_22 = false;
Boolean BT_23 = false;
Boolean isPosition= false;
Boolean isResize = false;
float ancho, alto=0;
//----------------------CONTROL_3----------------
float KNOB_3 = 100;
float FADER_3 =100; 
float FADER_31 =100;

Boolean BT_31 = false;
Boolean BT_32 = false;
Boolean BT_33 = false;
//----------------------CONTROL_4----------------
float KNOB_4 = 100;
float FADER_4 =10; 
float FADER_41=10;
Boolean BT_41 = false;
Boolean BT_42 = false;
Boolean BT_43 = false;
//----------------------CONTROL_5----------------
float KNOB_5 = 255;
float FADER_5 =25; 
float  FADER_51 = 10;
Boolean BT_51 = false;
Boolean BT_52 = false;
Boolean BT_53 = false;
//----------------------CONTROL_6----------------
float KNOB_6 = 100;
float FADER_6 =100; 
Boolean BT_61 = false;
Boolean BT_62 = false;
Boolean BT_63 = false;

//----------------------CONTROL_7----------------
float KNOB_7 = 400;
float FADER_7 = 150;
float FADER_71 = 100;



Boolean BT_71 = false;
Boolean BT_72 = false;
Boolean BT_73 = false;
//----------------------CONTROL_8----------------
float KNOB_8 = 10;
float FADER_8 =100; 
Boolean BT_81 = false;
Boolean BT_82 = false;
Boolean BT_83 = false;
//----------------------botones----------------
Boolean BT_91 = false;
Boolean BT_92 = false;
Boolean BT_93 = false;
Boolean BT_94 = false;
Boolean BT_95 = false;
Boolean BT_96 = false;
Boolean BT_97 = false;
Boolean BT_98 = false;
Boolean BT_99 = false;
Boolean BT_100 = false;
Boolean BT_101 = false;
// MIDI-related methods
import themidibus.*; //Import the library  
import javax.sound.midi.MidiMessage; //Import the MidiMessage classes http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/MidiMessage.html
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage; 
boolean isMidi = true;
Boolean  isMidiAvailable = false;
MidiBus midi_pad=null;
MidiBus midi_kontrol=null;
MidiBus midi_novation = null;
MidiBus midi_novation_out = null;
MidiBus midi_key=null;
String nano_0 = "PAD";
String nano_1 = "KEYBOARD";
//String nano_2 = "nanoKONTROL2";
//String novation = "Control";
String nano_2 = "nanoKONTROL2 1 SLIDER/KNOB";
String novation = "3- Launch Control";
//color bytes 
int byte_green = 0x3A;
int byte_red =  0x0B;
int byte_amber= 0x3F;
int byte_yellow= 0x3E;
String byte_on = "0x9";
String byte_off = "0x8";
int ACTIVECHANNEL = 0; //canal activo

int numChannels = 16;
int numButtons = 100;
int[] aButtonsMidiMapping = {  //notes
  9, 10, 11, 12, 25, 26, 27, 28, 114, 115, 116, 117
};

int numKnobs = 16;
int[] aKnobsMidiMapping = {  //controller
  21, 22, 23, 24, 25, 26, 27, 28, 41, 42, 43, 44, 45, 46, 47, 48
};
Boolean[][] aBT = new Boolean[numChannels][numButtons];
float[][] aKNOB = new float[numChannels][numButtons];



Boolean BT_0_114 = false; 
Boolean BT_0_115= false; 
Boolean BT_0_116= false; 
Boolean BT_0_117 = false;



int[] aKeyMaps = { 
  9, 10, 11, 12, 25, 26, 27, 28, 114, 115, 116, 117
};
void initMIDI() {
  println("--------------------------INIT MIDI-----");
  //RESET BUTTONS
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j < aButtonsMidiMapping.length; j++) {

      aBT[i][j] = false;
    }
  }
  //RESET knobs
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j <aKnobsMidiMapping.length; j++) {
      aKNOB[i][j] = 0;
    }
  }

  aKNOB[0][1] =0;
  aKNOB[0][2] =100;
  aKNOB[0][3] =100;
  aKNOB[0][4] =100;
  aKNOB[0][5] =100;
  aKNOB[0][6] =100;
  aKNOB[0][7] =100;
  aKNOB[0][8] =0;
  aKNOB[0][9] =100;
  aKNOB[0][10] =100;
  aKNOB[0][11] =100;
  aKNOB[0][15] =127;
  aKNOB[1][2] = 0.5;

  setupMidi();
}

void setupMidi() {
  System.out.println("----------setupMidi----------");
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index aend name.

  try {    
    //MidiBus.list(); 
    System.out.println("----------MIDI SETUP----------");


    midi_kontrol = new MidiBus(this, nano_2, -1, "midi_kontrol");
    midi_novation = new MidiBus(this, novation, -1, "midi_novation");
    // midi_novation_out = new MidiBus(this, -1, novation, "midi_novation_out"); 
    midi_novation_out =midi_novation ;
    println(">>>>> MIDI DETECTADO > KONTROL id:"+ " "+midi_kontrol);
    println(">>>>MIDI DETECTADO > NOVATION id:"+ " "+midi_novation);
    isMidiAvailable = true;
    initLaunchControl();

    println("<< MIDI  initMIDI: >>>>>>>>>>>>>>>>>>>>>>"+midi_novation);
  }
  catch(Exception e) {
    println("***************MIDI not available.");
    println("***************Exception: "+e.toString()+"\n");

    midi_kontrol=null;
    midi_novation = null;
    isMidiAvailable = true;
  }
}
void restartMidi() {
  println("----MIDI >  restart");
  //isMidiAvailable = false;
  isMidiAvailable = false;

  if (midi_kontrol != null) midi_kontrol.close();

  if (midi_novation != null)   midi_novation.close();
 /* midi_kontrol = new MidiBus();
  midi_novation = new MidiBus();*/
  setupMidi();
  endLaunchControl();
}
void initLaunchControl() {

  println("----MIDI > initLaunchControl...."+ACTIVECHANNEL);

  for ( int c=0; c< 8; c ++ ) {
    midi_novation_out.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x7D")); //(full Brightnes
  }
}
void endLaunchControl() {

  if (  isMidiAvailable ) {
    midi_novation_out.sendMessage(Integer.decode("0x87"), 27, byte_green); //chanel, note, light

    for ( int c=0; c< 8; c ++ ) {
      midi_novation_out.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x00")); //Reset Launch Control

      for ( int i=0; i< aKeyMaps.length; i ++ ) {


        midi_novation_out.sendMessage(Integer.decode("0x8"+c), aKeyMaps[ i ], byte_green); //chanel, note, light
      }
      //delay(200);
      //midi_novation.sendMessage(Integer.decode("0xB"+c), Integer.decode("0x00"), Integer.decode("0x00"));/*All LEDs are turned off, */
      // if (ACTIVECHANNEL == c)  midi_novation.sendMessage(Integer.decode("0x9"+c), aKeyMaps[c], byte_green); //chanel, note, light
      // midi_novation.sendMessage(0x90, 9, 0x3A); //chanel, note, light
    }
    println("MIDI > ENDLaunchControl...."+ACTIVECHANNEL);
  }
}

void controllerChange(int channel, int number, int value, long timestamp, String bus_name) {

  // println("Number:"+number);
  //println("Value:"+value);

  if (bus_name == "midi_kontrol") {
    // println("This came from  midi_kontrol");
    controllerIn_kontrol(number, value);
  } else if (bus_name == "midi_novation") {
    // println("This came from  samson");
    controllerIn_novation(number, value, channel);
  }
  midi_novation_out.sendMessage(Integer.decode("0x87"), getNote(6), Integer.decode("0x00"));
}
/* ------------------------    CNTROLLER IN PAD ---------------------------------------------------------*/



void drawMidi() {
  //listenerButtons();
  listenerPresetsLights();
  // println("aBT[7][6]:"+aBT[7][6]);
}
void listenerButtons() {


  //RESET BUTTONS
  for (int i = 0; i < numChannels; i++) {
    for (int j = 0; j < aButtonsMidiMapping.length; j++) {
      int ind= getNote(j);

      if (aBT[i][j])  midi_novation_out.sendMessage(Integer.decode("0x9"+i), ind, byte_red);
      // else midi_novation.sendMessage(Integer.decode("0x8"+i), ind, byte_red);
    }
  }
}
void listenerPresetsLights() {
  if (midi_novation != null) {
    //smidi_novation.//REsendMessage(0xB1, 00, 00); //RESET
    midi_novation_out.sendMessage(0x90, 9, 0x3A);
    midi_novation_out.sendMessage(0x91, 10, 0x3A);
    midi_novation_out.sendMessage(0x92, 11, 0x3A);
    midi_novation_out.sendMessage(0x93, 12, 0x3A);
    midi_novation_out.sendMessage(0x94, 25, 0x3A);
    midi_novation_out.sendMessage(0x95, 26, 0x3A);
    midi_novation_out.sendMessage(0x96, 27, 0x3A);
    midi_novation_out.sendMessage(0x97, 28, 0x3A);

    midi_novation_out.sendMessage(152, 9, 0x38);
    midi_novation_out.sendMessage(153, 10, 0x38);
    midi_novation_out.sendMessage(154, 11, 0x38);
    midi_novation_out.sendMessage(155, 12, 0x38);
    midi_novation_out.sendMessage(156, 25, 0x38);
    midi_novation_out.sendMessage(157, 26, 0x38);
    midi_novation_out.sendMessage(158, 27, 0x38);
    midi_novation_out.sendMessage(159, 28, 0x38);
  }
}
void controllerIn_novation(int num, int valor, int channel) {
  //println("Controller Change:"+" Channel:"+channel+ " Number:"+num+" Value:"+valor);
  int ind;
  ACTIVECHANNEL = channel;
  int indKnob = getIndiceKnob(num);
  if (channel < numChannels) { //presetsLights

    if ( indKnob != -1 )  // //comprobamos si se ha movido un knob
    {
      aKNOB[channel][indKnob] = valor;
      println("aKNOB["+channel+"]["+indKnob+"]"+aKNOB[channel][indKnob]);
    }
    if ((channel > 7) && (indKnob == 7))
    {
      aKNOB[0][7] = valor;
    }
    if ((channel > 7) && (indKnob == 15))
    {
      aKNOB[0][15] = valor;
    }
    if ((channel > 1) && (indKnob == 4))
    {
      aKNOB[0][4] = valor;
    }
    if ((channel > 1) && (indKnob == 15))
    {
      aKNOB[0][12] = valor;
    }



    listenerPresetsLights();
  }
  try {
    // println("-----------------------------------------------------");
    switch(num) {
    case 28: /* c16 */
      for (int i= 0; i < 7; i++)
        aKNOB[i][7] = valor;

      break;
    }
  }
  catch(Exception e) {

    println("***************Exception pad: "+e.toString()+"\n");
  }
}

void noteOn(int channel, int pitch, int velocity, long timestamp, String bus_name) {
  println("Note ON:"+"Channel:"+channel+" Pitch "+pitch);

  if (bus_name == "midi_novation") {
    ACTIVECHANNEL = channel;
    int ind = getIndice(pitch); 

    aBT[channel][ind] =!  aBT[channel][ind] ;


    println("aBT["+channel+"]["+ind+"]"+aBT[channel][ind]);
    if (channel < 8) {
      if ( aBT[channel][ind])  midi_novation_out.sendMessage(Integer.decode("0x9"+channel), pitch, byte_red);
      else midi_novation_out.sendMessage(Integer.decode("0x8"+channel), pitch, byte_red);
    }
    // if (channel == 7 ) listenChannel7(channel, pitch);
    if (channel == 15 ) listenChannel15(channel, pitch); //colores
    if (channel == 13 ) listenChannel13(channel, pitch); //bg
    if (channel == 14 ) listenChannel14(channel, pitch); //brush
    if (channel == 7 ) listenChannel7(channel, pitch); //TOXI
  }
}

void noteOff(int channel, int pitch, int velocity, long timestamp, String bus_name) {

  // println("Note Off:"+"Channel:"+channel+" Pitch "+pitch);

  if (bus_name == "midi_novation") {
    //println("Note Off:"+"Channel:"+channel+" Pitch "+pitch);
    ACTIVECHANNEL = channel;
    int ind = getIndice(pitch); 
    aBT[channel][ind] =!  aBT[channel][ind] ;
    if (channel == 7 ) listenChannel7(channel, pitch);

    /* if (channel == 15 ) listenChannel15(channel, pitch); //colores
     if (channel == 9 ) listenChannel9(channel, pitch); //bg
     if (channel == 8 ) listenChannel8(channel, pitch); //particles*/
    if (channel < 8) {
      if ( aBT[channel][ind])  midi_novation_out.sendMessage(Integer.decode("0x9"+channel), pitch, byte_red);
      else midi_novation_out.sendMessage(Integer.decode("0x8"+channel), pitch, byte_red);
    }
    println("aBT["+channel+"]["+ind+"]"+aBT[channel][ind]);
  }
}

void listenChannel14(int channel, int pitch) {

  if (channel == 14 ) 
  {

  }
}
void listenChannel7(int channel, int pitch) {
  // snapDist=20*20;// squared snap distance for picking particles

  if (channel == 7 ) //TEMPLATE 8 > Presets listeners
  {

    int ind = getIndice(pitch);
    if ( aBT[channel][0]) {


    }
    if ( aBT[channel][1]) {
    }
    if ( aBT[channel][2]) {
    }
    if ( aBT[channel][3]) {
    }
    if ( aBT[channel][4]) {
    }
    if ( aBT[channel][5]) {
    }
    if ( aBT[channel][6]) {
    }
    if ( aBT[channel][7]) {
    }
    // String cadena = "TOXI > isMouse:" +isMouse +"    isNoise:"+isNoise+"    isDrag:"+isDrag+"    isDrawShapes:"+isDrawShapes+"    isFill:"+isFill+"    isChange:"+isChange+"    isVelocity:"+isVelocity+"    isTailLocked:"+isTailLocked;
  }
}
void listenChannel15(int channel, int pitch) {
  println("channel 15");
  if (channel == 15 ) //TEMPLATE 9 > Pfactory PALETTE
  {


  }
}
void listenChannel13(int channel, int pitch) {

  if (channel == 13 ) //TEMPLATE 9 > Pfactory PALETTE
  {
    int active = getIndice(pitch);

  }

  //if ( aBT[9][9]) bg.setBg();
}
void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

int getNote(int indice) {
  int v = -1;
  for ( int i=0; i< aKeyMaps.length; i ++ ) {

    if (  i  == indice)  v= aKeyMaps[i];
  }
  return v;
}
int getIndice(int note) {
  int v = -1;
  for ( int i=0; i< aKeyMaps.length; i ++ ) {
    //println("aKeyMaps[ i ]"+aKeyMaps[ i ]+ "indice:"+i);
    if (  aKeyMaps[ i ]  == note)  v= i;
  }
  return v;
}
int getIndiceKnob(int value) {

  int v = -1;
  for ( int i=0; i< aKnobsMidiMapping.length; i ++ ) {
    //println("aKeyMaps[ i ]"+aKeyMaps[ i ]+ "indice:"+i);
    if (  aKnobsMidiMapping[ i ]  == value)  v= i;
  }
  return v;
}
void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage
  // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
  // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
  /* println();
   println("MidiMessage Data:");
   println("--------");
   println("Status Byte/MIDI Command:"+message.getStatus());
   for (int i = 1; i < message.getMessage ().length; i++) {
   println("Param "+(i+1)+": "+(message.getMessage()[i] & 0xFF));
   }*/
}
/* ------------------------    CONTROLLER IN KONTROL ---------------------------------------------------------*/
void controllerIn_kontrol(int num, int valor) {
  try {

    switch(num) {


      //-----------------------knobs inicio----------------
    case 1: 
      KNOB_1 =  map(valor, 0, 127, 0, 100);





      break;
    case 2: 
      KNOB_2 =  map(valor, 0, 127, 0, 100);

      //onionData.setParam1(RADIO, "RADIO", RADIOMAXIM);


      break;  
    case 3: 
      KNOB_3 =map(valor, 0, 127, 0, 360);



      break;   
    case 4: 
      KNOB_4 = map(valor, 0, 127, 0, 255);
      println("MIDI >> KNOB_4:"+KNOB_4);
      break;
    case 5: 
      KNOB_5 = map(valor, 0, 127, 0, 255); 



      break; 
    case 6: 
      KNOB_6= map(valor, 0, 127, 0, 255);
      FADER_2 = map(valor, 0, 127, 0, 200);

      println("MIDI >> FADER_2:"+FADER_2);
      break;
    case 7:
      KNOB_7= map(valor, 0, 127, 1, 200);
      println("MIDI >> KNOB_7:"+ KNOB_7);
      break;
    case 8:
      KNOB_8= map(valor, 0, 127, 1, 100);
      println("MIDI >> KNOB_8:"+ KNOB_8);


      break;   

      //-----------------------knobs FIN----------------  

      //-----------------------botones ----------------
    case 91:  
      if (valor == 127 ) BT_91=true; 
      else BT_91=false;
      println("MIDI >> BT_91:"+BT_91);
      break;

    case 92: 

      BT_92  =  (valor==127) ? true : false;
      //o_fade.setFade();

      break; 

    case 94:  


      BT_94  =  (valor==127) ? true : false;
      println("MIDI >> BT_94:"+BT_94);
      break;
    case 95: 

      BT_94  =  (valor==127) ? true : false;
      println("MIDI >> BT_95:"+BT_95);

      break;
    case 96: 


      BT_96  =  (valor==127) ? true : false;
      println("MIDI >> BT_96:"+BT_96);


      break;
    case 97: 



      BT_97  =  (valor==127) ? true : false;
      println("MIDI >> BT_97:"+BT_97);

      break;
    case 98: 



      BT_98  =  (valor==127) ? true : false;
      println("MIDI >> BT_98:"+BT_98);

      break;
    case 99: 



      BT_99  =  (valor==127) ? true : false;
      println("MIDI >> BT_99:"+BT_99);

      break;
    case 100:  
      BT_100  =  (valor==127) ? true : false;
      println("MIDI >> BT_100:"+BT_100);


      break;
    case 101:  
      BT_101  =  (valor==127) ? true : false;
      println("MIDI >> BT_101:"+BT_101);

      break;

      //-----------------------botones ---------------
    case 11: 
      BT_11  =  (valor==127) ? true : false;
      println("BT_11 >>  "+BT_11);
      break;
    case 12: 
      BT_12  =  (valor==127) ? true : false;
      println("BT_12 >>  "+BT_12);
      break;
    case 13: 
      BT_13  =  (valor==127) ? true : false;
      println("BT_13 >>  "+BT_13);
      break;

    case 21: 
      BT_21  =  (valor==127) ? true : false;
      println("BT_21 >>  "+BT_21);

      break;
    case 22: 
      BT_22  =  (valor==127) ? true : false;
      println("BT_22 >>  "+BT_22);
      break;
    case 23: 
      BT_23  =  (valor==127) ? true : false;
      println("BT_23 >>  "+BT_23);
      break;      

    case 31: 
      BT_31  =  (valor==127) ? true : false;
      println("BT_31 >>  "+BT_31);
      break;
    case 32: 
      BT_32  =  (valor==127) ? true : false;
      println("BT_32 >>  "+BT_32);
      break;
    case 33: 
      BT_33  =  (valor==127) ? true : false;
      println("BT_33 >>  "+BT_33);
      break;      

    case 41: 
      BT_41  =  (valor==127) ? true : false;
      println("BT_41 >>  "+BT_41);
      break;
    case 42: 
      BT_42  =  (valor==127) ? true : false;
      println("BT_42 >>  "+BT_42);
      break;
    case 43: 
      BT_43  =  (valor==127) ? true : false;
      println("BT_43 >>  "+BT_43);
      break;      

    case 51: 
      BT_51  =  (valor==127) ? true : false;
      println("BT_51 >>  "+BT_51);
      break;
    case 52: 
      BT_52  =  (valor==127) ? true : false;
      println("BT_52 >>  "+BT_52);
      break;
    case 53: 
      BT_53  =  (valor==127) ? true : false;
      println("BT_53 >>  "+BT_53);
      break;      

    case 61: 
      BT_61  =  (valor==127) ? true : false;
      println("BT_41 >>  "+BT_61);
      break;
    case 62: 
      BT_62  =  (valor==127) ? true : false;
      println("BT_52 >>  "+BT_62);
      break;
    case 63: 
      BT_63  =  (valor==127) ? true : false;
      println("BT_53 >>  "+BT_63);
      break; 

    case 71: 
      BT_71  =  (valor==127) ? true : false;
      println("BT_71 >>  "+BT_71);
      break;
    case 72: 
      BT_72  =  (valor==127) ? true : false;
      println("BT_72 >>  "+BT_72);
      break;
    case 73: 
      BT_73  =  (valor==127) ? true : false;
      println("BT_73 >>  "+BT_73);
      break; 

    case 81: 

      BT_81  =  (valor==127) ? true : false;
      println("BT_81 >>  "+BT_81);
      break;
    case 82: 
      BT_82  =  (valor==127) ? true : false;
      println("BT_82 >>  "+BT_82);
      break;
    case 83: 
      BT_83  =  (valor==127) ? true : false;
      println("BT_83 >>  "+BT_83);
      break; 
    case 93: 
      BT_93  =  (valor==127) ? true : false;
      println("BT_93 >>  "+BT_93);


      break; 




      //-----------------------FADERS ---------------
    case 10: 
      FADER_1 = map(valor, 0, 127, 0, 10);
      //  println("FADER_1 >>  "+FADER_1);

      // println("MIDI >> SPEED:"+SPEED);


      break;

    case 20: 
      // FADER_2 = map(valor, 0, 127, 0, 255);
      //println("FADER_2 >>  "+FADER_2);
      break;
    case 30: 

      FADER_3 =  map(valor, 0, 127, 0, 200);
      println("FADER_3  >> FADER_3:"+FADER_3 );

      break;
    case 40: 

      FADER_4 =  map(valor, 0, 127, 0, 255);
      println("FADER_4  >> FADER_4:"+FADER_4 );

      break;
    case 50: 
      if ( BT_52 ) {

        FADER_51 =  map(valor, 0, 127, 0, 100);
        println("FADER_51  >> FADER_51:"+FADER_51 );
      } else
      {


        FADER_5 =  map(valor, 0, 127, 0, 255);
        println("FADER_5  >> FADER_5:"+FADER_5 );
      }

      break;
    case 60: 
      FADER_6 =  map(valor, 0, 127, 0, 255);

      println("FADER_6  >> FADER_6:"+FADER_6 );
      break;

    case 70: 
      if ( BT_72 ) { 
        FADER_71 = map(valor, 0, 127, 0, 200);
        println("FADER_71  >> FADER_71:"+FADER_71 );
      } else
      {
      }
      FADER_7 = map(valor, 0, 127, 0, 200);
      println("FADER_7 >>  "+FADER_7);


      break;
    case 80: 
      ALFA = map(valor, 0, 127, 0, 255);
      println("MIDI >> alfa:"+ALFA);
      FADER_8 = map(valor, 0, 127, 0, 255);
      println("FADER_8 >>  "+FADER_8);
      break;
    }
  }
  catch(Exception e) {
    println("***************Exception: "+e.toString()+"\n");
  }
}
