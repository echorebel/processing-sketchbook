final int NUM_WALKER = 50; 
Walker[] walker = new Walker[NUM_WALKER];
int walkerIndex = 0;

void setup()
{
  //size(1440,850);
  fullScreen();
}

void draw()
{ 
  for(int i=0;i<walker.length;i++)
  {
    if(walker[i]!=null)
      walker[i].walk();
  }

}

void mousePressed()
{
    addWalker();
}

void addWalker()
{
  //walker = new Walker((float) Math.random() * width, (float) Math.random() * height);
  walker[walkerIndex] = new Walker(mouseX, mouseY);
  walkerIndex++;
  if(walkerIndex>=NUM_WALKER) walkerIndex=0;
    
    
}