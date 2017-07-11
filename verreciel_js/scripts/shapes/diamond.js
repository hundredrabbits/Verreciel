class Diamond extends Empty
{
  constructor(size, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super();
    this.add(new SceneLine([
      new THREE.Vector3(0,0,size),
      new THREE.Vector3(size,0,0),
      new THREE.Vector3(size,0,0),
      new THREE.Vector3(0,0,-size),
      new THREE.Vector3(0,0,-size),
      new THREE.Vector3(-size,0,0),
      new THREE.Vector3(-size,0,0),
      new THREE.Vector3(0,0,size),
    ], color));
  }
}
