class LocationClose extends Location
{
  constructor(name, system, at, mapRequirement = null)
  {
    super(name,system, at, new IconClose(), new StructureClose());
    
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
  }
  
  onApproach()
  {
    if (this.mapRequirement != null && map.port.hasEvent(this.mapRequirement) == false)
    {
      return;
    }
    if (
      verreciel.universe.loiqe.isComplete != true || 
      verreciel.universe.valen.isComplete != true || 
      verreciel.universe.senni.isComplete != true || 
      verreciel.universe.usul.isComplete != true)
    {
      return;
    }
    
    verreciel.space.startInstance(this);
    // Don't try to dock if there is already a target
    if (
      verreciel.radar.port.hasEvent() == true && 
      verreciel.radar.port.event == this || 
      verreciel.capsule.isFleeing == true)
    {
      verreciel.capsule.dock(this);
    }
    else if (verreciel.radar.port.hasEvent() == false)
    {
      verreciel.capsule.dock(this);
    }
    this.update();
  }

  
  // MARK: Panel -
  
  panel()
  {
    let newPanel = new Panel();
    
    return newPanel;
  }
  
  onDock()
  {
    player.eject()
    onComplete()
    
    SCNTransaction.begin()
    SCNTransaction.animationDuration = 30
    
    structure.opacity = 0
    
    SCNTransaction.commit()
  }
}

class IconClose extends Icon
{
  constructor()
  {
    super();
    
    this.label.hide();
    
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

class StructureClose extends Structure
{
  constructor()
  {
    super();
    
    this.root.position.set(0,5,0);
    
    let count = 8;
    var i = 0;
    while (i < count)
    {
      let pivot = new Empty();
      pivot.rotation.y = degToRad(i * 360/count);
      this.root.add(pivot);
      let shape = new Hexagon(2, verreciel.grey);
      shape.position.z = 3;
      pivot.add(shape);
      i += 1;
    }
  }
  
  morph()
  {
    super.morph();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 1.0
    
    // this.root.rotation.y = degToRad(morphTime * 45);
    
    // for (let node in this.root.children)
    // {
    //   node.children[0].rotation.z = degToRad(morphTime * 180);
    //   node.children[0].rotation.x = degToRad(morphTime * 90);
    //   node.children[0].rotation.y = degToRad(morphTime * 45);
    // }
    
    // SCNTransaction.commit()
  }
  
  onComplete()
  {
  
  }
}
