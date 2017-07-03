class LocationPortal extends Location
{
  constructor(name, system, at)
  {
    assertArgs(arguments, 3);
    super(name,system, at, new IconPortal(), new StructurePortal());
    
    this.details = "transit";
    this.keyLabel = new SceneLabel("input key", 0.1, Alignment.center, verreciel.white);
    this.destinationLabel = new SceneLabel("--", 0.08, Alignment.center, verreciel.grey);
    this.pilotPort = new ScenePort(this);
    this.pilotLabel = new SceneLabel("pilot", 0.1, Alignment.center, verreciel.grey);
    this.thrusterPort = new ScenePort(this);
    this.thrusterLabel = new SceneLabel("thruster", 0.08, Alignment.center, verreciel.grey);
    this.isPortEnabled = true;
  }
  
  // MARK: Panel - 
  
  panel()
  {
    assertArgs(arguments, 0);
    let newPanel = new Panel();
    
    this.pilotPort.add(this.pilotLabel);
    this.thrusterPort.add(this.thrusterLabel);
    
    newPanel.add(this.keyLabel);
    newPanel.add(this.pilotPort);
    newPanel.add(this.thrusterPort);
    
    this.keyLabel.position.set(0,0.75,0);
    this.keyLabel.add(this.destinationLabel);
    this.destinationLabel.position.set(0,-0.4,0);;
    
    this.pilotPort.position.set(0.8,-0.4,0);
    this.pilotLabel.position.set(0,-0.4,0);
    
    this.thrusterPort.position.set(-0.8,-0.4,0);
    this.thrusterLabel.position.set(0,-0.4,0);
    
    newPanel.add(new SceneLine([new THREE.Vector3(0.8,-0.275,0), new THREE.Vector3(0.8,-0.1,0),], verreciel.grey));
    newPanel.add(new SceneLine([new THREE.Vector3(-0.8,-0.275,0), new THREE.Vector3(-0.8,-0.1,0),], verreciel.grey));
    newPanel.add(new SceneLine([new THREE.Vector3(0.8,-0.1,0), new THREE.Vector3(-0.8,-0.1,0),], verreciel.grey));
    
    newPanel.add(new SceneLine([new THREE.Vector3(0,0.1,0), new THREE.Vector3(0,-0.1,0),], verreciel.grey));
    
    this.thrusterPort.addEvent(verreciel.items.warpDrive);
    
    return newPanel;
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    this.validate();
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    this.validate();
  }
  
  onDock()
  {
    assertArgs(arguments, 0);
    super.onDock();
    
    this.validate();
  }
  
  onWarp()
  {
    assertArgs(arguments, 0);
    if (this.structure instanceof StructurePortal)
    {
      this.structure.isWarping = true;
      this.structure.onWarp();
    }
  }
  
  validate()
  {
    assertArgs(arguments, 0);
    if (verreciel.intercom.port.isReceivingItemOfType(ItemTypes.key) == true)
    {
      let item = verreciel.intercom.port.origin.event;
      if (item instanceof Item && (item.location == null || item.location == verreciel.capsule.lastLocation))
      {
        this.inactive();
      }
      else
      {
        this.unlock();
      }
    }
    else
    {
      this.lock();
    }
  }
  
  inactive()
  {
    assertArgs(arguments, 0);
    this.pilotPort.removeEvent();
    this.pilotPort.disable();
    this.thrusterPort.disable();
    this.keyLabel.updateText("error", verreciel.red);
    
    this.structure.root.updateChildrenColors(verreciel.red);
  }
  
  lock()
  {
    assertArgs(arguments, 0);
    this.pilotPort.removeEvent()
    this.pilotPort.disable()
    this.thrusterPort.disable()
    this.keyLabel.updateText("no key", verreciel.red);
    
    if (this.structure instanceof StructurePortal)
    {
      this.structure.onLock();
    }
  }
  
  unlock()
  {
    assertArgs(arguments, 0);
    let key = verreciel.intercom.port.origin.event;

    if (!(key instanceof Item))
    {
      return;
    }

    let destination = verreciel.universe.locationLike(key.location);
    
    destination.isKnown = true;
    
    this.keyLabel.updateText(key.name, verreciel.cyan);
    this.destinationLabel.updateText("to " + destination.system + " " + destination.name);
    
    this.pilotPort.addEvent(destination);
    this.pilotPort.enable();
    this.thrusterPort.enable();
    
    if (this.structure instanceof StructurePortal)
    {
      this.structure.onUnlock();
    }
  }
}

class IconPortal extends Icon
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    this.color = verreciel.white;
    
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
      new THREE.Vector3(0.075,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(-0.075,0,0),
    ], this.color));
    this.size = 0.05;
    this.mesh.add(new SceneLine([
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(this.size,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(-this.size,0,0), 
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(0,-this.size,0),
    ], this.color));
  }
}

class StructurePortal extends Structure
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    this.isWarping = false;
    
    this.root.position.set(0,10,0);
    
    let nodes = 52;
    var i = 0
    while (i < nodes)
    {
      let node = new Empty();
      let line = new SceneLine([new THREE.Vector3(2,2,0), new THREE.Vector3(0,0,10)], verreciel.red);
      line.position.set(-2,0,0);;
      node.add(line);
      this.root.add(node);
      node.rotation.y = degToRad(i * 360/nodes);
      i += 1;
    }
  }
  
  onSight()
  {
    assertArgs(arguments, 0);
    super.onSight();
    
    this.onLock();
  }
  
  onWarp()
  {
    assertArgs(arguments, 0);
    this.root.updateChildrenColors(verreciel.cyan);
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 1.5;
    
    for (let node of this.root.children)
    {
      node.children[0].position.set(2,1,2);
    }
    
    verreciel.sceneTransaction.commit();
  }
  
  onUnlock()
  {
    assertArgs(arguments, 0);   
    this.root.updateChildrenColors(verreciel.cyan);
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      node.children[0].position.set(0,0,0);
    }
    
    verreciel.sceneTransaction.commit();
  }
  
  onLock()
  {
    assertArgs(arguments, 0);
    if (this.isWarping == true)
    {
      return;
    }
    
    this.root.updateChildrenColors(verreciel.red);
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      node.children[0].position.set(-2,0,0);
    }
    
    verreciel.sceneTransaction.commit();
  }
  
  onLeave()
  {
    assertArgs(arguments, 0);
    super.onLeave();
    
    this.isWarping = false;
  }
}
