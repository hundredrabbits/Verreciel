class LocationStation extends Location
{
  constructor(name, system, at = new THREE.Vector2(), requirement = null, installation, installationName, mapRequirement = null)
  {
    super(name,system, at, new IconStation(), new StructureStation());
    
    this.installation = installation;
    this.requirement = requirement;
    this.installationName = installationName;
    this.details = installationName;
    this.mapRequirement = mapRequirement;
    this.isComplete = false;
  }
  
  panel()
  {
    let newPanel = new Panel();
    
    let requirementLabel = new SceneLabel("Exchange " + this.requirement.name + "$install the " + this.installationName);
    requirementLabel.position.set(Templates.leftMargin,Templates.topMargin-0.3,0);
    newPanel.add(requirementLabel);
    
    this.button = new SceneButton(this, "install", 1);
    this.button.position.set(0,-1,0);
    newPanel.add(this.button);
    
    this.port = new ScenePortSlot(this);
    this.port.position.set(0,-0.2,0);
    newPanel.add(this.port);
    
    this.tradeLabel = new SceneLabel("trade", Alignment.right, verreciel.grey);
    this.tradeLabel.position.set(-0.3,0,0);
    this.port.add(this.tradeLabel);
    
    this.button.disableAndShow("install");
    this.port.enable();
    
    return newPanel;
  }
  
  onUploadComplete()
  {
    if (this.port.hasEvent() == false)
    {
      this.tradeLabel.update(verreciel.grey);
      return;
    }
    
    let trade = this.port.event;
    if (trade instanceof Item && trade.name == this.requirement.name && trade.type == this.requirement.type)
    {
      this.button.enableAndShow("install");
      this.tradeLabel.update(verreciel.cyan);
    }
    else
    {
      this.tradeLabel.update(verreciel.red);
    }
  }
  
  touch(id)
  {
    super.touch(id);
    if (id == 1)
    {
      this.installation();
      this.onComplete();
    }
    return true;
  }
}

class IconStation extends Icon
{
  constructor()
  {
    super();
    
    this.mesh.add(new SceneLine([
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(this.size,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(-this.size,0,0), 
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(this.size,0,0)
    ], this.color));
  }
}

class StructureStation extends Structure
{
  constructor()
  {
    super();
    
    this.root.position.set(0,5,0);
    
    let nodes = 4 + Math.random() * 4;
    var i = 0;
    while (i < nodes)
    {
      let axis = new Empty();
      axis.rotation.y = degToRad(i * 360/nodes);
      
      let node = new Hexagon(4, verreciel.red);
      node.rotation.x = degToRad(90);
      let node1 = new Hexagon(4, verreciel.red);
      node1.rotation.y = degToRad(90);
      
      axis.add(node);
      node.add(node1);
      this.root.add(axis);
      i += 1;
    }
  }
  
  onSight()
  {
    super.onSight();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   node.rotation.x = degToRad(0);
    // }
    
    // SCNTransaction.commit()
  }
  
  onUndock()
  {
    super.onUndock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   node.rotation.x = degToRad(45);
    // }
    
    // SCNTransaction.commit()
  }
  
  onDock()
  {
    super.onDock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   node.rotation.x = degToRad(45);
    // }
    
    // SCNTransaction.commit()
  }
  
  onComplete()
  {
    super.onComplete();
    
    this.updateChildrenColors(verreciel.cyan);
  }
  
  sightUpdate()
  {
    this.root.rotation.y += degToRad(0.1);
  }
  
  morph()
  {
    super.morph();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // let deg1 = 22.5 * ((morphTime * 123) % 8) % 180;
    // let deg2 = 22.5 * ((morphTime * 678) % 6) % 180;
    
    // for (let node of this.root.children)
    // {
    //   for (let subnode of node.children)
    //   {
    //     subnode.rotation.z = degToRad(deg1 - deg2);
    //     subnode.position.y = (2 - ((morphTime * 0.34) % 4)) * 0.6;
    //   }
    // }
    
    // SCNTransaction.commit()
  }
}
