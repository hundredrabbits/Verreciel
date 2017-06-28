class Panel extends Empty
{
  constructor()
  {
    super()
    this.isEnabled = false;
    this.root = new Empty();
    this.add(this.root);
    this.isInstalled = false;
    this.installPercentage = 0;
  }
  
  refresh()
  {
    
  }
  
  enable()
  {
    this.isEnabled = true;
  }
  
  disable()
  {
    this.isEnabled = false;
  }
  
  // MARK: Installation -
  
  install()
  {
    if (isInstalled == true)
    {
      return;
    }
    
    this.onInstallationBegin();
    this.installProgress();
  }
  
  installProgress()
  {
    this.installPercentage += Math.random(60) / 10;
    
    if (this.installPercentage > 100) {
      this.onInstallationComplete();
    }
    else
    {
      delay(0.05, this.installProgress.bind(this));
    }
  }

  onInstallationBegin()
  {
    verreciel.music.playEffect("beep1");
  }
  
  onInstallationComplete()
  {
    this.installPercentage = 0;
    this.isInstalled = true;
    verreciel.music.playEffect("beep2");
  }
  
  payload()
  {
    return new ConsolePayload([new ConsoleData("Capsule", "Panel"), new ConsoleData(this.details)]);
  }
}
