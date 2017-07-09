class Capsule extends Empty
{ 
  // MARK: Default -
  
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    console.log("^ Capsule | Init");

    this.at = verreciel.universe.loiqe_spawn.at.clone();
    this.direction = 1;
    this.system = Systems.loiqe;
    this.shieldRoot = new Empty();
    this.radiation = 0;
    this.isWarping = false;
    this.isDocked = false;
    this.isFleeing = false;
    this.isReturning = false;
    this.panels = [];
    
    this.mesh = new Empty();
    this.mesh.position.set(0,0,0);
    this.direction = 0;
    this.add(this.mesh);
    
    // Interface
    // Monitors
    this.addPanel(verreciel.journey);
    this.addPanel(verreciel.exploration);
    this.addPanel(verreciel.progress);
    this.addPanel(verreciel.completion);
    
    // Panels
    this.addPanel(verreciel.battery);
    this.addPanel(verreciel.hatch);
    this.addPanel(verreciel.console);
    this.addPanel(verreciel.cargo);
    this.addPanel(verreciel.intercom);
    this.addPanel(verreciel.pilot);
    this.addPanel(verreciel.radar);
    this.addPanel(verreciel.thruster);
    
    this.addPanel(verreciel.above);
    this.addPanel(verreciel.below);
    
    verreciel.hatch.rotation.y = degToRad(45);
    verreciel.console.rotation.y = degToRad(90);
    verreciel.cargo.rotation.y = degToRad(135);
    verreciel.intercom.rotation.y = degToRad(180);
    verreciel.pilot.rotation.y = degToRad(225);
    verreciel.radar.rotation.y = degToRad(270);
    verreciel.thruster.rotation.y = degToRad(315);
    
    verreciel.journey.rotation.y = verreciel.battery.rotation.y;
    verreciel.exploration.rotation.y = verreciel.console.rotation.y;
    verreciel.progress.rotation.y = verreciel.intercom.rotation.y;
    verreciel.completion.rotation.y = verreciel.radar.rotation.y;
    
    // Widgets
    verreciel.radar.footer.add(verreciel.nav);
    verreciel.battery.footer.add(verreciel.radio);
    verreciel.console.footer.add(verreciel.shield);
    verreciel.intercom.footer.add(verreciel.enigma);
  }

  addPanel(panel)
  {
    assertArgs(arguments, 1);
    this.add(panel);
    this.panels.push(panel);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    console.log("+ Capsule | Start");
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
    super.whenRenderer();
    
    // Docking
    
    if (this.location != null && this.isDocked != true)
    {
      
      var approachSpeed = 0.5;
      
      let distanceRatio = distanceBetweenTwoPoints(this.at, this.location.at)/0.5;
      approachSpeed = approachSpeed * distanceRatio;
      
      var speed = distanceRatio/600;
      if (speed < 0.0005)
      {
        speed = 0.005;
      }
      let angle = this.direction % 360;
      
      this.at.x += speed * Math.sin(degToRad(angle))
      this.at.y += speed * Math.cos(degToRad(angle))
      
      if (distanceBetweenTwoPoints(this.at, this.location.at) < 0.003)
      {
        this.docked();
      }
    }
    
    // Warping
    
    if (this.isWarping == true)
    {
      if (this.warp.distance > 1.5)
      {
        this.warpUp();
      }
      else
      {
        this.warpDown();
      }
      let speed = verreciel.thruster.actualSpeed/600;
      let angle = this.direction % 360;
      
      let angleRad = degToRad(angle);
      
      this.at.x += speed * Math.sin(angleRad);
      this.at.y += speed * Math.cos(angleRad);
    }
    
    if (this.closestKnownLocation().distance > 1.5 && this.isWarping == false)
    {
      verreciel.helmet.addWarning("Returning", null, 0.1, "radiation");
      this.autoReturn();
    }
    else if (this.isFleeing == true)
    {
      verreciel.helmet.addWarning("Auto-Pilot", null, 0.1, "radiation");
    }
    else if (this.radiation > 0)
    {
      verreciel.helmet.addWarning("Radiation " + (this.radiation * 100).toFixed(1) + "%", null, 0.1, "radiation");
    }
  }
  
  beginAtLocation(location)
  {
    assertArgs(arguments, 1);
    this.at.copy(location.at);
    this.location = location;
    this.location.isKnown = true;
    this.dock(location);
    this.docked();
    verreciel.space.onSystemEnter(location.system);
  }
  
  whenSecond()
  {
    assertArgs(arguments, 0);
    super.whenSecond();
    let cl = this.closestLocation()
    if (cl.system != null && cl.system != this.system)
    {
      verreciel.space.onSystemEnter(cl.system);
    }
  }
  
  closestLocation()
  {
    assertArgs(arguments, 0);
    var closestLocation = null;
    for (let location of verreciel.universe.allLocations)
    {
      if (closestLocation == null)
      {
        closestLocation = location;
      }
      if (location.distance > closestLocation.distance)
      {
        continue;
      }
      closestLocation = location;
    }
    return closestLocation;
  }
  
  closestStar()
  {
    assertArgs(arguments, 0);
    var star = null;

    switch (this.system)
    {
      case Systems.loiqe:
        star = verreciel.universe.loiqe;
        break;
      case Systems.valen:
        star = verreciel.universe.valen;
        break;
      case Systems.senni:
        star = verreciel.universe.senni;
        break;
      case Systems.usul:
        star = verreciel.universe.usul;
        break;
      case Systems.close:
        star = verreciel.universe.close;
        break;
      default:
        star = verreciel.universe.loiqe;
    }

    return star;
  }
  
  closestKnownLocation()
  {
    assertArgs(arguments, 0);
    var closestLocation = null;
    for (let location of verreciel.universe.allLocations)
    {
      if (location.isKnown == false)
      {
        continue;
      }
      if (closestLocation == null)
      {
        closestLocation = location;
      }
      if (location.distance > closestLocation.distance)
      {
        continue;
      }
      closestLocation = location;
    }
    return closestLocation;
  }
  
  // MARK: Warping -
  
  warpTo(destination)
  {
    assertArgs(arguments, 1);
    let portal = this.location;
    
    portal.pilotPort.disconnect();
    portal.thrusterPort.disconnect();
    portal.onWarp();
    if (verreciel.intercom.port.origin != null)
    {
      verreciel.intercom.port.origin.disconnect();
    }
    
    destination.isKnown = true;
    verreciel.radar.addTarget(destination);
    this.warp = destination;
    this.isWarping = true;
    this.undock();
  }

  warpUp()
  {
    assertArgs(arguments, 0);
    if (verreciel.thruster.actualSpeed < 10)
    {
      verreciel.thruster.actualSpeed += 0.025;
    }
  }
  
  warpDown()
  {
    assertArgs(arguments, 0);
    verreciel.thruster.speed = 1;
    if (verreciel.thruster.actualSpeed > 1)
    {
      verreciel.thruster.actualSpeed -= 0.1;
    }
    else
    {
      this.warpStop();
    }
  }
  
  warpStop()
  {
    assertArgs(arguments, 0);
    this.isWarping = false;
    this.warp = null;
  }
  
  // MARK: Docking -
  
  dock(newLocation)
  {
    assertArgs(arguments, 1);   
    this.location = newLocation;
    verreciel.thruster.disable();
    verreciel.helmet.addPassive("Approaching " + this.location.name);
  }
  
  docked()
  {
    assertArgs(arguments, 0);
    this.lastLocation = this.location;
    if (this.isFleeing == true)
    {
      this.isFleeing = false;
      verreciel.thruster.unlock();
    }
    this.isReturning = false;
    
    this.isDocked = true;
    this.at.copy(this.location.at);
    this.location.onDock();
    verreciel.radar.removeTarget();
    
    verreciel.helmet.addPassive("Docked at " + this.location.name);
    
    verreciel.intercom.connectToLocation(this.location);
  }
  
  undock()
  {
    assertArgs(arguments, 0);   
    this.location.onUndock();
    this.isDocked = false;
    this.location = null;
    verreciel.thruster.enable();
    verreciel.helmet.addPassive("in flight");
    verreciel.intercom.disconnectFromLocation();
  }
  
  // MARK: Fleeing -
  
  flee()
  {
    assertArgs(arguments, 0);
    this.isFleeing = true;
    verreciel.thruster.lock();
    thruster.speed = verreciel.thruster.maxSpeed();
    verreciel.radar.addTarget(this.lastLocation);
  }
  
  autoReturn()
  {
    assertArgs(arguments, 0);
    this.isReturning = true;
    verreciel.thruster.lock();
    verreciel.thruster.speed = 1;
    verreciel.radar.addTarget(this.closestKnownLocation());
  }
  
  // MARK: Custom -
  
  teleport(location)
  {
    assertArgs(arguments, 1);
    this.location = location;
    this.at.copy(this.location.at);
    this.isDocked = true;
    this.location.onDock();
    verreciel.intercom.connectToLocation(this.location);
    verreciel.radar.removeTarget();
    verreciel.helmet.addPassive("Docked at " + this.location.name);
  }
  
  isDockedAtLocation(location)
  {
    assertArgs(arguments, 1);
    return this.isDocked == true && this.location != null && this.location == location;
  }
  
  hasShield()
  {
    assertArgs(arguments, 0);
    return verreciel.shield.isPowered() == true && verreciel.shield.port.hasItemOfType(ItemTypes.shield) == true;
  }
  
  // MARK: Systems -
  
  systemsInstalledCount()
  {
    assertArgs(arguments, 0);
    var count = 0;
    for (let panel of this.panels)
    {
      if (panel.isInstalled == true)
      {
        count += 1;
      }
    }
    return count;
  }
  
  systemsCount()
  {
    assertArgs(arguments, 0);
    return this.panels.length;
  }
}
