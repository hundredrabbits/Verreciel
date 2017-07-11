class LocationTransit extends Location
{
  constructor(name, system, at, mapRequirement = null)
  {
    // assertArgs(arguments, 3);
    super(name,system, at, new IconTransit(), new StructureTransit());
    
    this.mapRequirement = mapRequirement;
  }
  
  // MARK: Panel -
  
  panel()
  {
    // assertArgs(arguments, 0);
    let newPanel = new Panel();

    return newPanel;
  }
}

class IconTransit extends Icon
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

class StructureTransit extends Structure
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
  }
}
