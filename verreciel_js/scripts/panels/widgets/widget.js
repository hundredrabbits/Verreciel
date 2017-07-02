class Widget extends Panel
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.isPowered = function(){ return false; };
    
    this.port = new ScenePortSlot(this, Alignment.center, "--");
    this.port.position.set(0,-0.7,Templates.radius);
    this.port.disable();
    this.port.label.updateScale(0.05);
    this.port.label.position.set(0,-0.35,0);
    
    this.label = new SceneLabel("", 0.075, Alignment.center);
    this.label.position.set(0,0.35,0);
    this.port.add(this.label);
    
    this.root.add(this.port);
    this.root.hide();

    this.installNode = new Empty();
    this.installProgressBar = new SceneProgressBar(1);
    this.installLabel = new SceneLabel("install", 0.075, Alignment.center, verreciel.grey);
    
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    this.refresh();
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    this.refresh();
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
    if (this.isPowered() == true)
    {
      this.onPowered();
    }
    else
    {
      this.onUnpowered();
    }
  }
  
  onUploadComplete()
  {
    assertArgs(arguments, 0);
    if (this.port.hasEvent() == false)
    {
      return;
    }
    
    if (this.port.event instanceof Item && this.port.event.type != requirement)
    {
      this.port.label.updateColor(verreciel.red);
    }
    else
    {
      this.port.label.updateColor(verreciel.white);
    }
  }
  
  // MARK: Powered
  
  onPowered()
  {
    assertArgs(arguments, 0);
    this.label.updateColor(verreciel.white);
    this.port.enable();
  }
  
  onUnpowered()
  {
    assertArgs(arguments, 0);
    this.label.updateColor(verreciel.grey);
    this.port.disable();
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin()
    
    verreciel.helmet.addWarning("Installing", 3, "install");
    
    this.installNode = new Empty();
    this.installNode.position.set(0,-0.6,Templates.radius);
    
    this.installProgressBar = new SceneProgressBar(1);
    this.installProgressBar.position.set(-this.installProgressBar.width/2,0,0);
    this.installNode.add(this.installProgressBar);
    
    this.installLabel.position.set(0,-0.35,0);
    this.installNode.add(this.installLabel);
    
    this.add(this.installNode);
  }
  
  installProgress()
  {
    assertArgs(arguments, 0);
    super.installProgress();
    this.installLabel.updateText("Install " + this.installPercentage.toFixed(0) + "%");
    this.installProgressBar.updatePercent(this.installPercentage);
  }
  
  onInstallationComplete()
  {
    assertArgs(arguments, 0);
    super.onInstallationComplete();
    
    this.installNode.removeFromParentNode();
    this.installNode.hide();
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 0.7;
    this.root.show();
    verreciel.sceneTransaction.commit();
    
    this.port.enable();
    this.label.updateText(this.name, verreciel.white);
  }
}
