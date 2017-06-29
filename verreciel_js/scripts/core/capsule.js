class Capsule extends Empty
{ 
  // MARK: Default -
  
  constructor()
  {
    super();
    
    console.log("^ Capsule | Init");

    this.at = verreciel.universe.loiqe_spawn.at;
    this.direction = 1;
    this.system = Systems.loiqe;
    this.shieldRoot = new Empty();
    this.radiation = 0;
    this.isWarping = false;
    this.isDocked = false;
    this.isFleeing = false;
    this.isReturning = false;
    this.panels = [];
    
    let scale = 1;
    let height = 1.5;
    
    let highNode = [
      new THREE.Vector3( 2 * scale, height, -4 * scale),
      new THREE.Vector3( 4 * scale, height, -2 * scale),
      new THREE.Vector3( 4 * scale, height,  2 * scale),
      new THREE.Vector3( 2 * scale, height,  4 * scale),
      new THREE.Vector3(-2 * scale, height,  4 * scale),
      new THREE.Vector3(-4 * scale, height,  2 * scale),
      new THREE.Vector3(-4 * scale, height, -2 * scale),
      new THREE.Vector3(-2 * scale, height, -4 * scale),
    ];
    
    Templates.left = highNode[7].x;
    Templates.right = highNode[0].x;
    Templates.top = highNode[0].y;
    Templates.bottom = -highNode[0].y;
    Templates.leftMargin = highNode[7].x * 0.8;
    Templates.rightMargin = highNode[0].x * 0.8;
    Templates.topMargin = highNode[0].y * 0.8;
    Templates.bottomMargin = -highNode[0].y * 0.8;
    Templates.radius = highNode[0].z;
    Templates.margin = Math.abs(Templates.left - Templates.leftMargin);
    
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
    this.add(panel);
    this.panels.push(panel);
  }
  
  whenStart()
  {
    super.whenStart();
    console.log("+ Capsule | Start");
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    // Docking
    
    if (this.location != null && this.isDocked != true)
    {
      
      var approachSpeed = 0.5;
      
      let distanceRatio = distanceBetweenTwoPoints(at, this.location.at)/0.5;
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
      if (warp.distance > 1.5)
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
      verreciel.helmet.addWarning("Returning", 0.1, "radiation");
      this.autoReturn();
    }
    else if (this.isFleeing == true)
    {
      verreciel.helmet.addWarning("Auto-Pilot", 0.1, "radiation");
    }
    else if (this.radiation > 0)
    {
      verreciel.helmet.addWarning("Radiation " + (radiation * 100).toFixed(1) + "%", 0.1, "radiation");
    }
  }
  
  beginAtLocation(location)
  {
    this.at = location.at;
    this.location = location;
    this.location.isKnown = true;
    this.dock(location);
    this.docked();
    verreciel.space.onSystemEnter(location.system);
  }
  
  whenSecond()
  {
    super.whenSecond();
    let cl = this.closestLocation()
    if (cl.system != null && cl.system != system)
    {
      verreciel.space.onSystemEnter(cl.system);
    }
  }
  
  closestLocation()
  {
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
    var closestLocation = null;
    for (let location in verreciel.universe.allLocations)
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
  
  warp(destination)
  {
    let portal = this.location;
    
    portal.pilotPort.disconnect();
    portal.thrusterPort.disconnect();
    portal.onWarp();
    if (verreciel.intercom.port.origin != null)
    {
      intercom.port.origin.disconnect();
    }
    
    destination.isKnown = true;
    verreciel.radar.addTarget(destination);
    this.warp = destination;
    this.isWarping = true;
    this.undock();
  }

  warpUp()
  {
    if (verreciel.thruster.actualSpeed < 10)
    {
      thruster.actualSpeed += 0.025;
    }
  }
  
  warpDown()
  {
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
    this.isWarping = false;
    this.warp = null;
  }
  
  // MARK: Docking -
  
  dock(newLocation)
  {   
    this.location = newLocation;
    verreciel.thruster.disable();
    verreciel.helmet.addPassive("Approaching " + this.location.name);
  }
  
  docked()
  {
    this.lastLocation = this.location;
    if (this.isFleeing == true)
    {
      this.isFleeing = false;
      verreciel.thruster.unlock();
    }
    this.isReturning = false;
    
    this.isDocked = true;
    this.at = this.location.at;
    this.location.onDock();
    verreciel.radar.removeTarget();
    
    verreciel.helmet.addPassive("Docked at " + this.location.name);
    
    verreciel.intercom.connectToLocation(this.location);
  }
  
  undock()
  {   
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
    this.isFleeing = true;
    verreciel.thruster.lock();
    thruster.speed = verreciel.thruster.maxSpeed();
    verreciel.radar.addTarget(this.lastLocation);
  }
  
  autoReturn()
  {
    this.isReturning = true
    thruster.lock()
    thruster.speed = 1
    radar.addTarget(this.closestKnownLocation())
  }
  
  // MARK: Custom -
  
  teleport(location)
  {
    this.location = location;
    this.at = this.location.at;
    this.isDocked = true;
    this.location.onDock();
    verreciel.intercom.connectToLocation(this.location);
    verreciel.radar.removeTarget();
    verreciel.helmet.addPassive("Docked at " + this.location.name);
  }
  
  isDockedAtLocation(location)
  {
    return this.isDocked == true && this.location != null && this.location == location;
  }
  
  hasShield()
  {
    return verreciel.shield.isPowered() == true && verreciel.shield.port.hasItemOfType(ItemTypes.shield) == true;
  }
  
  // MARK: Systems -
  
  systemsInstalledCount()
  {
    var count = 0;
    for (panel in this.panels) {
      if (panel.isInstalled == true)
      {
        count += 1;
      }
    }
    return count;
  }
  
  systemsCount()
  {
    return this.panels.length;
  }
}
