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
    
    this.color = DEBUG_TRIGGERS ? SceneTrigger.DEBUG_BLUE : verreciel.clear;
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
    if (DEBUG_TRIGGERS)
    {
      this.color = SceneTrigger.DEBUG_BLUE;
    }
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = false;
    if (DEBUG_TRIGGERS)
    {
      this.color = SceneTrigger.DEBUG_WHITE;
    }
  }
}

SceneTrigger.DEBUG_BLUE = new THREE.Vector4(0, 0, 1, 1);
SceneTrigger.DEBUG_WHITE = new THREE.Vector4(1, 1, 1, 0.1);
