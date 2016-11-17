// random walker

class Walker
{
  float x,y;
  float speed = 5;
  
  Walker(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  void draw()
  {
    point(x,y);
  }
  
  void move()
  {
    x += (Math.random()*speed)-speed/2;
    y += (Math.random()*speed)-speed/2;
    
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  
  void walk()
  {
    move();
    draw();
  }
  
  
}