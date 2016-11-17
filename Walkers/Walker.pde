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
    /*
    PVector mouse = new PVector(mouseX,mouseY);
    mouse.normalize();
    */
    
    if(Math.random() > 0.8)
    {
      int factorX = mouseX > x ? 1 : -1;
      x += speed/2 * factorX;
      int factorY = mouseY > y ? 1 : -1;
      y += speed/2 * factorY;
      // TODO fix it to make it more natural
    } else {
      x += (Math.random()*speed)-speed/2;
      y += (Math.random()*speed)-speed/2;
    }
    
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  
  void walk()
  {
    move();
    draw();
  }
   
}