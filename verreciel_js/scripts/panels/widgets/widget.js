class Widget extends Panel
{
  constructor()
  {
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
    this.refresh();
  }
  
  onDisconnect()
  {
    this.refresh();
  }
  
  refresh()
  {
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
    if (this.port.hasEvent() == false)
    {
      return;
    }
    
    if (this.port.event instanceof Item && this.port.event.type != requirement)
    {
      this.port.label.update(verreciel.red);
    }
    else
    {
      this.port.label.update(verreciel.white);
    }
  }
  
  // MARK: Powered
  
  onPowered()
  {
    this.label.update(verreciel.white);
    this.port.enable();
  }
  
  onUnpowered()
  {
    this.label.update(verreciel.grey);
    this.port.disable();
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
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
    super.installProgress();
    this.installLabel.update("Install " + this.installPercentage.toFixed(0) + "%");
    this.installProgressBar.update(this.installPercentage);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    
    this.installNode.removeFromParentNode();
    this.installNode.hide();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.7
    // this.root.show();
    // SCNTransaction.commit()
    
    this.port.enable();
    this.label.update(this.name, verreciel.white);
  }
}
