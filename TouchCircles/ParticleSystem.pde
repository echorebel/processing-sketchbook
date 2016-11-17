class ParticleSystem
{
  ArrayList particles;
  int currentIndex = 0;
  
  ParticleSystem(int size)
  {
    particles = new ArrayList();
    for(int i=0; i<size;i++)
    {
      particles.add(new Particle());
    }
  }
  
  void run()
  {
    for (int i=0; i < particles.size(); i++)
    {
      Particle p = (Particle) particles.get(i);
      p.run();
    }
  }
  
  void activate(int xx, int yy)
  {
    Particle p = (Particle) particles.get(currentIndex);
    p.x = xx;
    p.y = yy;
    p.alive = true;
    p.timer = int(random(1,255));
    currentIndex++;
    if(currentIndex >= particles.size())
    {
      currentIndex = 0;
    }
  }
  
}