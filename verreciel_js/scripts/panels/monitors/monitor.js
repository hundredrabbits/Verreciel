class Monitor extends Panel
{
  constructor()
  {
    // assertArgs(arguments, 0);
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
    
    this.detailsLabel.updateText("");
    this.nameLabel.updateText("--");

    this.installNode = new Empty();
    this.installProgressBar = new SceneProgressBar(1);
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    // assertArgs(arguments, 0);
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
    // assertArgs(arguments, 0);
    super.installProgress();
  }
  
  onInstallationComplete()
  {
    // assertArgs(arguments, 0);
    super.onInstallationComplete();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    this.nameLabel.show();
    this.detailsLabel.show();
    verreciel.animator.completionBlock = function(){ this.refresh() }.bind(this);
    verreciel.animator.commit();
    
    this.installNode.removeFromParentNode();
  }
}
