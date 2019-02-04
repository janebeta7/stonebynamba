/**
 * 
 * PixelFlow | Copyright (C) 2017 Thomas Diewald - www.thomasdiewald.com
 * 
 * https://github.com/diwi/PixelFlow.git
 * 
 * A Processing/Java library for high performance GPU-Computing.
 * MIT License: https://opensource.org/licenses/MIT
 * 5400x1080
 */


import com.jogamp.opengl.GL3;
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.utils.DwUtils;

//
// Shadertoy Demo:   https://www.shadertoy.com/view/ldSSzV
// Shadertoy Author: https://www.shadertoy.com/user/TDM
//
PShader deform;
DwPixelFlow context;
DwShadertoy toy;
int displayY , displayX;
float TRESHOLD  = 0.5;
float DISPLACEMENT = 0.7;
public void settings() {
  fullScreen(P3D); 
  smooth(0);
}

public void setup() {
  surface.setSize(1920 ,1080);
 initMIDI();
  //surface.setSize(1400, 500);
  surface.setLocation(0, 0);
  surface.setResizable(true);

  context = new DwPixelFlow(this);
  context.print();
  context.printGL();

  toy = new DwShadertoy(context, "data/WetStone.frag");
 // deform = loadShader("WetStone.glsl");
  frameRate(60);
  createGUI();
   setupAudio();
}


public void draw() {
  infoAudio();
  ALFA = map(aKNOB[0][7],0,127,0,1);
  TRESHOLD = map(aKNOB[0][0],0,127,-1, 1.73);
  DISPLACEMENT= map(aKNOB[0][8],0,127,-5.89, 25);

//  firstShader.set("iFrame", frameCount); 

  toy.set_iTime(9000.);
  toy.set_u_color_r(map(rgb0[0], 0, 255, 0, 1));
  toy.set_u_color_g(map(rgb0[1], 0, 255, 0, 1));
  toy.set_u_color_b(map(rgb0[2], 0, 255, 0, 1));
  //
  toy.set_u_color_r2(map(rgb1[0], 0, 255, 0, 1));
  toy.set_u_color_g2(map(rgb1[1], 0, 255, 0, 1));
  toy.set_u_color_b2(map(rgb1[2], 0, 255, 0, 1));
  
   toy.set_ALFA(ALFA);
  
  //y.set_u_color_r(map(rgb0[0], 0, 255, 0, 1));
  if (mousePressed) {
    //  deform.set(iMouse(mouseX, height-1-mouseY, mouseX, height-1-mouseY);
  }
  //shader(deform);
  toy.apply(g);



  String txt_fps = String.format(getClass().getSimpleName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f]", width, height, frameCount, frameRate);
  surface.setTitle(txt_fps);
}
