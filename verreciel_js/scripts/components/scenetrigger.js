class SceneTrigger extends Empty
{
  constructor(host, size, operation = 0)
  {
    assertArgs(arguments, 2);
    super();
    this.isEnabled = true;
    this.operation = operation;
    this.host = host;
    this.size = size;
    
    // TODO: THREEJS
    // this.geometry = SCNPlane(width: size.width, height: size.height)
    // this.geometry?.materials.first?.diffuse.contents = clear
  }
  
  touch(id)
  {
    assertArgs(arguments, 1);
    if (isEnabled == false)
    {
      return false;
    }
    return this.host.touch(operation);
  }
  
  update()
  {
    assertArgs(arguments, 0);
    
  }
  
  debug()
  {
    assertArgs(arguments, 0);
    // TODO: THREEJS
    // this.geometry?.materials.first?.diffuse.contents = red
  }
  
  enable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = true;
    // TODO: THREEJS
    // this.geometry = SCNPlane(width: size.width, height: size.height)
    // this.geometry?.materials.first?.diffuse.contents = clear
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = false;
    // TODO: THREEJS
    // this.geometry = SCNPlane(width: 0, height: 0)
  }
}
