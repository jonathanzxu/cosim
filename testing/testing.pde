Test[] testarray = new Test[10];
void setup() {
  size(1440, 900);
  for(int i = 0; i < testarray.length; i++)
  {
    testarray[i] = new Test();
    testarray[i].x = i*200;
    testarray[i].y = 200;
  }
}
int STUDENT_RADIUS = 10;


void draw() {
  runTest();
  
}

void runTest(){
    noStroke();
    //if(sick) fill(255, 0, 0);
    fill(255, 255, 255);
    /*
    ellipse(100, 100, STUDENT_RADIUS, STUDENT_RADIUS);
    */
  for(int i = 0; i < testarray.length; i++)
    {
      testarray[i].DRAW();
      testarray[i].y += 5;
    }
}

class Test {
  int x, y;
  void DRAW(){
    ellipse(this.x, this.y, STUDENT_RADIUS, STUDENT_RADIUS);
  }
}
