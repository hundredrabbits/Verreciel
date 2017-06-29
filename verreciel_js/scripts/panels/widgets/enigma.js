class Enigma extends Widget
{
  constructor()
  {
    super();
    
    this.name = "enigma";
    this.details = "extra";
    this.requirement = ItemTypes.cypher;
    this.isPowered = function() { return verreciel.battery.isEnigmaPowered(); };
    this.label.update(this.name);
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    verreciel.battery.installEnigma();
  }
}
