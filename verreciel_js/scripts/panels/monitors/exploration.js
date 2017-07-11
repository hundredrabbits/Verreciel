class Exploration extends Monitor
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();

    this.distance = 0;
    this.knownLocations = 0;
    
    this.name = "exploration";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    
    this.nameLabel.updateText("--");
    this.detailsLabel.updateText(this.name);
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    super.refresh();
    
    var kl = 0;
    for (let location of verreciel.universe.allLocations)
    {
      if (location.isKnown == true)
      {
        kl += 1;
      }
    }
    
    // MARK: Display
    if (kl > this.knownLocations)
    {
      this.knownLocations = kl;
      this.nameLabel.updateText(this.knownLocations + "/" + verreciel.universe.allLocations.length, verreciel.cyan);
      delay(2, function() { this.nameLabel.color = verreciel.white; }.bind(this));
    }
  }
  
  whenSecond()
  {
    // assertArgs(arguments, 0);
    this.refresh();
  }
}
