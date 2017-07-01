class MainPanel extends Panel
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.installNode = new Empty();
    this.installProgressBar = new SceneProgressBar(1);
    this.installLabel = new SceneLabel("install", 0.1, Alignment.center, verreciel.grey);

    this.nameLabel = new SceneLabel("", 0.1, Alignment.center);
    this.detailsLabel = new SceneLabel("", 0.085, Alignment.center);
    this.header = new Empty();
    this.footer = new Empty();
    this.mainNode = new Empty();
    this.decals = new Empty();
    
    this.name = "unknown";
    this.details = "unknown";
    this.root.position.set(0, 0, Templates.radius);
    this.root.add(this.mainNode);
    this.root.add(this.decals);
    
    // Header
    this.port = new ScenePort(this);
    this.port.position.set(0, 0.4, Templates.radius);
    this.nameLabel.position.set(0, 0, Templates.radius);
    this.header.add(this.port);
    this.header.add(this.nameLabel);
    this.add(this.header);
    this.header.rotation.x += degToRad(Templates.titlesAngle);
    
    // Footer
    this.detailsLabel.position.set(0, 0, Templates.radius);
    this.footer.add(this.detailsLabel);
    this.add(this.footer);
    this.footer.rotation.x = degToRad(-Templates.titlesAngle);
    
    // Decals
    
    this.width = 1.65;
    this.height = 1.8;
    
    this.decals.add(new SceneLine([
      new THREE.Vector3(this.width + 0.2, this.height - 0.2, 0),
      new THREE.Vector3(this.width, this.height, 0),
      new THREE.Vector3(this.width + 0.2, this.height - 0.2, 0),
      new THREE.Vector3(this.width + 0.2, -this.height + 0.2, 0),
      new THREE.Vector3(this.width + 0.2, -this.height + 0.2, 0),
      new THREE.Vector3(this.width, -this.height, 0)
    ],
    verreciel.grey));
    this.decals.add(new SceneLine([
      new THREE.Vector3(-this.width - 0.2, this.height - 0.2, 0),
      new THREE.Vector3(-this.width, this.height, 0),
      new THREE.Vector3(-this.width - 0.2, -this.height + 0.2, 0),
      new THREE.Vector3(-this.width, -this.height, 0),
      new THREE.Vector3(-this.width - 0.2, this.height - 0.2, 0),
      new THREE.Vector3(-this.width - 0.2, -this.height + 0.2, 0)
    ],
    verreciel.grey));
    
    // Start
    
    this.mainNode.hide();
    this.decals.hide();
    this.footer.hide();
    
    this.nameLabel.updateText("--", verreciel.grey);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    
    this.decals.hide();
    this.mainNode.hide();
    this.nameLabel.updateText("--", verreciel.grey);
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.helmet.addWarning("Installing", 3, "install");
    
    this.installNode = new Empty();
    this.installNode.position.set(0,0,0);
    this.installProgressBar = SceneProgressBar(1);
    this.installProgressBar.position.set(-this.installProgressBar.width/2,-0.3,0);
    this.installProgressBar.show();
    this.installNode.add(this.installProgressBar);
    
    this.installNode.add(this.installLabel);
    
    this.root.add(this.installNode);
  }
  
  installProgress()
  {
    assertArgs(arguments, 0);
    super.installProgress();
    
    this.installLabel.updateText("Install " + this.installPercentage.toFixed(0) + "%");
    this.installProgressBar.update(this.installPercentage);
  }
  
  onInstallationComplete()
  {
    assertArgs(arguments, 0);
    super.onInstallationComplete();
    
    this.mainNode.position.set(0,0,-0.2);
    this.mainNode.hide();
    this.decals.position.set(0,0,-0.4);
    this.decals.hide();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.7
    // this.mainNode.position.set(0,0,0);
    // this.mainNode.show();
    // this.decals.position.set(0,0,0);
    // this.decals.show();
    // footer.show()
    // SCNTransaction.commit()
    
    this.installNode.removeFromParentNode();
    
    this.port.enable();
    this.nameLabel.updateText(name, verreciel.white);
  }
}
