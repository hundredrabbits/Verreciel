class SceneTrigger extends Empty
{
  constructor(host, width, height, operation = 0)
  {
    assertArgs(arguments, 3);
    super(Methods.interactiveRegion);
    this.isEnabled = true;
    this.operation = operation;
    this.host = host;

    this.geometry.fromBufferGeometry(new THREE.PlaneBufferGeometry(width * 0.5, height * 0.5));
    this.geometry.mergeVertices();
    
    this.color = verreciel.clear;
  }
  
  touch(id)
  {
    assertArgs(arguments, 1);
    if (this.isEnabled == false)
    {
      return false;
    }
    return this.host.touch(this.operation);
  }
  
  update()
  {
    assertArgs(arguments, 0);
  }
  
  enable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = true;
    this.opacity = 1;
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = false;
    this.opacity = 0;
  }
}
