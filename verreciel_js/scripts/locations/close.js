class LocationClose extends Location
{
  constructor(name, system, at, mapRequirement = null)
  {
    // assertArgs(arguments, 3);
    super(name,system, at, new IconClose(), new StructureClose());
    
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
  }
  
  onApproach()
  {
    // assertArgs(arguments, 0);
    if (this.mapRequirement != null && verreciel.nav.port.hasEvent(this.mapRequirement) == false)
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
  
  makePanel()
  {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();
    
    return newPanel;
  }
  
  onDock()
  {
    // assertArgs(arguments, 0);
    verreciel.player.eject();
    this.onComplete();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 30;
    
    this.structure.opacity = 0;
    
    verreciel.animator.commit();
  }
}

class IconClose extends Icon
{
  constructor()
  {
    // assertArgs(arguments, 0);
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
    // assertArgs(arguments, 0);
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
    // assertArgs(arguments, 0);
    super.morph();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 1.0;
    
    this.root.rotation.y = degToRad(this.morphTime * 45);
    
    for (let node of this.root.children)
    {
      node.children[0].rotation.z = degToRad(this.morphTime * 180);
      node.children[0].rotation.x = degToRad(this.morphTime * 90);
      node.children[0].rotation.y = degToRad(this.morphTime * 45);
    }
    
    verreciel.animator.commit();
  }
  
  onComplete()
  {
    // assertArgs(arguments, 0);
  
  }
}
