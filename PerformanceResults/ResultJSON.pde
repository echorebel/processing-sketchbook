class ResultJSON {
  
  JSONObject json;
   
  ResultJSON (JSONObject _json) {  
    json = _json; 
  }
  
  JSONObject gameData(String gameId){
    JSONObject game;
    try{
     game = json.getJSONObject(gameId);
    } catch (RuntimeException e)
    {
      game = null;
    }
    return game;
  }
  
  boolean dataFound(String gameId){
    return gameData(gameId) != null;
  }
  
  String name(String game)
  {
    return gameData(game).getString("name");
  }
  
  String status(String game)
  {
    return gameData(game).getString("status");
  }
  
  JSONObject results(String game)
  {
    return gameData(game).getJSONObject("results");
  }
  
  float fps(String game)
  {
    return results(game).getFloat("fps");
  }
  
  int droppedFrames(String game)
  {
    return results(game).getInt("numStutterEvents");
  }


   
} 