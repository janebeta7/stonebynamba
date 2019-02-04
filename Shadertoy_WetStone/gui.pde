float ALFA = 1;
int[] rgb0 =  {255, 125, 0};
int[] rgb1 =  {0, 125, 255};

import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Controller;
import controlP5.ControllerView;
import com.thomasdiewald.pixelflow.java.utils.DwColorPicker;
import controlP5.*;
ControlFrame cf;
int gui_w = 400;
int hui_h = 400;
ControlP5 cp5;
public void createGUI() {
  cf = new ControlFrame(this, 450, 400, "Controls");
}




/**
 * Creating a new cp5-controller for PixelFlows colorpicker.
 */
static class ColorPicker extends Controller<ColorPicker> {
  ControlP5 cp5;
  DwColorPicker colorpicker;
  Pointer ptr = getPointer();
  int[] rgb;

  int hud_sy = 16;

  ColorPicker(ControlP5 cp5, String theName, int dim_x, int dim_y, int ny, int[] rgb) {
    super(cp5, theName);

    setSize(dim_x, dim_y);
    this.cp5 = cp5;
    this.rgb = rgb;
    this.colorpicker = new DwColorPicker(cp5.papplet, 0, 0, dim_x, dim_y-hud_sy);
    float varl = dim_y-hud_sy;

    this.colorpicker.setAutoDraw(false);
    this.colorpicker.setAutoMouse(false);
    createPallette(ny);

    setView(new ControllerView<ColorPicker>() {
      public void display(PGraphics pg, ColorPicker cp) {

        int dim_x = getWidth();
        int dim_y = getHeight();

        int    cp_col = colorpicker.getSelectedColor();
        String cp_rgb = colorpicker.getSelectedRGBasString();
        // String cp_hsb = colorpicker.getSelectedHSBasString();

        int sy = hud_sy;
        int px = 0;
        int py = colorpicker.h()+1;

        pg.noStroke();
        pg.fill(200, 50);
        pg.rect(px-1, py, dim_x+2, sy+1);
        pg.fill(cp_col);
        pg.rect(px, py, sy, sy);

        pg.fill(255);
        pg.text(cp_rgb, px + sy * 2, py+8);
        //          pg.text(cp_hsb, px + sy * 2, py+8);

        colorpicker.display();
      }
    }
    );
  }

  public ColorPicker createPallette(int shadesY) {
    colorpicker.createPallette(shadesY);
    colorpicker.selectColorByRGB(rgb[0], rgb[1], rgb[2]);
    return this;
  }

  public ColorPicker createPallette(int shadesX, int shadesY) {
    colorpicker.createPallette(shadesX, shadesY);
    colorpicker.selectColorByRGB(rgb[0], rgb[1], rgb[2]);
    return this;
  }


  boolean STATE_SELECT = false;
  public void selectColor() {
    if (STATE_SELECT) {
      colorpicker.selectColorByCoords(ptr.x(), ptr.y());
      int[] selected = colorpicker.getSelectedRGBColor();
      rgb[0] = selected[0];
      rgb[1] = selected[1];
      rgb[2] = selected[2];
    }
  }

  protected void onPress() {

    STATE_SELECT = colorpicker.inside(ptr.x(), ptr.y());

    selectColor();
  }
  protected void onDrag() {
    selectColor();
  }
  protected void onRelease( ) {
    selectColor();
    STATE_SELECT = false;
  }
}
class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    background(0);
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);

    int col_group = color(16, 220);

    // GROUP
    Group group = cp5.addGroup("ColorPicker");
    group.setHeight(20).setSize(gui_w, hui_h).setBackgroundColor(col_group).setColorBackground(col_group);
    group.getCaptionLabel().align(CENTER, CENTER);

    int sx = 100;
    int sy = 14;
    int px = 10;
    int py = 25;
    int dy = 2;

    cp5.addSlider("AlFA").setGroup(group).setSize(sx, sy).setPosition(px, py)
      .setRange(0, 1).setValue(ALFA).plugTo(parent, "ALFA");
    py += sy + dy;

    cp5.addSlider("TRESHOLD").setGroup(group).setSize(sx, sy).setPosition(px, py)
      .setRange(-1, 1.73).setValue(TRESHOLD).plugTo(parent, "TRESHOLD");
    py += sy + dy;

 cp5.addSlider("DISPLACEMENT").setGroup(group).setSize(sx, sy).setPosition(px, py)
      .setRange(-5.89, 25).setValue(DISPLACEMENT).plugTo(parent, "DISPLACEMENT");
    py += sy + dy;



    // create a new button with name 'buttonA'

    px = px;
    /* cp5.addCheckBox("displayContent").setGroup(group_filter).setSize(18, 18).setPosition(px, py)
     .setItemsPerRow(1).setSpacingColumn(2).setSpacingRow(2)
     .addItem("isFade"         , 0).activate(DISPLAY_IMAGE      ? 0 : 3)
     .addItem("display geometry/noise", 1).activate(DISPLAY_GEOMETRY   ? 1 : 3)
     .addItem("display animations"    , 2).activate(DISPLAY_ANIMATIONS ? 2 : 3)
     ;*/

    py += sy + 40;
    sx = gui_w -30;
    sy = 60;
    ColorPicker cp1 = new ColorPicker(cp5, "colorpicker1", sx, sy, 120, rgb0).setGroup(group).setPosition(px, py);
    py += sy + 30;

    sy = sy;
    ColorPicker cp2 = new ColorPicker(cp5, "colorpicker2", sx, sy, 120, rgb1).setGroup(group).setPosition(px, py);
    py += sy + dy;


    // cp2.createPallette(20);

    // ACCORDION
    cp5.addAccordion("acc").setPosition(20, 20).setSize(gui_w, hui_h)
      .setCollapseMode(Accordion.MULTI)
      .addItem(group)
      .open(0, 1);
  }
  // function colorA will receive changes from 
  // controller with name colorA
  public void isFade(int theValue) {
    println("a button isFade: "+theValue);
  }
  void slider(float alfa) {
    ALFA =alfa;
    println("alfa:"+ALFA);
  }
  void draw() {
    background(190);
  }
}
