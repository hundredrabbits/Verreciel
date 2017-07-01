class Rect extends Empty
{
  constructor(size, color = verreciel.white)
  {
    assertArgs(arguments, 1);
    super();
    
    this.add(new SceneLine([
      new THREE.Vector3(-size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,size.height/2), 
      new THREE.Vector3(size.width/2,0,-size.height/2), 
      new THREE.Vector3(size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,-size.height/2), 
      new THREE.Vector3(-size.width/2,0,size.height/2),
    ], color));
  }
}
