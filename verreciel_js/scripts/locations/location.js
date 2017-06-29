class Location extends Event
{
  constructor(name, system, at, icon, structure)
  {
    super(name, at);
    
    this.name = name;
    this.details = "unknown";
    this.at = at;
    this.system = system;
    this.icon = icon;
    this.structure = structure;
    this.code = system + "-" + name;
    this.storage = [];
    
    // TODO: THREEJS

    // geometry = SCNPlane(width: 0.5, height: 0.5)
    // geometry?.firstMaterial?.diffuse.contents = clear
  
    this.add(this.icon);
    
    this.structure.addHost(this);
    this.icon.addHost(this);
  }
  
  // MARK: System -
  
  whenStart()
  {
    super.whenStart();
    
    this.position.set(at.x,at.y,0);
    this.distance = distanceBetweenTwoPoints(verreciel.capsule.at, this.at);
    this.angle = this.calculateAngle();
    this.align = this.calculateAlignment();
    this.icon.onUpdate();
  }
  
  setup()
  {
  
  }
  
  refresh()
  {
    
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    this.position.set(at.x,at.y,0);
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
      approachUpdate();
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
    
    if (verreciel.capsule.isDocked == true && this.capsule.location == this)
    {
      this.dockUpdate();
    }
    
    this.radarCulling();
    this.clean();
  }
  
  onRadarView()
  {
    this.icon.label.visible = true;
  }
  
  onHelmetView()
  {
    this.icon.label.visible = visible;
  }
  
  onSight()
  {
    this.isSeen = true;
    this.update();
    this.structure.onSight();
    this.icon.onUpdate();
  }
  
  onApproach()
  {
    if (mapRequirement != null && verreciel.nav.port.hasEvent(mapRequirement) == false)
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
    this.update();
  }
  
  onDock()
  {
    if (verreciel.thruster.isLocked && verreciel.universe.loiqe_city.isKnown == true)
    {
      verreciel.thruster.unlock();
    }
    
    this.isKnown = true;
    this.update();
    this.structure.onDock();
    this.icon.onUpdate();
    verreciel.exploration.refresh();
    verreciel.music.playEffect("beep2");
  }
  
  onUndock()
  {
    this.retrieveStorage();
    this.structure.onUndock();
    verreciel.exploration.refresh();
  }
  
  retrieveStorage()
  {
    if (this.storage.count == 0)
    {
      return;
    }
    
    for (let port in this.storage)
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
    this.isComplete = true;
    verreciel.progress.refresh();
    this.icon.onUpdate();
    this.structure.onComplete();
    verreciel.intercom.complete();
    verreciel.music.playEffect("beep1");
  }
  
  sightUpdate()
  {
    this.structure.sightUpdate();
  }
  
  approachUpdate()
  {
    
  }
  
  collisionUpdate()
  {
    
  }
  
  dockUpdate()
  {
    this.structure.dockUpdate();
  }
  
  radarCulling()
  {
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
        this.visible = (verreciel.nav.hasMap(this.mapRequirement) == true && verreciel.battery.isMapPowered() == true) ? true : false;
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
      if (this.connection.visible == true)
      {
        this.icon.wire.show();
      }
      else{
        this.icon.wire.hide();
      }
    }
  }
  
  connect(location)
  {
    this.connection = location;
    this.icon.wire.update(
      [
        new THREE.Vector3(0,0,0), 
        new THREE.Vector3( (this.connection.at.x - this.at.x),(this.connection.at.y - this.at.y),0)
      ],
      verreciel.grey
    );
  }

  // MARK: Events -
  
  touch(id)
  {
    if (this.isTargetable == false)
    {
      return false;
    }
    if (verreciel.thruster.isLocked == true && verreciel.game.state() > 2)
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
    return true;
  }
  
  calculateAngle()
  {
    let angle = angleBetweenTwoPoints(verreciel.capsule.at, this.at, verreciel.capsule.at);
    return (360 - (radToDeg(angle) - 90)) % 360;
  }
  
  calculateAlignment(direction = verreciel.capsule.direction)
  {
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
    var collection = [];
    for (let port in this.storage)
    {
      if (port.hasEvent() == true && port.event.isQuest == true)
      {
        collection.push(port.event);
      }
    }
    return collection;
  }
  
  isStorageEmpty()
  {
    // TODO: Almost definitely a bug
    for (let port in this.storage)
    {
      if (port.hasEvent() == true)
      {
        return true;
      }
    }
    return false;
  }
  
  payload()
  {
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
    this.icon.close();
  }
}
