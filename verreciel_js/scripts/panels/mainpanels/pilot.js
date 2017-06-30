class Pilot extends MainPanel
{
  constructor()
  {
    super();

    this.name = "pilot";
    this.details = "aligns to locations";
    
    this.targetDirectionIndicator = new Empty();
    this.targetDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, 0.55, 0), new THREE.Vector3(0, 0.7, 0)], verreciel.white));
    this.mainNode.add(this.targetDirectionIndicator);
    
    this.activeDirectionIndicator = new Empty();
    this.activeDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, 0.4, -0.1), new THREE.Vector3(0, 0.55, -0)], verreciel.grey));
    this.mainNode.add(this.activeDirectionIndicator);
    
    this.staticDirectionIndicator = new Empty();
    this.staticDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, 0.2, -0.1), new THREE.Vector3(0, 0.4, -0)], verreciel.cyan));
    this.staticDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, -0.2, -0.1), new THREE.Vector3(0, -0.4, -0)], verreciel.red));
    this.staticDirectionIndicator.add(new SceneLine([new THREE.Vector3(0.2, 0, -0.1), new THREE.Vector3(0.4, 0, -0)], verreciel.red));
    this.staticDirectionIndicator.add(new SceneLine([new THREE.Vector3(-0.2, 0, -0.1), new THREE.Vector3(-0.4, 0, -0)], verreciel.red));
    this.mainNode.add(this.staticDirectionIndicator);
    
    this.eventsDirectionIndicator = new Empty();
    this.eventsDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, 0.2, -0.1), new THREE.Vector3(0.2, 0, -0)], verreciel.white));
    this.eventsDirectionIndicator.add(new SceneLine([new THREE.Vector3(0, 0.2, -0.1), new THREE.Vector3(-0.2, 0, -0)], verreciel.white));
    this.mainNode.add(this.eventsDirectionIndicator);
  
    this.decals.empty();
    
    this.detailsLabel.update("Ready", verreciel.grey);
  }
  
  touch(id = 0)
  {
    return true;
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    this.target = null;
    
    if (verreciel.capsule.isFleeing == true)
    {
      this.target = verreciel.capsule.lastLocation;
    }
    else if (verreciel.capsule.isReturning == true)
    {
      this.target = verreciel.capsule.closestKnownLocation();
    }
    else if (this.port.isReceivingEventOfTypeLocation())
    {
      this.target = port.origin.event;
    }
    
    if (this.target != null)
    { this.align();
    }
    else
    {
      this.detailsLabel.update("--", verreciel.grey);
    }
  }
  
  align()
  {
    let left = this.target.calculateAlignment(verreciel.capsule.direction - 0.5);
    let right = this.target.calculateAlignment(verreciel.capsule.direction + 0.5);
    
    this.target_align = Math.abs(this.target.align * 0.045) < 0.01 ? this.target.align : this.target.align * 0.045;
    
    if (left <= right)
    {
      this.turnLeft(this.target_align);
    }
    else {
      this.turnRight(this.target_align);
    }
    
    this.animate();
  }
  
  turnLeft(deg)
  {
    verreciel.capsule.direction = verreciel.capsule.direction - deg;
    verreciel.capsule.direction = verreciel.capsule.direction % 360;
  }
  
  turnRight(deg)
  {
    verreciel.capsule.direction = verreciel.capsule.direction + deg;
    verreciel.capsule.direction = verreciel.capsule.direction % 360;
  }
  
  animate()
  {
    this.targetDirectionIndicator.rotation.z = degToRad(verreciel.capsule.direction) * -1;
    this.staticDirectionIndicator.rotation.z = degToRad(verreciel.capsule.direction);
    
    if (capsule.isFleeing == true)
    {
      this.detailsLabel.update("Auto", verreciel.red);
    }
    else if (Math.abs(this.target.align) > 25)
    {
      this.detailsLabel.update(Math.abs(this.target.align).toFixed(0), verreciel.red);
    }
    else if (Math.abs(this.target.align) < 1)
    {
      this.detailsLabel.update("ok", verreciel.cyan);
    }
    else 
    {
      this.detailsLabel.update(Math.abs(this.target.align).toFixed(0), verreciel.white);
    }
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    vertices.player.lookAt(-135);
  }
}
