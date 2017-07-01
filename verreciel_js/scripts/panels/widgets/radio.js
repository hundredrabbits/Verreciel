class Radio extends Widget
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.seek = 0;
    this.name = "radio";
    this.details = "format reader";
    this.requirement = ItemTypes.record;
    this.isPowered = function() { return verreciel.battery.isRadioPowered(); };
    
    this.label.updateText(this.name);
  }
  
  isPlaying()
  {
    assertArgs(arguments, 0);
    if (this.port.hasItemOfType(ItemTypes.record))
    {
      return true;
    }
    return false;
  }
  
  onPowered()
  {
    assertArgs(arguments, 0);
    super.onPowered()
    if (this.port.hasItemOfType(ItemTypes.record))
    {
      this.play();
    }
  }
  
  onUnpowered()
  {
    assertArgs(arguments, 0);
    super.onUnpowered();
    this.stop();
  }
  
  play()
  {
    assertArgs(arguments, 0);
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
    assertArgs(arguments, 0);
    verreciel.music.pauseRecord();
    verreciel.space.onSystemEnter(verreciel.capsule.system);
  }
  
  onUploadComplete()
  {
    assertArgs(arguments, 0);
    super.onUploadComplete();
    
    if (verreciel.battery.isRadioPowered() == true)
    {
      this.play();
    }
  }
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    verreciel.player.lookAt(0);
  }
  
  onInstallationComplete()
  {
    assertArgs(arguments, 0);
    super.onInstallationComplete();
    verreciel.battery.installRadio();
  }
}
