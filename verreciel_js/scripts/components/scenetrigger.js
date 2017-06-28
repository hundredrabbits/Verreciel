class SceneTrigger extends Empty
{
  constructor(host, size, operation = 0)
  {
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
    if (isEnabled == false)
    {
      return false;
    }
    return this.host.touch(operation);
  }
  
  update()
  {
    
  }
  
  debug()
  {
    // TODO: THREEJS
    // this.geometry?.materials.first?.diffuse.contents = red
  }
  
  enable()
  {
    this.isEnabled = true;
    // TODO: THREEJS
    // this.geometry = SCNPlane(width: size.width, height: size.height)
    // this.geometry?.materials.first?.diffuse.contents = clear
  }
  
  disable()
  {
    this.isEnabled = false;
    // TODO: THREEJS
    // this.geometry = SCNPlane(width: 0, height: 0)
  }
}
