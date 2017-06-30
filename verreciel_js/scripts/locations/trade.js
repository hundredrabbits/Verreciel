class LocationTrade extends Location
{
  constructor(name = "", system, at = new THREE.Vector(), want, give, mapRequirement = null)
  {
    super( name, system, at, new IconTrade(), new StructureTrade());
    
    this.details = give.name;
    
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
    this.isTradeAccepted = false;
    
    this.wantPort = new ScenePortSlot(this);
    this.wantPort.addRequirement(want);
    this.wantPort.label.update("EMPTY", verreciel.red);
    this.givePort = new ScenePortSlot(this);
    this.givePort.addEvent(give);
  }
  
  whenStart()
  {
    super.whenStart();
    this.refresh();
  }
  
  // MARK: Panels -
  
  panel()
  {
    if (this.isComplete == true)
    {
      return null;
    }
    
    let newPanel = new Panel();
    
    let text = new SceneLabel("Trading " + this.wantPort.requirement.name + "$For " + this.givePort.event.name, Alignment.left);
    text.position.set(-1.5,1,0);
    newPanel.add(text);
    
    // Want
    
    this.wantPort.position.set( -1.2,  -0.6,  0);
    this.wantPort.enable();
    newPanel.add(this.wantPort);
    
    // Give
    this.givePort.position.set(0,  -0.5,  0);
    this.wantPort.add(this.givePort);
    
    this.wantPort.add(new SceneLine([new THREE.Vector3(-0.125,0,0), new THREE.Vector3(-0.3,0,0)], verreciel.grey));
    this.wantPort.add(new SceneLine([new THREE.Vector3(-0.3,0,0), new THREE.Vector3(-0.3,-0.5,0)], verreciel.grey));
    this.wantPort.add(new SceneLine([new THREE.Vector3(-0.3,-0.5,0), new THREE.Vector3(-0.125,-0.5,0)], verreciel.grey));
    
    let wantLabel = new SceneLabel("Trade Table", verreciel.grey);
    wantLabel.position.set( -1.5,  0,  0);
    newPanel.add(wantLabel);
    
    this.givePort.disable();
    
    return newPanel;
  }
  
  onUploadComplete()
  {
    refresh()
    audio.playSound("beep2")
  }
  
  onDisconnect()
  {
    refresh()
  }
  
  refresh()
  {
    if (this.wantPort.event != null && this.wantPort.event.name == this.wantPort.requirement.name)
    {
      this.wantPort.disable();
      this.wantPort.label.update("Accepted",verreciel.cyan);
      this.givePort.enable();
      this.givePort.label.update(verreciel.white);
      this.isTradeAccepted = true;
    }
    else if (this.wantPort.event != null && this.wantPort.event.name != this.wantPort.requirement.name)
    {
      this.wantPort.enable();
      this.wantPort.label.update("Refused",verreciel.red);
      this.givePort.disable();
      this.isTradeAccepted = false;
    }
    else
    {
      this.wantPort.enable();
      this.wantPort.label.update("Empty",verreciel.red);
      this.givePort.disable();
      this.isTradeAccepted = false;
    }
    
    if (this.givePort.event == null)
    {
      this.onComplete();
    }
  }
}

class IconTrade extends Icon
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
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(0,-this.size,0),
    ], this.color));
  }
}

class StructureTrade extends Structure
{
  constructor()
  {
    super();
    
    this.root.position.set(0,5,0);
    
    let value1 = 3;
    let value2 = 5;
    
    let nodes = 24;
    var i = 0;
    while (i < nodes)
    { 
      let node = new Empty();
      
      node.add(new SceneLine([
        new THREE.Vector3(-value2,value1 * i,0), 
        new THREE.Vector3(0,value1 * i,value2), 
        new THREE.Vector3(0,value1 * i,value2), 
        new THREE.Vector3(value2,value1 * i,0), 
        new THREE.Vector3(value2,value1 * i,0), 
        new THREE.Vector3(0,value1 * i + 2,-value2), 
        new THREE.Vector3(0,value1 * i + 2,-value2), 
        new THREE.Vector3(-value2,value1 * i,0),
      ], verreciel.red));
      
      this.root.add(node);
      i += 1;
    }
  }
  
  onSight()
  {
    super.onSight();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // var i = 0;
    // for (let node of this.root.children)
    // {
    //   node.rotation.y = degToRad(i * 360/nodes);
    //   i += 1;
    // }
    
    // SCNTransaction.commit()
  }
  
  onUndock()
  {
    super.onUndock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    var i = 0;
    // for (let node of this.root.children)
    // {
      // node.rotation.y = degToRad(i * 360/nodes);
      // i += 1;
    // }
    
    // SCNTransaction.commit()
  }
  
  onDock()
  {
    super.onDock()
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
      // node.rotation.y = 0;
    // }
    
    // SCNTransaction.commit()
  }
  
  onComplete()
  {
    super.onComplete();
  }
  
  sightUpdate()
  {
    this.root.rotation.y += degToRad(0.1);
  }
}
