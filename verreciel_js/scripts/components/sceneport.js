class ScenePort extends Empty
{
  constructor(host)
  {
    assertArgs(arguments, 1);
    super();

    this.host = host;
    this.isActive = false;
    this.isEnabled = true;
    
    // TODO: THREEJS

    // this.geometry = SCNPlane(width: 0.3, height: 0.3)
    // this.geometry?.firstMaterial?.diffuse.contents = clear
    
    this.trigger = new SceneTrigger(this, 1, 1);
    this.trigger.position.set(0,0,-0.1);
    this.add(this.trigger);
    
    let radius = 0.125;
    this.sprite_input = new SceneLine([
      new THREE.Vector3(0, radius/2, 0),
      new THREE.Vector3(radius/2, 0, 0),
      new THREE.Vector3(radius/2, 0, 0),
      new THREE.Vector3(0, -radius/2, 0),
      new THREE.Vector3(0, -radius/2, 0),
      new THREE.Vector3(-radius/2, 0, 0),
      new THREE.Vector3(-radius/2, 0, 0),
      new THREE.Vector3(0, radius/2, 0),
    ], verreciel.grey);
    this.add(this.sprite_input);
    
    this.sprite_output = new SceneLine([
      new THREE.Vector3(0, radius, 0),
      new THREE.Vector3(radius, 0, 0),
      new THREE.Vector3(radius, 0, 0),
      new THREE.Vector3(0, -radius, 0),
      new THREE.Vector3(0, -radius, 0),
      new THREE.Vector3(-radius, 0, 0),
      new THREE.Vector3(-radius, 0, 0),
      new THREE.Vector3(0, radius, 0),
    ], verreciel.grey);
    this.add(this.sprite_output);
    
    this.wire = new SceneWire(this, new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0));
    this.add(this.wire);
    
    this.disable();
  }
  
  // MARK: Touch -

  touch(id = 0)
  {
    assertArgs(arguments, 1);
    if (this.isEnabled == false)
    {
      return false;
    }
    
    if (verreciel.player.activePort == null)
    {
      verreciel.player.holdPort(this);
    }
    else if (verreciel.player.activePort == this)
    {
      verreciel.player.releasePort();
    }
    else if (verreciel.player.activePort != this)
    {
      verreciel.player.connectPorts(verreciel.player.activePort, this);
    }
    
    return true;
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
    super.whenRenderer();
    
    this.sprite_input.show();
    this.sprite_output.show();
    
    this.sprite_input.updateColor(this.inputColor());
    this.sprite_output.updateColor(this.outputColor());
    
    // Wire
    this.wire.isActive = false;
    if (this.connection != null && event != null)
    {
      wire.isActive = true;
    }
    
    // Blink
    if (verreciel.player.activePort != null && verreciel.player.activePort == this)
    {
      this.sprite_output.updateChildrenColors(verreciel.cyan);
      this.sprite_output.blink();
    }
  }

  inputColor()
  {
    if (this.isEnabled == false)
    {
      return verreciel.clear;
    }
    else if (this.origin == null)
    {
      return verreciel.grey;
    }
    
    return verreciel.red;
  }

  outputColor()
  {
    if (this.event == null || this.isEnabled == false)
    {
      return verreciel.grey;
    }
    
    return verreciel.cyan;
  }
  
  activate()
  {
    assertArgs(arguments, 0);
    this.isActive = true;
  }
  
  desactivate()
  {
    assertArgs(arguments, 0);
    this.isActive = false;
  }
  
  enable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = true;
    this.trigger.enable();
  }
  
  disable()
  {
    assertArgs(arguments, 0);
    this.isEnabled = false;
    this.disconnect();
    this.trigger.disable();
  }
  
  addEvent(event)
  {
    assertArgs(arguments, 1);
    this.event = event;
    this.update();
  }
  
  addRequirement(event)
  {
    assertArgs(arguments, 1);
    this.requirement = event;
  }
  
  removeEvent()
  {
    assertArgs(arguments, 0);
    this.event = null;
  }
  
  connect(port)
  {
    assertArgs(arguments, 1);
    if (port.isEnabled == false)
    {
      return;
    }
    if (port.origin != null)
    {
      return;
    }
    if (port.connection != null && port.connection == this)
    {
      return;
    }
    
    this.disconnect();
    this.connection = port;
    this.connection.origin = this;
    
    this.wire.updateEnds(new THREE.Vector3(0, 0, 0), this.convertPositionFromNode(new THREE.Vector3(0, 0, 0), port));
    
    this.wire.enable();
    
    this.connection.host.onConnect();
    this.connection.onConnect();
    
    this.onConnect();
  }
  
  disconnect()
  {
    assertArgs(arguments, 0);
    if (this.connection == null)
    {
      return;
    }
  
    let targetOrigin = this.connection.host;
    
    this.connection.origin = null;
    this.connection.update();
    this.connection.onDisconnect();
    this.connection = null;
    
    if (targetOrigin != null)
    {
      targetOrigin.onDisconnect();
      targetOrigin.update();
    }
    
    this.onDisconnect();
    this.host.onDisconnect();
    
    this.wire.disable();
  }
  
  strip()
  {
    assertArgs(arguments, 0);
    this.disconnect()
    if (this.origin != null)
    {
      this.origin.disconnect();
    }
  }
  
  syphon()
  {
    assertArgs(arguments, 0);
    let stored_origin = this.origin;
    let stored_event = this.origin.event;
    
    if (stored_origin != null)
    {
      stored_origin.removeEvent();
      stored_origin.host.update();
      stored_origin.update();
      stored_origin.disconnect();
    }
    
    return stored_event;
  }
  
  // MARK: Validation
  
  // MARK: Checks -
  
  hasEvent(target)
  {
    assertArgs(arguments, 1);
    if (this.event == null)
    {
      return false;
    }
    if (this.event.name == target.name)
    {
      return true;
    }
    return false;
  }
  
  hasEvent()
  {
    assertArgs(arguments, 0);
    if (event != null)
    {
      return true;
    }
    return false;
  }
  
  hasItem()
  {
    assertArgs(arguments, 0);
    if (event == null)
    {
      return false;
    }
    if ((event instanceof Item) == true)
    {
      return true;
    }
    return false;
  }
  
  hasItemOfType(target)
  {
    assertArgs(arguments, 1);
    if (event == null)
    {
      return false;
    }
    if ((event instanceof Item) == false)
    {
      return false;
    }
    if (event.type == target)
    {
      return true;
    }
    return false;
  }
  
  hasItemLike(target)
  {
    assertArgs(arguments, 1);
    if (event == null)
    {
      return false;
    }
    if ((event instanceof Item) == false)
    {
      return false;
    }
    if (event.name == target.name)
    {
      return true;
    }
    return false;
  }
  
  isReceiving()
  {
    assertArgs(arguments, 0);
    if (this.origin != null && origin.event != null)
    {
      return true;
    }
    return false;
  }
  
  isReceivingFromPanel(panel)
  {
    assertArgs(arguments, 1);
    if (this.origin == null)
    {
      return false;
    }
    if ((origin.host instanceof Panel) == false)
    {
      return false;
    }
    if (this.origin.host == panel)
    {
      return true;
    }
    return false;
  }
  
  isReceiving(event)
  {
    assertArgs(arguments, 1);
    if (this.origin != null && origin.event != null && origin.event == event)
    {
      return true;
    }
    return false;
  }
  
  isReceivingItem(item)
  {
    assertArgs(arguments, 1);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    if ((origin.event instanceof Item) == false)
    {
      return false;
    }
    if (this.origin.event == item)
    {
      return true;
    }
    return false;
  }
  
  isReceivingItemLike(target)
  {
    assertArgs(arguments, 1);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    if ((origin.event instanceof Item) == false)
    {
      return false;
    }
    if (this.origin.event.name == target.name)
    {
      return true;
    }
    return false;
  }
  
  isReceivingItemOfType(type)
  {
    assertArgs(arguments, 1);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    if ((this.origin.event instanceof Item) == false)
    {
      return false;
    }
    
    let source = this.origin.event;
    
    if (source.type == type)
    {
      return true;
    }
    
    return false;
  }
  
  isReceivingLocation()
  {
    assertArgs(arguments, 0);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    
    if (this.origin.event instanceof Location)
    {
      return true;
    }
    
    return false;
  }
  
  isReceivingLocationOfTypePortal()
  {
    assertArgs(arguments, 0);
    if (isReceivingLocation() == false)
    {
      return false;
    }
    if (this.origin.event instanceof LocationPortal)
    {
      return true;
    }
    return false;
  }
  
  isReceivingEventOfTypeLocation()
  {
    assertArgs(arguments, 0);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    if ((origin.event instanceof Location) == false)
    {
      return false;
    }
    return true;
  }
  
  isReceivingEventOfTypeItem()
  {
    assertArgs(arguments, 0);
    if (this.origin == null)
    {
      return false;
    }
    if (this.origin.event == null)
    {
      return false;
    }
    if ((origin.event instanceof Item) == false)
    {
      return false;
    }
    return true;
  }
  
  isConnectedToPanel(panel)
  {
    assertArgs(arguments, 1);
    if (connection == null)
    {
      return false;
    }
    if ((connection.host instanceof Panel) && connection.host == panel)
    {
      return true;
    }
    return false;
  }
  
  // MARK: Etc..
  
  onConnect()
  {
    assertArgs(arguments, 0);
    super.onConnect();
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    super.onDisconnect();
    this.host.onDisconnect();
  }
}
