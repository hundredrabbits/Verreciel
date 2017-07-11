class Event extends Empty
{
  constructor(name = "", at = new THREE.Vector2(), details = "", color = verreciel.grey, isQuest = false)
  {
    // assertArgs(arguments, 5);
    super();

    this.isQuest = isQuest;
    
    this.name = name;
    this.details = details;
    
    this.at = at;
    this.color = color;
  }
  
  // MARK: Basic -
  
  whenStart()
  {
    // assertArgs(arguments, 0);
    super.whenStart();
    
    let trigger = new SceneTrigger(this, 1, 1);
    trigger.position.set(0,0,-0.1);
    this.add(trigger);
  }

  // MARK: Radar -
  
  update()
  {
    // assertArgs(arguments, 0);
    super.update();
  }
  
  remove()
  {
    // assertArgs(arguments, 0);
    this.removeFromParentNode();
  }
  
  clean()
  {
    // assertArgs(arguments, 0);
  }
  
  panel()
  {
    // assertArgs(arguments, 0);
    return new Panel();
  }
}
