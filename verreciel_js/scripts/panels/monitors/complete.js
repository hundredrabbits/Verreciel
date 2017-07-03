class Complete extends Monitor
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.distance = 0;
    this.name = "missions";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    this.nameLabel.updateText("--");
    this.detailsLabel.updateText(this.name);
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
    super.refresh();
    this.nameLabel.updateText(missions.currentMission.id + "/" + missions.story.length);
  }
}
