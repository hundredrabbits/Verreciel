class Radio extends Widget
{
  constructor()
  {
    super();

    this.seek = 0;
    this.name = "radio";
    this.details = "format reader";
    this.requirement = ItemTypes.record;
    this.isPowered = function() { return verreciel.battery.isRadioPowered(); };
    
    this.label.update(this.name);
  }
  
  isPlaying()
  {
    if (this.port.hasItemOfType(ItemTypes.record))
    {
      return true;
    }
    return false;
  }
  
  onPowered()
  {
    super.onPowered()
    if (this.port.hasItemOfType(ItemTypes.record))
    {
      this.play();
    }
  }
  
  onUnpowered()
  {
    super.onUnpowered();
    this.stop();
  }
  
  play()
  {
    if ((this.port.event instanceof Item) == false)
    {
      return;
    }
    if (this.port.event.type != ItemTypes.record)
    {
      return;
    }
    verreciel.music.playRecord(this.port.event.code);
    verreciel.music.pauseAmbient();
  }
  
  stop()
  {
    verreciel.music.pauseRecord();
    verreciel.space.onSystemEnter(verreciel.capsule.system);
  }
  
  onUploadComplete()
  {
    super.onUploadComplete();
    
    if (verreciel.battery.isRadioPowered() == true)
    {
      this.play();
    }
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    verreciel.player.lookAt(0);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    verreciel.battery.installRadio();
  }
}
