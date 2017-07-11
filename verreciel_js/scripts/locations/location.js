class Location extends Event
{
  constructor(name, system, at, icon, structure)
  {
    // assertArgs(arguments, 5);
    super(name, at, "unknown", verreciel.grey, false);
    
    this.system = system;
    this.icon = icon;
    this.structure = structure;
    this.code = system + "-" + name;
    this.storage = [];

    this.isDocked = false;
    this.inCollision = false;
    this.inApproach = false;
    this.inDiscovery = false;
    this.inSight = false;
    this.isTargetable = true;
    this.isTargeted = false;
    this.isKnown = false;
    this.isSeen = false;
    this.isSelected = false;
    this.isComplete = null;
    this.isPortEnabled = false;
    
    this.add(this.icon);
    
    this.structure.addHost(this);
    this.icon.addHost(this);
  }
  
  // MARK: System -
  
  whenStart()
  {
    // assertArgs(arguments, 0);
    super.whenStart();
    
    this.position.set(this.at.x,this.at.y,0);
    this.distance = distanceBetweenTwoPoints(verreciel.capsule.at, this.at);
    this.angle = this.calculateAngle();
    this.align = this.calculateAlignment();
    this.icon.onUpdate();
  }
  
  setup()
  {
    // assertArgs(arguments, 0);
  
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    
  }
  
  whenRenderer()
  {
    // assertArgs(arguments, 0);
    super.whenRenderer();
    
    this.position.set(this.at.x,this.at.y,0);
    this.distance = distanceBetweenTwoPoints(verreciel.capsule.at, this.at);
    this.angle = this.calculateAngle();
    this.align = this.calculateAlignment();
    
    if (this.distance <= Settings.sight)
    {
      if (this.inSight == false)
      { 
        this.onSight(); 
        this.inSight = true;
        this.isSeen = true;
      }
      this.sightUpdate();
    }
    else
    {
      this.inSight = false;
    }
    
    if (this.distance <= Settings.approach)
    {
      if (this.inApproach == false)
      {
        this.inApproach = true;
        this.onApproach();
      }
      this.approachUpdate();
    }
    else
    {
      this.inApproach = false;
    }
    
    if (this.distance <= Settings.collision)
    {
      if (this.inCollision == false)
      {
        this.inCollision = true;
        this.onCollision();
      }
    }
    else
    {
      this.inCollision = false;
    }
    
    if (verreciel.capsule.isDocked == true && verreciel.capsule.location == this)
    {
      this.dockUpdate();
    }
    
    this.radarCulling();
    this.clean();
  }
  
  onRadarView()
  {
    // assertArgs(arguments, 0);
    this.icon.label.opacity = 1;
  }
  
  onHelmetView()
  {
    // assertArgs(arguments, 0);
    this.icon.label.opacity = 0;
  }
  
  onSight()
  {
    // assertArgs(arguments, 0);
    this.isSeen = true;
    this.update();
    this.icon.onUpdate();

    if (this.isDocked)
    {
      this.structure.onDock();
    }
    else
    {
      this.structure.onSight();
    }
  }
  
  onApproach()
  {
    // assertArgs(arguments, 0);
    if (this.mapRequirement != null && verreciel.nav.port.hasEvent(this.mapRequirement) == false)
    {
      return;
    }
    verreciel.space.startInstance(this);
    // Don't try to dock if there is already a target
    if (verreciel.radar.port.hasEvent() == true && verreciel.radar.port.event == this || verreciel.capsule.isFleeing == true)
    {
      verreciel.capsule.dock(this);
    }
    else if (verreciel.radar.port.hasEvent() == false)
    {
      verreciel.capsule.dock(this);
    }
    this.update();
  }
  
  onCollision()
  {
    // assertArgs(arguments, 0);
    this.update();
  }
  
  onDock()
  {
    // assertArgs(arguments, 0);
    if (verreciel.thruster.isLocked && verreciel.universe.loiqe_city.isKnown == true)
    {
      verreciel.thruster.unlock();
    }
    
    this.isDocked = true;
    this.isKnown = true;
    this.update();
    this.structure.onDock();
    this.icon.onUpdate();
    verreciel.exploration.refresh();
    verreciel.music.playEffect("beep2");
  }
  
  onUndock()
  {
    // assertArgs(arguments, 0);
    this.isDocked = false;
    this.retrieveStorage();
    this.structure.onUndock();
    verreciel.exploration.refresh();
  }
  
  retrieveStorage()
  {
    // assertArgs(arguments, 0);
    if (this.storage.length == 0)
    {
      return;
    }
    
    for (let port of this.storage)
    {
      if (port.hasItem() == true)
      {
        verreciel.cargo.addItem(port.event);
        port.removeEvent();
      }
    }
  }
  
  onComplete()
  {
    // assertArgs(arguments, 0);
    this.isComplete = true;
    verreciel.progress.refresh();
    this.icon.onUpdate();
    this.structure.onComplete();
    verreciel.intercom.complete();
    verreciel.music.playEffect("beep1");
  }
  
  sightUpdate()
  {
    // assertArgs(arguments, 0);
    this.structure.sightUpdate();
  }
  
  approachUpdate()
  {
    // assertArgs(arguments, 0);
    
  }
  
  collisionUpdate()
  {
    // assertArgs(arguments, 0);
    
  }
  
  dockUpdate()
  {
    // assertArgs(arguments, 0);
    this.structure.dockUpdate();
  }
  
  radarCulling()
  {
    // assertArgs(arguments, 0);
    let verticalDistance = Math.abs(verreciel.capsule.at.y - this.at.y);
    let horizontalDistance = Math.abs(verreciel.capsule.at.x - this.at.x);
    
    // In Sight
    if (verticalDistance <= 1.5 && horizontalDistance <= 1.5 || verreciel.radar.overviewMode == true && this.distance < 7)
    {
      if (this.mapRequirement == null)
      {
        this.show();
      }
      else if (this.mapRequirement != null)
      {
        this.opacity = (verreciel.nav.hasMap(this.mapRequirement) == true && verreciel.battery.isNavPowered() == true) ? 1 : 0;
      }
    }
    // Out Of Sight
    else
    {
      this.hide();
    }
    
    // Connections
    if (this.connection != null)
    {
      if (this.connection.opacity != 0)
      {
        this.icon.wire.show();
      }
      else
      {
        this.icon.wire.hide();
      }
    }
  }
  
  connect(location)
  {
    // assertArgs(arguments, 1);
    this.connection = location;
    this.icon.wire.updateVertices([
      new THREE.Vector3(0,0,0), 
      new THREE.Vector3( (this.connection.at.x - this.at.x),(this.connection.at.y - this.at.y),0)
    ]);
  }

  // MARK: Events -
  
  touch(id)
  {
    // assertArgs(arguments, 1);
    if (this.isTargetable == false)
    {
      return false;
    }
    if (verreciel.thruster.isLocked == true && verreciel.game.state > 2)
    {
      return false;
    }
    if (verreciel.radar.port.event == null)
    {
      verreciel.radar.addTarget(this);
      verreciel.music.playEffect("click3");
    }
    else if (verreciel.radar.port.event == this)
    {
      verreciel.radar.removeTarget();
      verreciel.music.playEffect("click2");
    }
    else
    {
      verreciel.radar.addTarget(this);
      verreciel.music.playEffect("click1");
    }
    if (verreciel.radar.port.isConnectedToPanel(verreciel.console) == true)
    {
      verreciel.console.onConnect();
    }
    return true;
  }
  
  calculateAngle()
  {
    // assertArgs(arguments, 0);
    let angle = angleBetweenTwoPoints(verreciel.capsule.at, this.at, verreciel.capsule.at);
    return (360 - (angle - 90)) % 360;
  }
  
  calculateAlignment(direction = verreciel.capsule.direction)
  {
    // assertArgs(arguments, 0);
    var diff = Math.max(direction, this.angle) - Math.min(direction, this.angle);
    if (diff > 180)
    {
      diff = 360 - diff;
    }
    
    return diff;
  }
  
  // MARK: Storage -
  
  storedItems()
  {
    // assertArgs(arguments, 0);
    var collection = [];
    for (let port of this.storage)
    {
      if (port.hasEvent() == true && port.event.isQuest == true)
      {
        collection.push(port.event);
      }
    }
    return collection;
  }
  
  payload()
  {
    // assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData("Name", this.name),
      new ConsoleData("System", this.system),
      new ConsoleData("Position", this.at.x.toFixed(0) + "," + this.at.y.toFixed(0)),
      new ConsoleData("Distance", this.distance.toFixed(0)),
      new ConsoleData("Angle", this.angle.toFixed(0)),
      new ConsoleData(this.details),
    ]);
  }
  
  close()
  {
    // assertArgs(arguments, 0);
    this.icon.close();
  }
}
