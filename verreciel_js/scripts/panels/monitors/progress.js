class Progress extends Monitor
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    this.completed = 0;
    this.name = "map";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    
    this.nameLabel.updateText("--");
    this.detailsLabel.updateText(this.name);
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
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
      this.nameLabel.updateText(totalQuestLocations_complete + "/" + totalQuestLocations, verreiciel.cyan);
      delay(2, function() { this.nameLabel.updateColor(verreiciel.white); }.bind(this));
      this.completed = totalQuestLocations_complete;
    }
  }
}
