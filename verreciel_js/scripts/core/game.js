class Game
{
  constructor()
  {

  }

  clear()
  {
    document.cookie.split(";").forEach(function(c) { document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); });
  }

  save()
  {
    this.clear();

    console.info("Saving..");

    // localStorage.x = verreciel.x;
  }

  load()
  {
    console.info("Loading..");

    // verreciel.x = parseFloat(localStorage.x);
  }

  is_found()
  {
    // if(localStorage.x && parseFloat(localStorage.x) > 0){
      // return true;
    // }
    return false;
  }

  reset()
  {
    console.info("New Game..");
    localStorage.clear();

    // verreciel.reset();

    return "Created a new game.";
  }
}
