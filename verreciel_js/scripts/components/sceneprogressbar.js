class SceneProgressBar extends Empty
{
  constructor(width, color = verreciel.red)
  {
    super();
    this.percent = 0;
    this.width = width;
    this.color = color;
    this.addGeometry();
  }
  
  addGeometry()
  {
    this.progressLine = new SceneLine([new THREE.Vector3(0,0,0), new THREE.Vector3(0,0,0)], this.color);
    this.add(this.progressLine);
    this.remainingLine = new SceneLine([new THREE.Vector3(0,0,0), new THREE.Vector3(this.width,0,0)], verreciel.grey);
    this.add(this.remainingLine);
  }
  
  update(percent)
  {
    let to = this.width * (percent/100);
    
    this.progressLine.update([new THREE.Vector3(0,0,0), new THREE.Vector3(to,0,0)], this.color);
    this.remainingLine.update([new THREE.Vector3(to,0,0), new THREE.Vector3(this.width,0,0)], verreciel.grey);
  }
}
