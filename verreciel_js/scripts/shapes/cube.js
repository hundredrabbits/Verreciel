class Cube extends Empty
{
  constructor(size, color = verreciel.white)
  {
    super();
    this.add(new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(-size,size,size)], color));
    this.add(new SceneLine([THREE.Vector3(size,size,-size), THREE.Vector3(-size,size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(size,size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(-size,size,size), THREE.Vector3(-size,size,-size)], color));
    
    this.add(new SceneLine([THREE.Vector3(size,-size,size), THREE.Vector3(-size,-size,size)], color));
    this.add(new SceneLine([THREE.Vector3(size,-size,-size), THREE.Vector3(-size,-size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(size,-size,size), THREE.Vector3(size,-size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(-size,-size,size), THREE.Vector3(-size,-size,-size)], color));
    
    this.add(new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(size,-size,size)], color));
    this.add(new SceneLine([THREE.Vector3(size,size,-size), THREE.Vector3(size,-size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(-size,size,-size), THREE.Vector3(-size,-size,-size)], color));
    this.add(new SceneLine([THREE.Vector3(-size,size,size), THREE.Vector3(-size,-size,size)], color));
    
  }
}
