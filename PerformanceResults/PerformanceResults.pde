/**
  visualizing benchmark results from:
  http://openwebgames.com
  
  ## Data Visualization Process
    1. Acquire   - obtain the result
    2. Parse     - structure result
    3. Filter    - remove all but the result of interest
    4. Mine      - apply statistics, mathematical context
    5. Represent - basic visual model, e.g. bar, list, tree
    6. Refine    - improve the basic representation to visually engaging
    7. Interact  - add methods for manipulating the result or visible features
  **/
  
final float OPTIMAL_FPS = 60.0;
final float MINIMAL_FPS = 12.0;
final int BAR_WIDTH = 300;

String[] files;
String[] games = {
  "suntemple",
  "sponzadynamicshadows",
  "heroesofparagon",
  "medusae",
  "alphabear",
  "skisafari",
  "casino"
};

color blue = color(127,174,219);
color lightblue = color(139,184,232);
color superlightblue = color(226,237,249);
color green = color(123,222,89);
color red = color(232,123,89);

ResultJSON[] result;

float[] fpsAvg = new float[games.length];
float[] fpsMin = new float[games.length];
float[] fpsMax = new float[games.length];

int[] droppedFramesAvg = new int[games.length];
int[] droppedFramesMin = new int[games.length];
int[] droppedFramesMax = new int[games.length];
int droppedFrameMaxAbsolute = 0;

int[] testSuccess = new int[games.length];
int[] testFailures = new int[games.length];

void setup()
{
  size(1024, 650);
  background(240);
  
  initArray(fpsAvg, 0.0); initArray(fpsMin, MAX_FLOAT); initArray(fpsMax, MIN_FLOAT);
  initArray(droppedFramesAvg, 0);
  initArray(droppedFramesMin, MAX_INT);
  initArray(droppedFramesMax, MIN_INT);
  initArray(testFailures, 0);
  initArray(testSuccess, 0);
  
  loadAndMine();

  // represent
  for (int g=0; g < games.length; g++)
  {
    drawResult(g, 15, 25+85*g);
  }
}

void loadAndMine()
{
  files = listFileNames(dataPath(""));
  result = new ResultJSON[files.length];

  // mine result
  float fps;
  int dropFrame;
  for (int i=0; i < files.length; i++)
  {
    println("loading: " + files[i]);
    result[i] = new ResultJSON(loadJSONObject(files[i]));
    
    for (int g=0; g < games.length; g++)
    {
      if(!result[i].dataFound(games[g]))
      {        
        continue;
      }
      
      if
      (
        result[i].status(games[g]).equals("failed") ||
        result[i].status(games[g]).equals("timeout")
      )
      {
        //test failed
        println("test failed, skipping " + games[g] + ", file: " + files[i]);
        testFailures[g]++;
        continue;
      }
      
      testSuccess[g]++;

      fps = result[i].fps(games[g]);

      fpsAvg[g] += fps;
      if (fps > fpsMax[g]) { fpsMax[g] = fps; }
      if (fps < fpsMin[g]) { fpsMin[g] = fps; }

      dropFrame = result[i].droppedFrames(games[g]);
      droppedFramesAvg[g] += dropFrame;
      if(dropFrame > droppedFramesMax[g]) { droppedFramesMax[g] = dropFrame;}
      if(dropFrame < droppedFramesMin[g]) { droppedFramesMin[g] = dropFrame;}
      if(droppedFramesMax[g] > droppedFrameMaxAbsolute){
        droppedFrameMaxAbsolute = droppedFramesMax[g];
      }
    }
  }

  for (int g=0; g < games.length; g++)
  {
    fpsAvg[g] /=  testSuccess[g];
    droppedFramesAvg[g] /= testSuccess[g];
  }

}

void drawResult(int gameIndex, int x, int y)
{
  JSONObject game = result[0].gameData(games[gameIndex]);

  int factor = 5;
  noStroke();

  fill(superlightblue);
  rect(x+250,y-10, BAR_WIDTH, 14);
  fill(red);
  rect(x+250, y-10, map((testSuccess[gameIndex]+ testFailures[gameIndex]), 0, files.length, 0, BAR_WIDTH), 14);
  fill(green);
  rect(x+250, y-10, map((testSuccess[gameIndex]), 0, files.length, 0, BAR_WIDTH), 14);

  fill(superlightblue);
  rect(x+250,y+16, OPTIMAL_FPS*factor, 20);
  fill(green);
  rect(x+250,y+16, fpsMax[gameIndex]*factor, 20);
  fill(blue);
  rect(x+250,y+16, fpsAvg[gameIndex]*factor, 20);
  fill(lightblue);
  rect(x+250,y+16, fpsMin[gameIndex]*factor, 20);

  fill(superlightblue);
  rect(x+580,y+16, BAR_WIDTH-100, 20);
  fill(red);
  rect(x+580, y+16, mapDropFrames(droppedFramesMax[gameIndex]), 20);
  fill(blue);
  rect(x+580,y+16, mapDropFrames(droppedFramesAvg[gameIndex]), 20);
  fill(green);
  rect(x+580,y+16, mapDropFrames(droppedFramesMin[gameIndex]), 20);

  fill(0);
  text(game.getString("name"), x, y);
  text(game.getJSONArray("credits").getJSONObject(0).getString("category"), x, y+20);
  text("Test", x+216,y+2);
  text("FPS", x+220,y+30);
  text("success: " + (testSuccess[gameIndex]) + "/ fail: " + testFailures[gameIndex], x+255, y+2);
  text(
    "min: " + round(fpsMin[gameIndex]*10.0)/10.0 +
    ", avg: " + round(fpsAvg[gameIndex]*10.0)/10.0 +
    ", max: " + round(fpsMax[gameIndex]*10.0)/10.0,
    x+255, y+30
  );
  text(
    "min: " + droppedFramesMin[gameIndex] +
    ", avg: " + droppedFramesAvg[gameIndex] +
    ", max: " + droppedFramesMax[gameIndex],
    x+585, y+30
  );

  text("Dropped Frames", x+580, y+10);

  stroke(220);
  line(x-10,y+55,width,y+55);
}

float mapDropFrames(int frames)
{
 return map(frames, 0, droppedFrameMaxAbsolute, 0, BAR_WIDTH-100);
}

// This function returns all the files in a directory as an array of Strings
String[] listFileNames(String dir) {
  File file = new File(dir); //<>//
  if (file.isDirectory()) {
    String names[] = file.list(); //<>//
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void initArray(float[] array, float defaultValue)
{
  for(int i=0; i<array.length; i++)
  {
    array[i]=defaultValue;
  }   
}

void initArray(int[] array, int defaultValue)
{
  for(int i=0; i<array.length; i++)
  {
    array[i]=defaultValue;
  }   
}