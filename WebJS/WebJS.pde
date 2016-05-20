int x = 50;
int r = 50;

Point[] pts = new Point[6];

int count = 0;

void setup()
{
  size(800,600);
  frameRate(60);
  //pixelDensity(2); // retina
}

void draw()
{
  if(keyPressed) {
        println(" you pressed "+key);
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
    
  