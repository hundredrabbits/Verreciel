class Exploration extends Monitor
{
  constructor()
  {
    super();

    this.distance = 0;
    this.knownLocations = 0;
    
    this.name = "exploration";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    
    this.nameLabel.update("--");
    this.detailsLabel.update(this.name);
  }
  
  refresh()
  {
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
      this.nameLabel.update(this.knownLocations + "/" + verreciel.universe.allLocations.length, verreciel.cyan);
      delay(2, function() { this.nameLabel.update(verreciel.white); }.bind(this));
    }
  }
  
  whenSecond()
  {
    this.refresh();
  }
}
