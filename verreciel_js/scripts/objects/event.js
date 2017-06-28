class Event extends Empty
{
  constructor(name = "", at = new THREE.Vector2(), details = "", color = verreciel.grey, isQuest = false)
  {
    super();

    this.isQuest = isQuest;
    
    this.name = name;
    this.details = details;
    
    this.at = at;
    this.color = color;
    
    // TODO: THREEJS

    // this.geometry = SCNPlane(width: 0.5, height: 0.5)
    // this.geometry?.firstMaterial?.diffuse.contents = red
  }
  
  // MARK: Basic -
  
  whenStart()
  {
    super.whenStart();
    
    // TODO: THREEJS

    // this.geometry = SCNPlane(width: 0.5, height: 0.5)
    // this.geometry?.firstMaterial?.diffuse.contents = clear
    
    let trigger = new SceneTrigger(this, new THREE.Vector2(1, 1));
    trigger.position.set(0,0,-0.1);
    this.add(trigger);
  }

  // MARK: Radar -
  
  update()
  {
    super.update();
  }
  
  remove()
  {
    this.removeFromParentNode();
  }
  
  clean()
  {
  }
  
  panel()
  {
    return new Panel();
  }
  
  // MARK: Debug -
  
  duplicate()
  {
    let newEvent = new Event();
    newEvent.isQuest = this.isQuest;
    newEvent.name = this.name;
    newEvent.details = this.details;
    newEvent.at = this.at;
    newEvent.color = this.color;
    return newEvent;
  }
}
