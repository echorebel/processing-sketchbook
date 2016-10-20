int x=0;
int y=0;

void setup()
{
  size(500,500);
}

void draw()
{
  //if(mousePressed)
  if(true)
  {
    drawLines2Mouse();
  }
}

void drawLines2Mouse()
{
  line(x,y,mouseX,mouseY);
  x += 0.1*(mouseX-x);
  y += 0.1*(mouseY-y);
}