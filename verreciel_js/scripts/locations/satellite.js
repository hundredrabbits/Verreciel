class LocationSatellite extends Location
{
  constructor(name, system, at, message, item, mapRequirement = null)
  {
    // assertArgs(arguments, 5);
    super(name, system, at, new IconSatellite(), (name == "spawn" ? new Structure() : new StructureSatellite()));
    
    this.details = item.name;
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
    this.message = message;
    
    this.port = new ScenePortSlot(this, Alignment.center, true);
    this.port.position.set(0,-0.4,0);
    this.port.addEvent(item);
    this.port.enable();
    
    this.update();
  }
  
  // MARK: Panel
  
  panel()
  {
    // assertArgs(arguments, 0);
    if (this.isComplete == true)
    {
      return null;
    }
    
    let newPanel = new Panel();
    
    let text = new SceneLabel(this.message, 0.1, Alignment.left);
    text.position.set(-1.5,1,0);
    newPanel.add(text);
    
    newPanel.add(this.port);
  
    return newPanel;
  }
  
  onDock()
  {
    // assertArgs(arguments, 0);
    super.onDock();
    this.port.refresh();
  }
  
  update()
  {
    // assertArgs(arguments, 0);
    super.update();
    
    if (this.port.event == null)
    {
      this.onComplete();
    }
  }
  
  onUploadComplete()
  {
    // assertArgs(arguments, 0);
    this.onComplete();
    this.structure.update();
  }
}

class IconSatellite extends Icon
{
  constructor()
  {
    // assertArgs(arguments, 0);
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
    ], this.color));
  }
}

class StructureSatellite extends Structure
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();

    let nodes = Math.floor(Math.random() * 2) + 3;
    
    this.root.position.set(0,5,0);
    
    var i = 0;
    while (i < nodes)
    {
      
      let axis = new Empty()
      axis.rotation.y = (degToRad(i * (360/nodes)));
      
      this.root.add(axis);
      
      let shape = new Hexagon(3, verreciel.red);
      shape.position.x = 0;
      axis.add(shape);
      
      let shape2 = new Hexagon(3, verreciel.red);
      shape2.rotation.z = degToRad(90);
      shape.add(shape2);
      
      let shape3 = new Hexagon(3, verreciel.red);
      shape3.rotation.y = degToRad(90);
      shape.add(shape3);
      
      let shape4 = new Hexagon(3, verreciel.red);
      shape4.rotation.x = degToRad(90);
      shape.add(shape4);
      
      i += 1;
    }
  }
  
  onSight()
  {
    // assertArgs(arguments, 0);
    super.onSight();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      for (let subnode of node.children)
      {
        subnode.position.x = 3;
      }
    }
    
    verreciel.animator.commit();
  }
  
  onUndock()
  {
    // assertArgs(arguments, 0);
    super.onUndock();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      for (let subnode of node.children)
      {
        subnode.position.x = 3;
      }
    }
    
    verreciel.animator.commit();
  }
  
  onDock()
  {
    // assertArgs(arguments, 0);
    super.onDock();
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    for (let node of this.root.children)
    {
      for (let subnode of node.children)
      {
        subnode.position.x = 0;
      }
    }
    
    verreciel.animator.commit();
  }
  
  onComplete()
  {
    // assertArgs(arguments, 0);
    super.onComplete();
  
    this.root.updateChildrenColors(verreciel.cyan);
  }
  
  sightUpdate()
  {
    // assertArgs(arguments, 0);
    this.root.rotation.y += degToRad(0.1);
  }
  
  dockUpdate()
  {
    // assertArgs(arguments, 0);
    for (let node of this.root.children)
    {
      for (let subnode of node.children)
      {
        subnode.rotation.z += degToRad(0.25);
      }
    }
  }
}
