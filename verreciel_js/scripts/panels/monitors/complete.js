class Complete extends Monitor
{
  constructor()
  {
    super();

    this.distance = 0;
    this.name = "missions";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    this.nameLabel.update("--");
    this.detailsLabel.update(this.name);
  }
  
  refresh()
  {
    super.refresh();
    this.nameLabel.update(missions.currentMission.id + "/" + missions.story.count);
  }
}
