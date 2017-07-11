class Empty extends SceneNode
{
  constructor(method = null)
  {
    // assertArgs(arguments, 0);
    super(method);
    this.details = "unknown";
  }

  touch(id = 0)
  {
    // assertArgs(arguments, 1);
    return false;
  }
  
  update()
  {
    // assertArgs(arguments, 0, true);

  }

  // TODO: REMOVE
  add()
  {
    if (arguments[0] == null)
    {
      throw "NULL ADD";
    }
    if (!arguments[0] instanceof THREE.Object3D)
    {
      throw "ILLEGAL ADD";
    }
    super.add.apply(this, arguments);
  }
  
  empty()
  {
    // assertArgs(arguments, 0);
    while (this.children.length > 0)
    {
      this.remove(this.children[0]);
    }
  }
  
  blink()
  {
    // assertArgs(arguments, 0);
    if (verreciel.game.time % 3 == 0)
    {
      this.opacity = 1;
    }
    else
    {
      this.opacity = 0;
    }
  }
  
  show()
  {
    // assertArgs(arguments, 0);
    this.opacity = 1;
  }
  
  hide()
  {
    // assertArgs(arguments, 0);
    this.opacity = 0;
  }
  
  updateChildrenColors(color)
  {
    // assertArgs(arguments, 1);
    if (this.method == Methods.lineArt)
    {
      this.color = color;
    }
    for (let node of this.children)
    {
      node.updateChildrenColors(color);
    }
  }
  
  onConnect()
  {
    // assertArgs(arguments, 0);
    this.update();
  }
  
  onDisconnect()
  {
    // assertArgs(arguments, 0);
    this.update();
  }
  
  onUploadComplete()
  {
    // assertArgs(arguments, 0);
    
  }
  
  onMissionComplete()
  {
    // assertArgs(arguments, 0);
    
  }
  
  payload()
  {
    // assertArgs(arguments, 0);
    return new ConsolePayload([new ConsoleData("unknown", "unknown")]);
  }
}
