import java.awt.Font;
import g4p_controls.*;
public int N, C, T, Cl, Nk, Ck, I, R0;
final int WINDOW_WIDTH = 1440;
final int WINDOW_HEIGHT = 900;
public Student[] students;
//public Font helv = new Font("Helvetica", Font.BOLD | Font.ITALIC, 25);
public void setup() {
  size(1440, 900);
  createGUI();
  customGUI();
  N = 1000;
  C = 7;
  Cl = 80;
  T = 15;
  //move to runmenu later
  students = new Student[N];
  for(int i = 0; i < N; i++)
  {
    students[i] = new Student(0,0, C, Cl);
  }
  //GSlider nslider = new GSlider(this, 100, 100, 500, 100);
}
int state = 0;
public void draw() {
  switch(state) {
    case 0:
      runMenu();
      break;
    case 1:
      runSim();
      break;
  }
  
  
}

public void customGUI(){

}


//sim visual tweakers
final int HALLWAY_WIDTH = 100;
final int HALL1X = 300;
final int HALL2X = 600;
final int HALL3X = 900;
final int HALLHEIGHT = 100;
final int HALLLENGTH = 700;
final int STUDENT_RADIUS = 5;
int classnum = 0;
int classesmade, xborder, yborder, classsize;
int classtime = 0;
int day = 1;
//tempvars
int xrand, yrand;

Classroom[] classrooms;
//NEVER SET MORE THAN ONE OF THESE TO TRUE (bad things happen)
boolean initbetween = false;
boolean initclass = true;
boolean between = false;
boolean inclass = false;
boolean donewalking = false;

void runSim(){
    background(0);
    text("day: " + day, 10, 10);
    if(initbetween){
      for(int i = 0; i < students.length; i++){
        //students[i] = new Student(0, 0, C, Cl);
        students[i].south = Math.random() < 0.5;
        students[i].hallway = (int) (Math.random() * 3 + 1);
        if(students[i].hallway == 1){
          students[i].x = (int) (Math.random() * HALLWAY_WIDTH + HALL1X);
        } else if(students[i].hallway == 2){
          students[i].x = (int) (Math.random() * HALLWAY_WIDTH + HALL2X);
        } else {
          students[i].x = (int) (Math.random() * HALLWAY_WIDTH + HALL3X);
        }
        if(students[i].south) students[i].y = (int) (Math.random() * 500 - 250 - 250 + HALLHEIGHT);
        else students[i].y = (int) (Math.random() * 500 - 250 + 250 + HALLHEIGHT + HALLLENGTH);
      }
      initbetween = false;
      between = true;
    }
    if(between){
      donewalking = true;
      fill(128, 128, 128);
      stroke(0);
      rect(HALL1X, HALLHEIGHT, 100, HALLLENGTH);
      rect(HALL2X, HALLHEIGHT, 100, HALLLENGTH);
      rect(HALL3X, HALLHEIGHT, 100, HALLLENGTH);
      fill(255, 0, 0);
      for(int i = 0; i < students.length; i++){
        students[i].DRAW();
        if(students[i].south){
          students[i].y += (int) (Math.random() * 5 + 1);
          if(students[i].y < HALLHEIGHT + HALLLENGTH) donewalking = false; 
        }
        else
        {
          students[i].y -= (int) (Math.random() * 5 + 1);
          if(students[i].y > HALLHEIGHT) donewalking = false;
        }
      }
      if(donewalking){
        between = false;
        initclass = true;
      }
    }
    //if(initclass) text("done walking.", 100, 100);
    if(initclass){
      //true if infected present, false otherwise
      classrooms = new Classroom[Cl];
      classesmade = 0;
      xborder = 50;
      yborder = 50;
      classsize = (int) Math.sqrt((WINDOW_WIDTH - 50) * (WINDOW_HEIGHT * 3 / 4 - 50) / Cl) - 10;
      while(classesmade < Cl){
        while(xborder < WINDOW_WIDTH  - classsize - 50 && classesmade < Cl)
        {
          classrooms[classesmade] = new Classroom(xborder, yborder, classsize);
          xborder += classsize + 10;
          classesmade++;
        }
        yborder += classsize + 10;
        xborder = 50;
      }
      for(int i = 0; i < students.length; i++)
      {
        students[i].x = classrooms[students[i].classlist[classnum]].x + classrooms[students[i].classlist[classnum]].size/2;
        students[i].y = classrooms[students[i].classlist[classnum]].y + classrooms[students[i].classlist[classnum]].size/2;
      }
      initclass = false;
      inclass = true;
    }
    if(inclass){
      for(Classroom c : classrooms){
        fill(127);
        rect(c.x, c.y, c.size, c.size);
        
        //text(c.size, c.x, c.y);
      }
      for(int i = 0; i < students.length; i++){
        students[i].DRAW();
        xrand = ((int) (Math.random() * 11)) - 5;
        yrand = ((int) (Math.random() * 11)) - 5;
        if(students[i].x + xrand < classrooms[students[i].classlist[classnum]].x + classrooms[students[i].classlist[classnum]].size && students[i].x + xrand > classrooms[students[i].classlist[classnum]].x)
          students[i].x += xrand;
        if(students[i].y + yrand < classrooms[students[i].classlist[classnum]].y + classrooms[students[i].classlist[classnum]].size && students[i].y + yrand > classrooms[students[i].classlist[classnum]].y)
          students[i].y += yrand;
      }
      classtime++;
      if(classtime >= 120)
      {
        classtime = 0;
        classnum++;
        inclass = false;
        initbetween = true;
      }
      if(classnum >= C)
      {
        classnum = 0;
        day++;
      }
      //if day > T, move to resultrs
    }
    
  
}

