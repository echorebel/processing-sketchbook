class Particle
{
  int x,y;
  int timer;
  int index;
  int stopTimer;
  int speedX, speedY;
  boolean alive;
  
  Particle()
  {
    timer = int(random(1,255));
    speedX = int(random(8))-4;
    speedY = int(random(8))-4;
  }
  
  void run()
  {
    if(!alive) return;
      
    update();
    display();
  }
  
  void update()
  {
    x += speedX;
    y += speedY;

    if (timer > 0)
    {
      timer -= 4;
    } else {
      alive = false;
    }
  }
  
  void display()
  {
    fill(170,142,57,timer);
    ellipse(x,y,SIZE,SIZE);
  }
  
  
}