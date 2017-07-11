class SceneTrigger extends Empty
{
  constructor(host, width, height, operation = 0)
  {
    assertArgs(arguments, 3);
    super(Methods.interactiveRegion);
    this.isEnabled = true;
    this.operation = operation;
    this.host = host;

    let scale = IS_MOBILE ? 1 : 0.5;

    this.geometry.fromBufferGeometry(new THREE.PlaneBufferGeometry(width * scale, height * scale));
    this.geometry.mergeVertices();
    
    this.color = SceneTrigger.DEBUG_BLUE;
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
    if (!this.isEnabled)
    {
      this.isEnabled = true;
      this.color = SceneTrigger.DEBUG_BLUE;
    }
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    if (this.isEnabled)
    {
      this.isEnabled = false;
      this.color = SceneTrigger.DEBUG_WHITE;
    }
  }
}

SceneTrigger.DEBUG_BLUE = new THREE.Vector4(0, 0, 1, 0.1);
SceneTrigger.DEBUG_WHITE = new THREE.Vector4(1, 1, 1, 0.1);