void runMenu(){
  background(0);
  fill(255);
  text("Total students: " + N, 100, 800);
  
  
  //text("Student classes: " + C, 100, 200);
  //text("School days: " + T, 100, 300);
}


public class Student {
  int x;
  int y;
  boolean sick;
  boolean south;
  int hallway;
  int[] classlist;
  public Student(int xc, int yc, int C, int choices){
    x = xc;
    y = yc;
    classlist = new int[C];
    for(int i = 0; i < C; i++){
      classlist[i] = (int) (Math.random() * choices);
    }
  }
  
  void DRAW(){
    noStroke();
    if(sick) fill(255, 0, 0);
    else fill(255, 255, 255);
    //fill(255,255,255);
    ellipse(x, y, STUDENT_RADIUS, STUDENT_RADIUS);
  }
  
}

public class Classroom {
  int x;
  int y;
  int size;
  boolean sick;
  public Classroom(int xc, int yc, int s){
    x = xc;
    y = yc;
    size = s;
  }
}








/*
 * * * * * * * * * * DEPRECATED
public class TEXTBOX {
   public int X = 0, Y = 0, H = 35, W = 200;
   public int TEXTSIZE = 24;
   
   // COLORS
   public color Background = color(140, 140, 140);
   public color Foreground = color(0, 0, 0);
   public color BackgroundSelected = color(160, 160, 160);
   public color Border = color(30, 30, 30);
   
   public boolean BorderEnable = false;
   public int BorderWeight = 1;
   
   public String Text = "";
   public int TextLength = 0;

   private boolean selected = false;
   
   TEXTBOX() {
      // CREATE OBJECT DEFAULT TEXTBOX
   }
   
   TEXTBOX(int x, int y, int w, int h) {
      X = x; Y = y; W = w; H = h;
   }
   
   void DRAW() {
      // DRAWING THE BACKGROUND
      if (selected) {
         fill(BackgroundSelected);
      } else {
         fill(Background);
      }
      
      if (BorderEnable) {
         strokeWeight(BorderWeight);
         stroke(Border);
      } else {
         noStroke();
      }
      
      rect(X, Y, W, H);
      
      // DRAWING THE TEXT ITSELF
      fill(Foreground);
      textSize(TEXTSIZE);
      text(Text, X + (textWidth("a") / 2), Y + TEXTSIZE);
   }
   
   // IF THE KEYCODE IS ENTER RETURN 1
   // ELSE RETURN 0
   boolean KEYPRESSED(char KEY, int KEYCODE) {
      if (selected) {
         if (KEYCODE == (int)BACKSPACE) {
            BACKSPACE();
         } else if (KEYCODE == 32) {
            // SPACE
            addText(' ');
         } else if (KEYCODE == (int)ENTER) {
            return true;
         } else {
            // CHECK IF THE KEY IS A LETTER OR A NUMBER
            boolean isKeyCapitalLetter = (KEY >= 'A' && KEY <= 'Z');
            boolean isKeySmallLetter = (KEY >= 'a' && KEY <= 'z');
            boolean isKeyNumber = (KEY >= '0' && KEY <= '9');
      
            if (isKeyCapitalLetter || isKeySmallLetter || isKeyNumber) {
               addText(KEY);
            }
         }
      }
      
      return false;
   }
   
   private void addText(char text) {
      // IF THE TEXT WIDHT IS IN BOUNDARIES OF THE TEXTBOX
      if (textWidth(Text + text) < W) {
         Text += text;
         TextLength++;
      }
   }
   
   private void BACKSPACE() {
      if (TextLength - 1 >= 0) {
         Text = Text.substring(0, TextLength - 1);
         TextLength--;
      }
   }
   
   // FUNCTION FOR TESTING IS THE POINT
   // OVER THE TEXTBOX
   private boolean overBox(int x, int y) {
      if (x >= X && x <= X + W) {
         if (y >= Y && y <= Y + H) {
            return true;
         }
      }
      
      return false;
   }
   
   void PRESSED(int x, int y) {
      if (overBox(x, y)) {
         selected = true;
      } else {
         selected = false;
      }
   }
}

public class slider
{
  // constructor takes initial color, location (x, y) and
  // position of the slider
  slider(color c, float x, float y, float l)
  {
    sliderCol = c;
    posX = x;
    posY = y;
    loc = l;
    drawSlider();
  }

  // draws the slider on the screen
  private void drawSlider()
  {
    noStroke();
    fill(sliderCol);
    rect(posX, posY, 100, 300);
  }

  // updates color of the slider to the given value
  // and changes position of the slider accordingly
  public void update(color c)
  {
    sliderCol = c;
    drawSlider();
    fill(220, 220, 220);
    if (mousePressed)
    {
      if ((mouseX >= posX) && (mouseX <= (posX + 100)))
      {
        if ((mouseY >= 50) && (mouseY <= 350))
        {
          loc = mouseY - 50;
        }
      }
    }

    sliderVal = map(loc, 0.0, 300.0, 255.0, 0.0);

    rect((posX - 10), (posY + loc), 120, 20);
  }

  // return the position of the slider
  public float getVal()
  {
    return sliderVal;
  }

  private color sliderCol;
  private float posX;
  private float posY;
  private float loc;
  private float sliderVal;
}
*/
