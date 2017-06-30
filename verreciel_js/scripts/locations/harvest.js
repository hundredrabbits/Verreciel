class LocationHarvest extends Location
{
  constructor(name = "", system, at = new THREE.Vector2(), grows, mapRequirement = null)
  {
    super(name, system, at, new IconHarvest(), new StructureHarvest());
    
    this.mapRequirement = mapRequirement;
    
    this.grows = grows;
    
    this.details = this.grows.name;
    
    this.port = new ScenePortSlot(this, Alignment.center, true);
    this.port.enable();
    
    this.generate();
  }
  
  whenStart()
  {
    super.whenStart();
    this.port.addEvent(this.grows);
  }
  
  generate()
  {
    setTimeout(this.generate.bind(this), 1000);

    if (this.port == null)
    {
      return;
    }
    if (this.timeLeftLabel == null)
    {
      return;
    }
    
    this.progressRadial.update(this.generationCountdown/this.generationRate * 100);
    
    if (this.generationCountdown < this.generationRate && this.port.hasEvent(this.grows) == false)
    {
      this.generationCountdown += 1;
    }
    else
    {
      this.refresh();
      this.generationCountdown = 0;
      this.port.addEvent(this.grows);
      this.structure.update();
    }
    
    if (this.port.hasEvent(this.grows) == true)
    {
      this.timeLeftLabel.update("");
    }
    else
    {
      this.timeLeftLabel.update(this.generationRate-this.generationCountdown);
    }
  }
  
  panel()
  {
    let newPanel = new Panel();
    
    this.timeLeftLabel = new SceneLabel("", 0.15, Alignment.center);
    this.timeLeftLabel.position.set(0,0.5,0);
    newPanel.add(this.timeLeftLabel);
    
    this.progressRadial = new SceneProgressRadial(1.2, 52, verreciel.cyan);
    newPanel.add(this.progressRadial);
    
    newPanel.add(this.port);
    
    return newPanel;
  }
  
  onUploadComplete()
  {
    super.onUploadComplete();
    
    this.refresh();
    this.structure.update();
  }

  refresh()
  {
    if (this.port.hasEvent(this.grows) != true)
    {
      this.icon.mesh.updateChildrenColors(verwhite.grey);
    }
    else
    {
      this.icon.mesh.updateChildrenColors(verwhite.white);
    }
  }
}


class IconHarvest extends Icon
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
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(-this.size,0,0),
    ], this.color));
  }
}

class StructureHarvest extends Structure
{
  constructor()
  {
    super();
    
    this.root.position.set(0,5,0);
    
    let color = verreciel.cyan;
    let value1 = 7;
    let nodes = 45;
    var i = 0;
    while (i < nodes)
    {
      let node = new Empty();
      node.rotation.y = degToRad(i * (360/nodes));
      node.add(new SceneLine([
        new THREE.Vector3(0,0,value1), 
        new THREE.Vector3(0,5,value1), 
        new THREE.Vector3(0,5,value1), 
        new THREE.Vector3(0.5,5.5,value1), 
        new THREE.Vector3(0,5,value1), 
        new THREE.Vector3(-0.5,5.5,value1),
      ], color));
      this.root.add(node);
      i += 1;
    }
  }
  
  update()
  {
    super.update();
    
    if (this.host.port.hasEvent() != true)
    {
      this.root.updateChildrenColors(vercyan.grey);
    }
    else
    {
      this.root.updateChildrenColors(vercyan.cyan);
    }
  }
  
  sightUpdate()
  {
    super.sightUpdate();
    
    this.root.rotation.y += degToRad(0.1);
  }
}
