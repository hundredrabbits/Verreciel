class LocationStar extends Location
{
  constructor(name, system, at)
  {
    assertArgs(arguments, 3);
    super(name, system, at, new IconStar(), new StructureStar());
    this.isComplete = false
    this.masterPort = new ScenePort(this);
  }
  
  panel()
  {
    assertArgs(arguments, 0);
    let newPanel = new Panel();
    
    let requirementLabel = new SceneLabel("the melting core$welcomes you.");
    requirementLabel.position.set(Templates.leftMargin,Templates.topMargin-0.3,0);
    newPanel.add(requirementLabel);
    
    this.button = new SceneButton(this, "install", 1, 1);
    this.button.position.set(0,-1,0);
    newPanel.add(this.button);
    
    this.masterPort.position.set(-0,-0.3,0);
    
    this.masterPort.enable();
    
    newPanel.add(this.masterPort);
    
    this.button.disable();
    this.button.updateText("extinguish");
    
    return newPanel;
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    if (this.masterPort.isReceiving(verreciel.items.endPortalKey) == true)
    {
      this.button.enable();
      this.button.updateText("extinguish");
    }
  }
  
  sightUpdate()
  {
    assertArgs(arguments, 0);
    let radiation = (1 - (this.distance/0.7))/0.6;
    
    if (verreciel.capsule.hasShield() == false)
    {
      if (radiation > 1 && verreciel.capsule.isFleeing == false)
      {
        verreciel.capsule.flee();
      }
      verreciel.capsule.radiation = radiation;
    }
  }
  
  onApproach()
  {
    assertArgs(arguments, 0);
    if (verreciel.capsule.hasShield() == true)
    {
      super.onApproach();
    }
    else
    {
      verreciel.space.startInstance(this);
    }
  }
  
  touch(id)
  {
    assertArgs(arguments, 1);
    super.touch(id);
    if (id == 1)
    { this.extinguish();
      verreciel.music.playEffect("click3");
    }
    return true;
  }
  
  extinguish()
  {
    assertArgs(arguments, 0);
    this.onComplete();
  }
  
  onComplete()
  {
    assertArgs(arguments, 0);
    super.onComplete();
    
    verreciel.space.onSystemEnter(verreciel.capsule.system);
    verreciel.universe.closeSystem(this.system);
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
  }
}

class IconStar extends Icon
{
  constructor()
  {
    assertArgs(arguments, 0);
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
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(this.size * 2,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(-this.size * 2,0,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(0,this.size * 2,0), 
      new THREE.Vector3(0,-this.size,0),  
      new THREE.Vector3(0,-this.size * 2,0), 
      new THREE.Vector3(this.size/2,this.size/2,0),  
      new THREE.Vector3(this.size,this.size,0), 
      new THREE.Vector3(-this.size/2,this.size/2,0),  
      new THREE.Vector3(-this.size,this.size,0), 
      new THREE.Vector3(this.size/2,-this.size/2,0),  
      new THREE.Vector3(this.size,-this.size,0), 
      new THREE.Vector3(-this.size/2,-this.size/2,0),  
      new THREE.Vector3(-this.size,-this.size,0),
    ], this.color));
  }
}

class StructureStar extends Structure
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    this.root.position.set(0,5,0);
    
    var i = 0;
    while (i < 20)
    {
      let shape = new Octogon(new THREE.Vector2(i * 0.3), verreciel.red);
      shape.rotation.y = degToRad(22.5);
      this.root.add(shape);
      i += 1;
    }
  }
  
  onDock()
  {
    assertArgs(arguments, 0);
    super.onDock();
    
    // TODO: SCNTransaction

    SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // var i = 0;
    // for (let node of this.root.children)
    // {
      // node.rotation.y = degToRad(i * (90/this.root.children.count));
      // i += 1;
    // }
    
    // SCNTransaction.commit()
  }
  
  sightUpdate()
  {
    assertArgs(arguments, 0);
    super.sightUpdate();
    this.root.rotation.y += degToRad(0.1);
  }
  
  onUndock()
  {
    assertArgs(arguments, 0);
    super.onDock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
      // node.position.y = 0;
      // node.rotation.y = 0;
    // }
    
    // SCNTransaction.commit()
  }
  
  onComplete()
  {
    assertArgs(arguments, 0);
    super.onComplete()
    
    this.root.updateChildrenColors(cyan)
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // var i = 0;
    // for (let node of this.root.children)
    // {
    //   node.position.y = -i * 0.05;
    //   i += 1;
    //   node.rotation.y = 0;
    // }
    
    // SCNTransaction.commit()
  }
}
