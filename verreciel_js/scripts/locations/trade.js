class LocationTrade extends Location
{
  constructor(name, system, at, want, give, mapRequirement = null)
  {
    assertArgs(arguments, 5);
    super( name, system, at, new IconTrade(), new StructureTrade());
    
    this.details = give.name;
    
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
    this.isTradeAccepted = false;
    
    this.wantPort = new ScenePortSlot(this);
    this.wantPort.addRequirement(want);
    this.wantPort.label.updateText("EMPTY", verreciel.red);
    this.givePort = new ScenePortSlot(this);
    this.givePort.addEvent(give);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    this.refresh();
  }
  
  // MARK: Panels -
  
  panel()
  {
    assertArgs(arguments, 0);
    if (this.isComplete == true)
    {
      return null;
    }
    
    let newPanel = new Panel();
    
    let text = new SceneLabel("Trading " + this.wantPort.requirement.name + "$For " + this.givePort.event.name, 0.1, Alignment.left);
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
    
    let wantLabel = new SceneLabel("Trade Table", 0.1, Alignment.left, verreciel.grey);
    wantLabel.position.set( -1.5,  0,  0);
    newPanel.add(wantLabel);
    
    this.givePort.disable();
    
    return newPanel;
  }
  
  onUploadComplete()
  {
    assertArgs(arguments, 0);
    this.refresh()
    verreciel.music.playEffect("beep2")
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    this.refresh();
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
    if (this.wantPort.event != null && this.wantPort.event.name == this.wantPort.requirement.name)
    {
      this.wantPort.disable();
      this.wantPort.label.updateText("Accepted",verreciel.cyan);
      this.givePort.enable();
      this.givePort.label.updateColor(verreciel.white);
      this.isTradeAccepted = true;
    }
    else if (this.wantPort.event != null && this.wantPort.event.name != this.wantPort.requirement.name)
    {
      this.wantPort.enable();
      this.wantPort.label.updateText("Refused",verreciel.red);
      this.givePort.disable();
      this.isTradeAccepted = false;
    }
    else
    {
      this.wantPort.enable();
      this.wantPort.label.updateText("Empty",verreciel.red);
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
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(0,-this.size,0),
    ], this.color));
  }
}

class StructureTrade extends Structure
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    this.root.position.set(0,5,0);
    
    let value1 = 3;
    let value2 = 5;
    
    this.nodes = 24;
    var i = 0;
    while (i < this.nodes)
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
    assertArgs(arguments, 0);
    super.onSight();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    var i = 0;
    for (let node of this.root.children)
    {
      node.rotation.y = degToRad(i * 360/this.nodes);
      i += 1;
    }
    
    verreciel.animator.commit();
  }
  
  onUndock()
  {
    assertArgs(arguments, 0);
    super.onUndock();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    var i = 0;
    for (let node of this.root.children)
    {
      node.rotation.y = degToRad(i * 360/this.nodes);
      i += 1;
    }
    
    verreciel.animator.commit();
  }
  
  onDock()
  {
    assertArgs(arguments, 0);
    super.onDock()
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      node.rotation.y = 0;
    }
    
    verreciel.animator.commit();
  }
  
  onComplete()
  {
    assertArgs(arguments, 0);
    super.onComplete();
  }
  
  sightUpdate()
  {
    assertArgs(arguments, 0);
    this.root.rotation.y += degToRad(0.1);
  }
}
