class Nav extends Widget
{
  constructor()
  {
    super();
    this.name = "map";
    this.details = "disk drive";
    this.requirement = ItemTypes.map;
    this.isPowered = function() { return battery.isMapPowered(); };
    this.label.update(this.name);
  }
  
  hasMap(map)
  {
    if (this.port.hasEvent() == false)
    {
      return false;
    }
    if (this.port.event == map)
    {
      return true;
    }
    return false;
  }
  
  onUploadComplete()
  {
    super.onUploadComplete();
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-90);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    verreciel.battery.installNav();
  }
}
