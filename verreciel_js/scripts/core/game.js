function Game()
{
  this.clear = function()
  {
    document.cookie.split(";").forEach(function(c) { document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); });
  }

  this.save = function()
  {
    this.clear();

    console.info("Saving..");

    // localStorage.x = verreciel.x;
  }

  this.load = function()
  {
    console.info("Loading..");

    // verreciel.x = parseFloat(localStorage.x);
  }

  this.is_found = function()
  {
    // if(localStorage.x && parseFloat(localStorage.x) > 0){
      // return true;
    // }
    return false;
  }

  this.new = function()
  {
    console.info("New Game..");
    localStorage.clear();

    // verreciel.reset();

    return "Created a new game.";
  }
}
