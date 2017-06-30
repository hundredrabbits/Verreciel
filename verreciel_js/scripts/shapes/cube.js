class Cube extends Empty
{
  constructor(size, color = verreciel.white)
  {
    super();
    this.line1 = new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(-size,size,size)], color);
    this.add(this.line1);
    this.line2 = new SceneLine([THREE.Vector3(size,size,-size), THREE.Vector3(-size,size,-size)], color);
    this.add(this.line2);
    this.line3 = new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(size,size,-size)], color);
    this.add(this.line3);
    this.line4 = new SceneLine([THREE.Vector3(-size,size,size), THREE.Vector3(-size,size,-size)], color);
    this.add(this.line4);
    
    this.line5 = new SceneLine([THREE.Vector3(size,-size,size), THREE.Vector3(-size,-size,size)], color);
    this.add(this.line5);
    this.line6 = new SceneLine([THREE.Vector3(size,-size,-size), THREE.Vector3(-size,-size,-size)], color);
    this.add(this.line6);
    this.line7 = new SceneLine([THREE.Vector3(size,-size,size), THREE.Vector3(size,-size,-size)], color);
    this.add(this.line7);
    this.line8 = new SceneLine([THREE.Vector3(-size,-size,size), THREE.Vector3(-size,-size,-size)], color);
    this.add(this.line8);
    
    this.line9 = new SceneLine([THREE.Vector3(size,size,size), THREE.Vector3(size,-size,size)], color);
    this.add(this.line9);
    this.line10 = new SceneLine([THREE.Vector3(size,size,-size), THREE.Vector3(size,-size,-size)], color);
    this.add(this.line10);
    this.line11 = new SceneLine([THREE.Vector3(-size,size,-size), THREE.Vector3(-size,-size,-size)], color);
    this.add(this.line11);
    this.line12 = new SceneLine([THREE.Vector3(-size,size,size), THREE.Vector3(-size,-size,size)], color);
    this.add(this.line12);
    
  }
}
