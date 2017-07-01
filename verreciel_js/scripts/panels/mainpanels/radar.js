class Radar extends MainPanel
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.x = 0;
    this.z = 0;
    this.overviewMode = false;
    
    this.eventPivot = new Empty();
    this.eventView = new Empty();
    
    this.name = "radar";
    this.details = "displays locations";
    
    this.mainNode.add(this.eventPivot);
    this.eventPivot.add(this.eventView);
    
    // Ship
    
    this.shipCursor = new Empty();
    this.shipCursor.add(new SceneLine([new THREE.Vector3( 0,  0.2,  0),  new THREE.Vector3( 0.2,  0,  0)], verreciel.white));
    this.shipCursor.add(new SceneLine([new THREE.Vector3( 0,  0.2,  0),  new THREE.Vector3( -0.2,  0,  0)], verreciel.white));
    this.mainNode.add(this.shipCursor);
    
    this.targetterFar = new Empty();
    this.targetterFar.add(new SceneLine([new THREE.Vector3(0.8,0,0), new THREE.Vector3(1,0,0)],  verreciel.red));
    this.targetterFar.hide();
    this.mainNode.add(this.targetterFar);
    
    // Targetter
    
    let scale = 0.3;
    let depth = 0;
    this.targetter = new Empty();
    this.targetter.add(new SceneLine([new THREE.Vector3( 0,  scale,  depth), new THREE.Vector3( scale * 0.2,  scale * 0.8,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( 0,  scale,  depth), new THREE.Vector3( -scale * 0.2,  scale * 0.8,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( 0,  -scale,  depth), new THREE.Vector3( scale * 0.2,  -scale * 0.8,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( 0,  -scale,  depth), new THREE.Vector3( -scale * 0.2,  -scale * 0.8,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( scale,  0,  depth), new THREE.Vector3( scale * 0.8,  scale * 0.2,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( scale,  0,  depth), new THREE.Vector3( scale * 0.8,  -scale * 0.2,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( -scale,  0,  depth), new THREE.Vector3( -scale * 0.8,  scale * 0.2,  depth)],  verreciel.red));
    this.targetter.add(new SceneLine([new THREE.Vector3( -scale,  0,  depth), new THREE.Vector3( -scale * 0.8,  -scale * 0.2,  depth)],  verreciel.red));
    this.targetter.hide();
    this.mainNode.add(this.targetter);
    
    this.position.set(0,0,0);
    
    this.handle = new SceneHandle(new THREE.Vector3(1,0,0),this);
    this.footer.add(this.handle);
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
  }
  
  whenRenderer()
  {
    assertArgs(arguments, 0);
    super.whenRenderer();
    
    this.eventView.position.set(verreciel.capsule.at.x * -1,verreciel.capsule.at.y * -1,0);
    
    let directionNormal = verreciel.capsule.direction/180 * -1;
    this.shipCursor.rotation.set(0, 0, Math.PI * directionNormal);
    
    this.updateTarget();
  }

  // MARK: Custom -
  
  updateTarget()
  {
    assertArgs(arguments, 0);   
    if (this.port.hasEvent() == false)
    {
      return;
    }
    
    let shipNodePosition = new THREE.Vector2(verreciel.capsule.at.x, verreciel.capsule.at.y)
    let eventNodePosition = new THREE.Vector2(this.port.event.at.x, this.port.event.at.y);
    let distanceFromShip = distanceBetweenTwoPoints(shipNodePosition, eventNodePosition);
    
    if (distanceFromShip > 2)
    {
      let angleTest = angleBetweenTwoPoints(verreciel.capsule.at, this.port.event.at, verreciel.capsule.at);
      let targetDirectionNormal = angleTest/180 * 1;
      this.targetterFar.rotation.set(0, 0, Math.PI * targetDirectionNormal);
      this.targetterFar.show();
    }
    else
    {
      this.targetter.position.set(this.port.event.at.x - verreciel.capsule.at.x,this.port.event.at.y - verreciel.capsule.at.y,0);
      this.targetterFar.hide();
    }
    
    // Targetter
    if (distanceFromShip > 2)
    {
      this.targetter.updateChildrenColors(verreciel.clear);
    }
    else if (this.port.event != verreciel.capsule.location)
    {
      this.targetter.updateChildrenColors(verreciel.red);
      this.targetter.blink();
    }
    else
    {
      this.targetter.updateChildrenColors(verreciel.grey);
      this.targetter.show();
    }
    
  }

  addTarget(event)
  {
    assertArgs(arguments, 1);
    if (verreciel.capsule.location != null && verreciel.capsule.isDocked == false)
    {
      return;
    }
    if (verreciel.capsule.isWarping == true)
    {
      return;
    }
    
    this.port.event = event;
    
    this.updateTarget();
    
    // Check for overlapping events
    for (let newEvent in verreciel.universe.allLocations)
    {
      if (newEvent.position.x == event.position.x && newEvent.position.y == event.position.y && event != newEvent)
      {
        console.log("Overlapping event:", newEvent.name, "->", event.position.x);
      }
    }
  }
  
  removeTarget()
  {
    assertArgs(arguments, 0);
    this.port.event = null;
    this.targetter.hide();
  }
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-90);
  }
  
  // MARK: Map
  
  modeNormal()
  {
    assertArgs(arguments, 0);
    this.overviewMode = false;
    
    verpilot.thruster.show();
    verpilot.pilot.show();
    verpilot.decals.show();
    verpilot.header.show();
    verpilot.footer.show();
    this.handle.show();
    
    for (let location in verpilot.universe.allLocations)
    {
      location.onRadarView();
    }
  }
  
  modeOverview()
  {
    assertArgs(arguments, 0);   
    this.overviewMode = true;
    
    verpilot.thruster.hide()
    verpilot.pilot.hide()
    verpilot.decals.hide()
    verpilot.header.hide()
    this.handle.hide();
    
    for (let location in verpilot.universe.allLocations)
    {
      location.onHelmetView()
    }
  }
}
