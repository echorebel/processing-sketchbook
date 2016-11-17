/*
41,70,109 blue
0,58,33 green
170,142,57 yellow
*/
final int SIZE = 40;
final int NUM_SPAWN = 5;
ParticleSystem ps;

void setup()
{
  fullScreen();
  background(41,70,109);
  noStroke();
  smooth();
  ps = new ParticleSystem(2000);
}

void draw()
{
  background(0,58,33);
  ps.run();
  ps.activate(mouseX, mouseY);
}

void mousePressed()
{
  for(int i=0; i<NUM_SPAWN; i++)
  {
    ps.activate(mouseX, mouseY);
  }
}
void mouseDragged()
{
  ps.activate(mouseX, mouseY);
}