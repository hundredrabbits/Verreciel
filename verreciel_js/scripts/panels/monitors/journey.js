class Journey extends Monitor
{
  constructor()
  {
    super()
    this.distance = 0;
    this.name = "journey";
    this.rotation.x = degToRad(Templates.monitorsAngle);
    this.nameLabel.update("--");
    this.detailsLabel.update(this.name);
  }
  
  whenSecond()
  {
    super.whenSecond();
    this.nameLabel.update(Math.floor(this.distance / 100).toString());
  }
}
