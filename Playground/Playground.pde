import controlP5.*;

int x = 50;
int r = 50;

Point[] pts = new Point[6];

ControlP5 cp5; //no FX2D support

int count = 0;

void setup()
{
  size(800,600);
  //size(640, 480, FX2D);
  //frameRate(60);
  //pixelDensity(2); // retina
  //qfullScreen();
  //fullScreen(1); // 1 | 2 | SPAN run on a specific monitor or on all
  //fullScreen(P2D);
  //fullScreen(P3D);
  
  cp5 = new ControlP5(this);
  cp5.addSlider("r")
     .setPosition(40, 40)
     .setSize(200, 20)
     .setRange(50, 300)
     .setValue(r)
     .setColorCaptionLabel(color(20,20,20));
     
  cp5.addButton("myButton")
     .setPosition(350, 40);
  
}

void draw()
{
  if(keyPressed) {
        print(" you pressed "+key);
  }
  
  ellipse(x,200,r,r);
  x++;
  
  if(x > width) x=0;
  
  beginShape();
  for(int i = 0; i<pts.length; i++)
  {
    if(pts[i] != null)
    {
      vertex(pts[i].x, pts[i].y);
    }
  }
  endShape();
    
}

void mousePressed()
{
  if(count > 5){
        count = 0;
    }
    Point newPoint = new Point(mouseX, mouseY);
    pts[count] = newPoint;
    count++;
}

void keyPressed(){
    print(" you're pressing a key \n that key is "+key);
}

class Point
{
  float x;
  float y;
  
  Point(float _x, float _y)
  {
    println(" x is: "+_x+" and y is "+_y);
    x = _x;
    y = _y;
  }
}
    
  