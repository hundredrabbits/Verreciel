class Progress extends Monitor
{
  constructor()
  {
    super();
    this.completed = 0;
    this.name = "map";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    
    this.nameLabel.update("--");
    this.detailsLabel.update(this.name);
  }
  
  refresh()
  {
    super.refresh();
    
    var totalQuestLocations = 0;
    var totalQuestLocations_complete = 0;
    
    for (let location of verreciel.universe.allLocations)
    {
      if (location.isComplete != null)
      {
        totalQuestLocations += 1;
        if (location.isComplete == true)
        {
          totalQuestLocations_complete += 1;
        }
      }
    }
    
    // MARK: Display
    if (totalQuestLocations_complete > this.completed)
    {
      this.nameLabel.update(totalQuestLocations_complete + "/" + totalQuestLocations, verreiciel.cyan);
      delay(2, function() { this.nameLabel.update(verreiciel.white); }.bind(this));
      this.completed = totalQuestLocations_complete;
    }
  }
}
