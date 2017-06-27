class Empty extends SceneNode
{
  constructor()
  {
    super();
    this.details = "unknown";
  }

  touch(id = 0)
  {
    return false;
  }
  
  update()
  {

  }
  
  empty()
  {
    for (let node of this.children)
    {
      node.removeFromParentNode();
    }
  }
  
  blink()
  {
    if (game.time % 3 == 0)
    {
      this.visible = true;
    }
    else
    {
      this.visible = false;
    }
  }
  
  show()
  {
    this.visible = true;
  }
  
  hide()
  {
    this.visible = false;
  }
  
  updateChildrenColors(color)
  {
    for (let node of this.children)
    {
      node.color(color);
      node.updateChildrenColors(color);
    }
  }
  
  color(color)
  {
    if (geometry == null)
    {
      return;
    }

    if (!(this instanceof SceneLine))
    {
      return;
    }
    
    this.updateColor(color); // TODO: move to SceneLine
  }
  
  onConnect()
  {
    update()
  }
  
  onDisconnect()
  {
    update()
  }
  
  onUploadComplete()
  {
    
  }
  
  onMissionComplete()
  {
    
  }
  
  payload()
  {
    return new ConsolePayload([new ConsoleData("unknown", "unknown")]);
  }
}
