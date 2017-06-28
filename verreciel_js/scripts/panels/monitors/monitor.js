class Monitor extends Panel
{
  constructor()
  {
    super();

    this.nameLabel = new SceneLabel("", 0.08, Alignment.center)
    this.detailsLabel = new SceneLabel("", 0.04, Alignment.center, verreciel.grey);

    this.name = "";
    this.root.position.set(0,0,Templates.radius);
    this.nameLabel.position.set(0,0,0);
    this.root.add(this.nameLabel);
    
    this.detailsLabel.position.set(0,0.2,0);
    this.root.add(this.detailsLabel);
    
    this.nameLabel.hide();
    this.detailsLabel.hide();
    
    this.detailsLabel.update("");
    this.nameLabel.update("--");

    this.installNode = new Empty();
    this.installProgressBar = new SceneProgressBar(1);
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    this.installNode = new Empty();
    this.installNode.position.set(0,0,0);
    this.installProgressBar = new SceneProgressBar(0.5);
    this.installProgressBar.position.set(-0.25,-0.2,0);
    this.installProgressBar.hide();
    this.installNode.add(this.installProgressBar);
    this.root.add(this.installNode);
  }
  
  installProgress()
  {
    super.installProgress();
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    // this.nameLabel.show();
    // this.detailsLabel.show();
    // SCNTransaction.completionBlock = { self.refresh() }
    // SCNTransaction.commit()
    
    this.installNode.removeFromParentNode();
  }
}
