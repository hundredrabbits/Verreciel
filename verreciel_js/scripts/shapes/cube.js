class Cube extends Empty
{
  constructor(size, color = verreciel.white)
  {
    // assertArgs(arguments, 1);
    super();
    this.add(new SceneLine([
        new THREE.Vector3(size,size,size), new THREE.Vector3(-size,size,size),
        new THREE.Vector3(size,size,-size), new THREE.Vector3(-size,size,-size),
        new THREE.Vector3(size,size,size), new THREE.Vector3(size,size,-size),
        new THREE.Vector3(-size,size,size), new THREE.Vector3(-size,size,-size),
        new THREE.Vector3(size,-size,size), new THREE.Vector3(-size,-size,size),
        new THREE.Vector3(size,-size,-size), new THREE.Vector3(-size,-size,-size),
        new THREE.Vector3(size,-size,size), new THREE.Vector3(size,-size,-size),
        new THREE.Vector3(-size,-size,size), new THREE.Vector3(-size,-size,-size),
        // new THREE.Vector3(size,size,size), new THREE.Vector3(size,-size,size),
        // new THREE.Vector3(size,size,-size), new THREE.Vector3(size,-size,-size),
        // new THREE.Vector3(-size,size,-size), new THREE.Vector3(-size,-size,-size),
        // new THREE.Vector3(-size,size,size), new THREE.Vector3(-size,-size,size),
    ], color));
  }
}
